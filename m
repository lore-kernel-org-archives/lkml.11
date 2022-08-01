Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D5BC00144
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Aug 2022 08:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiHAICY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Aug 2022 04:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiHAICW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:02:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380C8FD02
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 01:02:19 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lx9W80CNJzjXnv;
        Mon,  1 Aug 2022 15:59:16 +0800 (CST)
Received: from dggpemm500016.china.huawei.com (7.185.36.25) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 1 Aug 2022 16:02:15 +0800
Received: from huawei.com (10.67.174.33) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 1 Aug
 2022 16:02:15 +0800
From:   "GONG, Ruiqi" <gongruiqi1@huawei.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <wangweiyang2@huawei.com>, <gongruiqi1@huawei.com>
Subject: [PATCH] mtd: rawnand: denali: Fix a possible resource leak in denali_pci_probe
Date:   Mon, 1 Aug 2022 16:03:15 +0800
Message-ID: <20220801080315.1713934-1-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.33]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call pci_release_regions() to retrieve the allocated resource when
devm_ioremap() or denali_init() failed.

Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
---
 drivers/mtd/nand/raw/denali_pci.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali_pci.c b/drivers/mtd/nand/raw/denali_pci.c
index de7e722d3826..40943cda0914 100644
--- a/drivers/mtd/nand/raw/denali_pci.c
+++ b/drivers/mtd/nand/raw/denali_pci.c
@@ -74,21 +74,22 @@ static int denali_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		return ret;
 	}
 
+	ret = -ENOMEM;
 	denali->reg = devm_ioremap(denali->dev, csr_base, csr_len);
 	if (!denali->reg) {
 		dev_err(&dev->dev, "Spectra: Unable to remap memory region\n");
-		return -ENOMEM;
+		goto out_release_pci;
 	}
 
 	denali->host = devm_ioremap(denali->dev, mem_base, mem_len);
 	if (!denali->host) {
 		dev_err(&dev->dev, "Spectra: ioremap failed!");
-		return -ENOMEM;
+		goto out_release_pci;
 	}
 
 	ret = denali_init(denali);
 	if (ret)
-		return ret;
+		goto out_release_pci;
 
 	nsels = denali->nbanks;
 
@@ -116,6 +117,8 @@ static int denali_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 out_remove_denali:
 	denali_remove(denali);
+out_release_pci:
+	pci_release_regions(dev);
 	return ret;
 }
 
-- 
2.25.1

