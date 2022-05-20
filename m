Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB7AC433FE
	for <linux-kernel@archiver.kernel.org>; Fri, 20 May 2022 08:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347366AbiETItd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 May 2022 04:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241770AbiETItU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:49:20 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4BEC1EF5;
        Fri, 20 May 2022 01:49:18 -0700 (PDT)
Received: from kwepemi500023.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L4L2w3fBTz1J9jS;
        Fri, 20 May 2022 16:47:52 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500023.china.huawei.com
 (7.221.188.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 20 May
 2022 16:49:15 +0800
From:   Peng Wu <wupeng58@huawei.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <christophe.jaillet@wanadoo.fr>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <liwei391@huawei.com>,
        <wupeng58@huawei.com>
Subject: [PATCH v2] mtd: rawnand: cafe: fix drivers probe/remove methods
Date:   Fri, 20 May 2022 08:44:25 +0000
Message-ID: <20220520084425.116686-1-wupeng58@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500023.china.huawei.com (7.221.188.76)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver should call pci_disable_device() if it returns from
cafe_nand_probe() with error.

Meanwhile, the driver calls pci_enable_device() in
cafe_nand_probe(), but never calls pci_disable_device()
during removal.

Signed-off-by: Peng Wu <wupeng58@huawei.com>
---
v2:
- fix the subject prefix with "mtd: ranwnand: cafe:"
---
 drivers/mtd/nand/raw/cafe_nand.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/cafe_nand.c b/drivers/mtd/nand/raw/cafe_nand.c
index 9dbf031716a6..af119e376352 100644
--- a/drivers/mtd/nand/raw/cafe_nand.c
+++ b/drivers/mtd/nand/raw/cafe_nand.c
@@ -679,8 +679,10 @@ static int cafe_nand_probe(struct pci_dev *pdev,
 	pci_set_master(pdev);
 
 	cafe = kzalloc(sizeof(*cafe), GFP_KERNEL);
-	if (!cafe)
-		return  -ENOMEM;
+	if (!cafe) {
+		err = -ENOMEM;
+		goto out_disable_device;
+	}
 
 	mtd = nand_to_mtd(&cafe->nand);
 	mtd->dev.parent = &pdev->dev;
@@ -801,6 +803,8 @@ static int cafe_nand_probe(struct pci_dev *pdev,
 	pci_iounmap(pdev, cafe->mmio);
  out_free_mtd:
 	kfree(cafe);
+ out_disable_device:
+	pci_disable_device(pdev);
  out:
 	return err;
 }
@@ -822,6 +826,7 @@ static void cafe_nand_remove(struct pci_dev *pdev)
 	pci_iounmap(pdev, cafe->mmio);
 	dma_free_coherent(&cafe->pdev->dev, 2112, cafe->dmabuf, cafe->dmaaddr);
 	kfree(cafe);
+	pci_disable_device(pdev);
 }
 
 static const struct pci_device_id cafe_nand_tbl[] = {
-- 
2.17.1

