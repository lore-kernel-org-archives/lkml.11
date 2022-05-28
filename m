Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8393C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 28 May 2022 02:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353125AbiE1CyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 May 2022 22:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355620AbiE1Cw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 22:52:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D2812E326
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 19:52:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F02E1B82688
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 02:52:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA9DC34118;
        Sat, 28 May 2022 02:52:53 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1numZQ-000LWD-Qm;
        Fri, 27 May 2022 22:52:52 -0400
Message-ID: <20220528025252.654913891@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 27 May 2022 22:50:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        sunliming <sunliming@kylinos.cn>
Subject: [for-next][PATCH 22/23] tracing: Fix comments for event_trigger_separate_filter()
References: <20220528025028.850906216@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: sunliming <sunliming@kylinos.cn>

The parameter name in comments of event_trigger_separate_filter() is
inconsistent with actual parameter name, fix it.

Link: https://lkml.kernel.org/r/20220526072957.165655-1-sunliming@kylinos.cn

Signed-off-by: sunliming <sunliming@kylinos.cn>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_trigger.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 21592bed2e89..cb866c3141af 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -738,15 +738,15 @@ bool event_trigger_empty_param(const char *param)
 
 /**
  * event_trigger_separate_filter - separate an event trigger from a filter
- * @param: The param string containing trigger and possibly filter
- * @trigger: outparam, will be filled with a pointer to the trigger
+ * @param_and_filter: String containing trigger and possibly filter
+ * @param: outparam, will be filled with a pointer to the trigger
  * @filter: outparam, will be filled with a pointer to the filter
  * @param_required: Specifies whether or not the param string is required
  *
  * Given a param string of the form '[trigger] [if filter]', this
  * function separates the filter from the trigger and returns the
- * trigger in *trigger and the filter in *filter.  Either the *trigger
- * or the *filter may be set to NULL by this function - if not set to
+ * trigger in @param and the filter in @filter.  Either the @param
+ * or the @filter may be set to NULL by this function - if not set to
  * NULL, they will contain strings corresponding to the trigger and
  * filter.
  *
-- 
2.35.1
