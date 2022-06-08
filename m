Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A6AC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jun 2022 05:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbiFHFee (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jun 2022 01:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbiFHFd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:33:27 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD35283E88
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 20:00:23 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LHsQp0vGHz16Jj7;
        Wed,  8 Jun 2022 11:00:02 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (7.185.36.111) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 8 Jun 2022 11:00:20 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 8 Jun 2022 11:00:19 +0800
From:   Ke Liu <liuke94@huawei.com>
To:     <scott.branden@broadcom.com>
CC:     <bcm-kernel-feedback-list@broadcom.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        Ke Liu <liuke94@huawei.com>
Subject: [PATCH] misc: bcm-vk: Directly use ida_alloc()/free()
Date:   Wed, 8 Jun 2022 03:19:27 +0000
Message-ID: <20220608031927.1704412-1-liuke94@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500018.china.huawei.com (7.185.36.111)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ida_alloc()/ida_free() instead of deprecated
ida_simple_get()/ida_simple_remove().

Signed-off-by: Ke Liu <liuke94@huawei.com>
---
 drivers/misc/bcm-vk/bcm_vk_dev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
index a16b99bdaa13..a3a82ebbc699 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -1401,7 +1401,7 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		bcm_vk_tty_set_irq_enabled(vk, i);
 	}
 
-	id = ida_simple_get(&bcm_vk_ida, 0, 0, GFP_KERNEL);
+	id = ida_alloc(&bcm_vk_ida, GFP_KERNEL);
 	if (id < 0) {
 		err = id;
 		dev_err(dev, "unable to get id\n");
@@ -1500,7 +1500,7 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	misc_device->name = NULL;
 
 err_ida_remove:
-	ida_simple_remove(&bcm_vk_ida, id);
+	ida_free(&bcm_vk_ida, id);
 
 err_irq:
 	for (i = 0; i < vk->num_irqs; i++)
@@ -1573,7 +1573,7 @@ static void bcm_vk_remove(struct pci_dev *pdev)
 	if (misc_device->name) {
 		misc_deregister(misc_device);
 		kfree(misc_device->name);
-		ida_simple_remove(&bcm_vk_ida, vk->devid);
+		ida_free(&bcm_vk_ida, vk->devid);
 	}
 	for (i = 0; i < vk->num_irqs; i++)
 		devm_free_irq(&pdev->dev, pci_irq_vector(pdev, i), vk);
-- 
2.25.1

