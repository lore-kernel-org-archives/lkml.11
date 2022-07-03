Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7221C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Jul 2022 20:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbiGCUgh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Jul 2022 16:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiGCUgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 16:36:36 -0400
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr [80.12.242.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C422BE5
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 13:36:34 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 86KVoLlqSxzw286KWo30FZ; Sun, 03 Jul 2022 22:36:32 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 03 Jul 2022 22:36:32 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] habanalabs: Use the bitmap API to allocate bitmaps
Date:   Sun,  3 Jul 2022 22:36:30 +0200
Message-Id: <7112242cb741443d6abc18ebc210431f0c4ffa18.1656880577.git.christophe.jaillet@wanadoo.fr>
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
 drivers/misc/habanalabs/common/asid.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/asid.c b/drivers/misc/habanalabs/common/asid.c
index ede04c032b6e..c9c2619cc43d 100644
--- a/drivers/misc/habanalabs/common/asid.c
+++ b/drivers/misc/habanalabs/common/asid.c
@@ -11,8 +11,7 @@
 
 int hl_asid_init(struct hl_device *hdev)
 {
-	hdev->asid_bitmap = kcalloc(BITS_TO_LONGS(hdev->asic_prop.max_asid),
-					sizeof(*hdev->asid_bitmap), GFP_KERNEL);
+	hdev->asid_bitmap = bitmap_zalloc(hdev->asic_prop.max_asid, GFP_KERNEL);
 	if (!hdev->asid_bitmap)
 		return -ENOMEM;
 
@@ -27,7 +26,7 @@ int hl_asid_init(struct hl_device *hdev)
 void hl_asid_fini(struct hl_device *hdev)
 {
 	mutex_destroy(&hdev->asid_mutex);
-	kfree(hdev->asid_bitmap);
+	bitmap_free(hdev->asid_bitmap);
 }
 
 unsigned long hl_asid_alloc(struct hl_device *hdev)
-- 
2.34.1

