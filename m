Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227AEC433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Feb 2022 00:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240745AbiBSAzj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Feb 2022 19:55:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240709AbiBSAzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 19:55:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E303E2790A7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:55:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8000F61FD5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 00:55:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBB8C340F6;
        Sat, 19 Feb 2022 00:55:13 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nLE1p-0051YW-4M;
        Fri, 18 Feb 2022 19:55:13 -0500
Message-ID: <20220219005512.967943514@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 18 Feb 2022 19:54:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 04/16] tracing: Save both wakee and current on wakeup events
References: <20220219005430.848118506@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Use the sched_switch function to save both the wakee and the waker comms
in the saved cmdlines list when sched_wakeup is done.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_sched_switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
index e304196d7c28..5cd33be2031b 100644
--- a/kernel/trace/trace_sched_switch.c
+++ b/kernel/trace/trace_sched_switch.c
@@ -44,7 +44,7 @@ probe_sched_wakeup(void *ignore, struct task_struct *wakee)
 
 	if (!flags)
 		return;
-	tracing_record_taskinfo(current, flags);
+	tracing_record_taskinfo_sched_switch(current, wakee, flags);
 }
 
 static int tracing_sched_register(void)
-- 
2.34.1
