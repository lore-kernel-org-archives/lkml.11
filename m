Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB14EC433EF
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Jul 2022 14:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiGIOf5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Jul 2022 10:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiGIOf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 10:35:56 -0400
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr [80.12.242.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08BD19C33
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 07:35:54 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id ABYlowUsDm7vsABYloJEfy; Sat, 09 Jul 2022 16:35:53 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 09 Jul 2022 16:35:53 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        netdev@vger.kernel.org
Subject: [PATCH] net/fq_impl: Use the bitmap API to allocate bitmaps
Date:   Sat,  9 Jul 2022 16:35:50 +0200
Message-Id: <c7bf999ff07eb497202d715906ee8c11fea3b3bd.1657377335.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_bitmap_zalloc() instead of hand-writing them.

It is less verbose and it improves the semantic.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 include/net/fq_impl.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/net/fq_impl.h b/include/net/fq_impl.h
index a5f67a2c0c73..524b510f1c68 100644
--- a/include/net/fq_impl.h
+++ b/include/net/fq_impl.h
@@ -358,8 +358,7 @@ static int fq_init(struct fq *fq, int flows_cnt)
 	if (!fq->flows)
 		return -ENOMEM;
 
-	fq->flows_bitmap = kcalloc(BITS_TO_LONGS(fq->flows_cnt), sizeof(long),
-				   GFP_KERNEL);
+	fq->flows_bitmap = bitmap_zalloc(fq->flows_cnt, GFP_KERNEL);
 	if (!fq->flows_bitmap) {
 		kvfree(fq->flows);
 		fq->flows = NULL;
@@ -383,7 +382,7 @@ static void fq_reset(struct fq *fq,
 	kvfree(fq->flows);
 	fq->flows = NULL;
 
-	kfree(fq->flows_bitmap);
+	bitmap_free(fq->flows_bitmap);
 	fq->flows_bitmap = NULL;
 }
 
-- 
2.34.1

