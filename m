Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC7AC43334
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jun 2022 06:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245020AbiFOGDy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jun 2022 02:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbiFOGDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 02:03:49 -0400
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AE4DEF0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 23:03:43 -0700 (PDT)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id JCS00117;
        Wed, 15 Jun 2022 14:03:17 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201602.home.langchao.com (10.100.2.2) with Microsoft SMTP Server id
 15.1.2308.27; Wed, 15 Jun 2022 14:03:18 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bo Liu <liubo03@inspur.com>
Subject: [PATCH] eventfd: Directly use ida_alloc()/free()
Date:   Wed, 15 Jun 2022 02:03:14 -0400
Message-ID: <20220615060314.2306-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   202261514031773f4ba92ce3b66befa507376fca8f713
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ida_alloc()/ida_free() instead of
ida_simple_get()/ida_simple_remove().
The latter is deprecated and more verbose.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 fs/eventfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 3627dd7d25db..e17a2ea53da9 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -89,7 +89,7 @@ EXPORT_SYMBOL_GPL(eventfd_signal);
 static void eventfd_free_ctx(struct eventfd_ctx *ctx)
 {
 	if (ctx->id >= 0)
-		ida_simple_remove(&eventfd_ida, ctx->id);
+		ida_free(&eventfd_ida, ctx->id);
 	kfree(ctx);
 }
 
@@ -423,7 +423,7 @@ static int do_eventfd(unsigned int count, int flags)
 	init_waitqueue_head(&ctx->wqh);
 	ctx->count = count;
 	ctx->flags = flags;
-	ctx->id = ida_simple_get(&eventfd_ida, 0, 0, GFP_KERNEL);
+	ctx->id = ida_alloc(&eventfd_ida, GFP_KERNEL);
 
 	flags &= EFD_SHARED_FCNTL_FLAGS;
 	flags |= O_RDWR;
-- 
2.27.0

