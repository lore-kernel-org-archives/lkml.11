Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54FBC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 28 May 2022 02:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355682AbiE1Cxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 May 2022 22:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355583AbiE1Cwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 22:52:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E62A880C6
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 19:52:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 539DFB8268C
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 02:52:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1203AC34114;
        Sat, 28 May 2022 02:52:52 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1numZP-000LR9-6U;
        Fri, 27 May 2022 22:52:51 -0400
Message-ID: <20220528025251.039864974@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 27 May 2022 22:50:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        liqiong <liqiong@nfschina.com>
Subject: [for-next][PATCH 13/23] tracing: Cleanup code by removing init "char *name"
References: <20220528025028.850906216@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: liqiong <liqiong@nfschina.com>

The pointer is assigned to "type->name" anyway. no need to
initialize with "preemption".

Link: https://lkml.kernel.org/r/20220513075221.26275-1-liqiong@nfschina.com

Signed-off-by: liqiong <liqiong@nfschina.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e38a7ca4cdd0..f400800bc910 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4276,9 +4276,7 @@ print_trace_header(struct seq_file *m, struct trace_iterator *iter)
 	struct tracer *type = iter->trace;
 	unsigned long entries;
 	unsigned long total;
-	const char *name = "preemption";
-
-	name = type->name;
+	const char *name = type->name;
 
 	get_total_entries(buf, &total, &entries);
 
-- 
2.35.1
