Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DAFC43334
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jul 2022 09:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbiGTJFM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jul 2022 05:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbiGTJFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 05:05:08 -0400
Received: from m12-15.163.com (m12-15.163.com [220.181.12.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3700A245
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 02:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=GDF/E
        7WqRUk5DIFmfUxr9+y55qjYw3uJMgUd25WZZDc=; b=RWvBcqn9EFvsfY0yw5E7M
        UqK3YlkiZtLrlt8F5bnD8Q4Jky8mArLyTP8iZPfrWpiUv5OzH8cemoQFJrNAThAi
        YFh6Hd4Uo5PiMsDOAW9ayMjyi1JqOXvyEqbUmeb8uWPhb0krlFPpBN0pSd/Uq/An
        mgX2p9/4alXK042UQAyAPA=
Received: from localhost.localdomain (unknown [223.104.68.229])
        by smtp11 (Coremail) with SMTP id D8CowABHhV_mxNdiybcTAA--.26S2;
        Wed, 20 Jul 2022 17:03:39 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     richard@nod.at, miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] ubi: block: Fix typo
Date:   Wed, 20 Jul 2022 17:03:31 +0800
Message-Id: <20220720090331.13691-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowABHhV_mxNdiybcTAA--.26S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjfUjPfQUUUUU
X-Originating-IP: [223.104.68.229]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiJQtEZGAJpI5YlQAAsA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove typo.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/mtd/ubi/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index 4cf67a2a0d04..4fc7e756d885 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -409,7 +409,7 @@ int ubiblock_create(struct ubi_volume_info *vi)
 	ret = blk_mq_alloc_tag_set(&dev->tag_set);
 	if (ret) {
 		dev_err(disk_to_dev(dev->gd), "blk_mq_alloc_tag_set failed");
-		goto out_free_dev;;
+		goto out_free_dev;
 	}
 
 
-- 
2.25.1

