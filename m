Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63AFC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 28 May 2022 02:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355743AbiE1CyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 May 2022 22:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355616AbiE1Cw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 22:52:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FA512E312
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 19:52:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B034B82687
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 02:52:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90D3C3411E;
        Sat, 28 May 2022 02:52:52 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1numZP-000LTP-Tr;
        Fri, 27 May 2022 22:52:51 -0400
Message-ID: <20220528025251.759425831@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 27 May 2022 22:50:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Congyu Liu <liu3101@purdue.edu>
Subject: [for-next][PATCH 17/23] tracing: Disable kcov on trace_preemptirq.c
References: <20220528025028.850906216@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Congyu Liu <liu3101@purdue.edu>

Functions in trace_preemptirq.c could be invoked from early interrupt
code that bypasses kcov trace function's in_task() check. Disable kcov
on this file to reduce random code coverage.

Link: https://lkml.kernel.org/r/20220523063033.1778974-1-liu3101@purdue.edu

Acked-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Congyu Liu <liu3101@purdue.edu>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index d77cd8032213..0d261774d6f3 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -31,6 +31,10 @@ ifdef CONFIG_GCOV_PROFILE_FTRACE
 GCOV_PROFILE := y
 endif
 
+# Functions in this file could be invoked from early interrupt
+# code and produce random code coverage.
+KCOV_INSTRUMENT_trace_preemptirq.o := n
+
 CFLAGS_bpf_trace.o := -I$(src)
 
 CFLAGS_trace_benchmark.o := -I$(src)
-- 
2.35.1
