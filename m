Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DA3C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jul 2022 07:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiGVH3b (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jul 2022 03:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiGVH3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:29:30 -0400
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1CDC972CA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 00:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hmh2V
        SRjRLodrsAW7x5oJgozIuK5DOps7uTD8a8Stn4=; b=i0VOSoTcwBIZhDrjeMixC
        AOmtsQMh6o9ca0k1920ZyycsahgdL54mKYtT7XNTl5LEcvtWmOA1oZYGjkqHlQNT
        Ze25Dkg3YRy0ksekbyeZ4kkDPwwNAfBsmAG5jKTTMwWz+k6GwoE51uGcgijkn17w
        PZ6409zp3/7q6Wa4bKPhyc=
Received: from localhost.localdomain (unknown [112.97.59.29])
        by smtp1 (Coremail) with SMTP id GdxpCgAXJ3K8UdpiQH8YPw--.5756S2;
        Fri, 22 Jul 2022 15:29:03 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     han.xu@nxp.com, miquel.raynal@bootlin.com, vigneshr@ti.com,
        richard@nod.at
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] mtd: rawnand: gpmi: Fix typo 'the the' in comment
Date:   Fri, 22 Jul 2022 15:28:50 +0800
Message-Id: <20220722072850.72797-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgAXJ3K8UdpiQH8YPw--.5756S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWUWr1xJFWDCw45ury7Awb_yoWfGFgEgw
        nFya4xCw1UGr1qvF1SkFn8Xryjy3yFgw1UZr1FgrZIvan8GrZ3A3WDAwnFyF17uwnrC3W3
        G3Wrtw13Kw1kGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRpT5B5UUUUU==
X-Originating-IP: [112.97.59.29]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiJR9GZGAJpKX6GwAAsR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index 889e40329956..0893320d250b 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -1359,7 +1359,7 @@ static int gpmi_alloc_dma_buffer(struct gpmi_nand_data *this)
 /*
  * Handles block mark swapping.
  * It can be called in swapping the block mark, or swapping it back,
- * because the the operations are the same.
+ * because the operations are the same.
  */
 static void block_mark_swapping(struct gpmi_nand_data *this,
 				void *payload, void *auxiliary)
-- 
2.25.1

