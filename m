Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289A6C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 19:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351316AbiCOTEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 15:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351233AbiCOTEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:04:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19086522E4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:02:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 893B4616F2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BDFC340F4;
        Tue, 15 Mar 2022 19:02:45 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nUCRQ-003jjK-2t;
        Tue, 15 Mar 2022 15:02:44 -0400
Message-ID: <20220315190243.922693085@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 15 Mar 2022 15:02:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [for-next][PATCH 07/15] rtla/trace: Add trace event trigger helpers
References: <20220315190214.613102181@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@kernel.org>

Add a set of helper functions to allow rtla tools to trigger event
actions in the trace instance.

Link: https://lkml.kernel.org/r/e0d31abe879a78a5600b64f904d0dfa8f76e4fbb.1646247211.git.bristot@kernel.org

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Clark Williams <williams@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/trace.c | 88 +++++++++++++++++++++++++++++++++-
 tools/tracing/rtla/src/trace.h |  4 ++
 2 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index 9ad3d8890ec5..7f8661b2724d 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -204,6 +204,8 @@ static void trace_events_free(struct trace_events *events)
 
 		tevent = tevent->next;
 
+		if (free_event->trigger)
+			free(free_event->trigger);
 		free(free_event->system);
 		free(free_event);
 	}
@@ -235,6 +237,48 @@ struct trace_events *trace_event_alloc(const char *event_string)
 	return tevent;
 }
 
+/*
+ * trace_event_add_trigger - record an event trigger action
+ */
+int trace_event_add_trigger(struct trace_events *event, char *trigger)
+{
+	if (event->trigger)
+		free(event->trigger);
+
+	event->trigger = strdup(trigger);
+	if (!event->trigger)
+		return 1;
+
+	return 0;
+}
+
+/*
+ * trace_event_disable_trigger - disable an event trigger
+ */
+static void trace_event_disable_trigger(struct trace_instance *instance,
+					struct trace_events *tevent)
+{
+	char trigger[1024];
+	int retval;
+
+	if (!tevent->trigger)
+		return;
+
+	if (!tevent->trigger_enabled)
+		return;
+
+	debug_msg("Disabling %s:%s trigger %s\n", tevent->system,
+		  tevent->event ? : "*", tevent->trigger);
+
+	snprintf(trigger, 1024, "!%s\n", tevent->trigger);
+
+	retval = tracefs_event_file_write(instance->inst, tevent->system,
+					  tevent->event, "trigger", trigger);
+	if (retval < 0)
+		err_msg("Error disabling %s:%s trigger %s\n", tevent->system,
+			tevent->event ? : "*", tevent->trigger);
+}
+
 /*
  * trace_events_disable - disable all trace events
  */
@@ -248,14 +292,52 @@ void trace_events_disable(struct trace_instance *instance,
 
 	while (tevent) {
 		debug_msg("Disabling event %s:%s\n", tevent->system, tevent->event ? : "*");
-		if (tevent->enabled)
+		if (tevent->enabled) {
+			trace_event_disable_trigger(instance, tevent);
 			tracefs_event_disable(instance->inst, tevent->system, tevent->event);
+		}
 
 		tevent->enabled = 0;
 		tevent = tevent->next;
 	}
 }
 
+/*
+ * trace_event_enable_trigger - enable an event trigger associated with an event
+ */
+static int trace_event_enable_trigger(struct trace_instance *instance,
+				      struct trace_events *tevent)
+{
+	char trigger[1024];
+	int retval;
+
+	if (!tevent->trigger)
+		return 0;
+
+	if (!tevent->event) {
+		err_msg("Trigger %s applies only for single events, not for all %s:* events\n",
+			tevent->trigger, tevent->system);
+		return 1;
+	}
+
+	snprintf(trigger, 1024, "%s\n", tevent->trigger);
+
+	debug_msg("Enabling %s:%s trigger %s\n", tevent->system,
+		  tevent->event ? : "*", tevent->trigger);
+
+	retval = tracefs_event_file_write(instance->inst, tevent->system,
+					  tevent->event, "trigger", trigger);
+	if (retval < 0) {
+		err_msg("Error enabling %s:%s trigger %s\n", tevent->system,
+			tevent->event ? : "*", tevent->trigger);
+		return 1;
+	}
+
+	tevent->trigger_enabled = 1;
+
+	return 0;
+}
+
 /*
  * trace_events_enable - enable all events
  */
@@ -275,6 +357,10 @@ int trace_events_enable(struct trace_instance *instance,
 		}
 
 
+		retval = trace_event_enable_trigger(instance, tevent);
+		if (retval)
+			return 1;
+
 		tevent->enabled = 1;
 		tevent = tevent->next;
 	}
diff --git a/tools/tracing/rtla/src/trace.h b/tools/tracing/rtla/src/trace.h
index 9f9751f7ee36..856b26d93064 100644
--- a/tools/tracing/rtla/src/trace.h
+++ b/tools/tracing/rtla/src/trace.h
@@ -6,7 +6,9 @@ struct trace_events {
 	struct trace_events *next;
 	char *system;
 	char *event;
+	char *trigger;
 	char enabled;
+	char trigger_enabled;
 };
 
 struct trace_instance {
@@ -40,3 +42,5 @@ void trace_events_destroy(struct trace_instance *instance,
 			  struct trace_events *events);
 int trace_events_enable(struct trace_instance *instance,
 			  struct trace_events *events);
+
+int trace_event_add_trigger(struct trace_events *event, char *trigger);
-- 
2.35.1
