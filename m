Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79B9C433EF
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Jul 2022 15:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiGIPFy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Jul 2022 11:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiGIPFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 11:05:49 -0400
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr [80.12.242.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D904332B
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 08:05:48 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id AC1ioAmdXZfs8AC1io6k8z; Sat, 09 Jul 2022 17:05:47 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 09 Jul 2022 17:05:47 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Chas Williams <3chas3@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org
Subject: [PATCH] atm: he: Use the bitmap API to allocate bitmaps
Date:   Sat,  9 Jul 2022 17:05:45 +0200
Message-Id: <7f795bd6d5b2a00f581175b7069b229c2e5a4192.1657379127.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.

It is less verbose and it improves the semantic.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/atm/he.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/atm/he.c b/drivers/atm/he.c
index 17f44abc9418..ad91cc6a34fc 100644
--- a/drivers/atm/he.c
+++ b/drivers/atm/he.c
@@ -780,14 +780,11 @@ static int he_init_group(struct he_dev *he_dev, int group)
 		  G0_RBPS_BS + (group * 32));
 
 	/* bitmap table */
-	he_dev->rbpl_table = kmalloc_array(BITS_TO_LONGS(RBPL_TABLE_SIZE),
-					   sizeof(*he_dev->rbpl_table),
-					   GFP_KERNEL);
+	he_dev->rbpl_table = bitmap_zalloc(RBPL_TABLE_SIZE, GFP_KERNEL);
 	if (!he_dev->rbpl_table) {
 		hprintk("unable to allocate rbpl bitmap table\n");
 		return -ENOMEM;
 	}
-	bitmap_zero(he_dev->rbpl_table, RBPL_TABLE_SIZE);
 
 	/* rbpl_virt 64-bit pointers */
 	he_dev->rbpl_virt = kmalloc_array(RBPL_TABLE_SIZE,
@@ -902,7 +899,7 @@ static int he_init_group(struct he_dev *he_dev, int group)
 out_free_rbpl_virt:
 	kfree(he_dev->rbpl_virt);
 out_free_rbpl_table:
-	kfree(he_dev->rbpl_table);
+	bitmap_free(he_dev->rbpl_table);
 
 	return -ENOMEM;
 }
@@ -1578,7 +1575,7 @@ he_stop(struct he_dev *he_dev)
 	}
 
 	kfree(he_dev->rbpl_virt);
-	kfree(he_dev->rbpl_table);
+	bitmap_free(he_dev->rbpl_table);
 	dma_pool_destroy(he_dev->rbpl_pool);
 
 	if (he_dev->rbrq_base)
-- 
2.34.1

