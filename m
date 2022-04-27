Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18058C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Apr 2022 19:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiD0TlP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Apr 2022 15:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbiD0Tj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:39:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF7210B1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 12:36:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71E2361BA7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 19:36:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFACC385A7;
        Wed, 27 Apr 2022 19:36:43 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1njnSs-002IwX-CX;
        Wed, 27 Apr 2022 15:36:42 -0400
Message-ID: <20220427193642.218154566@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Apr 2022 15:36:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [for-next][PATCH 15/21] tracing: Return -EINVAL if WARN_ON(!glob) triggered in
 event_hist_trigger_parse()
References: <20220427193623.529296556@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

If `WARN_ON(!glob)` is ever triggered, we will still continue executing
the next lines. This will trigger the more serious problem, a NULL
pointer dereference bug.

Just return -EINVAL if @glob is NULL.

Link: https://lkml.kernel.org/r/20220417185630.199062-2-ammarfaizi2@gnuweeb.org

Cc: Ingo Molnar <mingo@redhat.com>
Cc: GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 998dfe2162fc..80c25be23c45 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6214,7 +6214,8 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 
 	lockdep_assert_held(&event_mutex);
 
-	WARN_ON(!glob);
+	if (WARN_ON(!glob))
+		return -EINVAL;
 
 	if (strlen(glob)) {
 		hist_err_clear();
-- 
2.35.1
