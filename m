Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44BFC433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 28 May 2022 02:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345101AbiE1Cxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 May 2022 22:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355603AbiE1Cw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 22:52:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C85D12E302;
        Fri, 27 May 2022 19:52:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED1B9B82697;
        Sat, 28 May 2022 02:52:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4D4C34113;
        Sat, 28 May 2022 02:52:52 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1numZP-000LSq-Ny;
        Fri, 27 May 2022 22:52:51 -0400
Message-ID: <20220528025251.580898616@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 27 May 2022 22:50:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Gautam Menghani <gautammenghani201@gmail.com>
Subject: [for-next][PATCH 16/23] tracing: Initialize integer variable to prevent garbage return value
References: <20220528025028.850906216@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gautam Menghani <gautammenghani201@gmail.com>

Initialize the integer variable to 0 to fix the clang scan warning:
Undefined or garbage value returned to caller
[core.uninitialized.UndefReturn]
        return ret;

Link: https://lkml.kernel.org/r/20220522061826.1751-1-gautammenghani201@gmail.com

Cc: stable@vger.kernel.org
Fixes: 8993665abcce ("tracing/boot: Support multiple handlers for per-event histogram")
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_boot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 0580287d7a0d..778200dd8ede 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -300,7 +300,7 @@ trace_boot_hist_add_handlers(struct xbc_node *hnode, char **bufp,
 {
 	struct xbc_node *node;
 	const char *p, *handler;
-	int ret;
+	int ret = 0;
 
 	handler = xbc_node_get_data(hnode);
 
-- 
2.35.1
