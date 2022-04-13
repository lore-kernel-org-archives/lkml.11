Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB23C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Apr 2022 07:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbiDMHEQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Apr 2022 03:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiDMHEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 03:04:14 -0400
Received: from out199-8.us.a.mail.aliyun.com (out199-8.us.a.mail.aliyun.com [47.90.199.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002671CFF9;
        Wed, 13 Apr 2022 00:01:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yaohongbo@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V9yQk.8_1649833302;
Received: from localhost(mailfrom:yaohongbo@linux.alibaba.com fp:SMTPD_---0V9yQk.8_1649833302)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 13 Apr 2022 15:01:50 +0800
From:   Yao Hongbo <yaohongbo@linux.alibaba.com>
To:     mst@redhat.com, gregkh@linuxfoundation.org
Cc:     yaohongbo@linux.alibaba.com, alikernel-developer@linux.alibaba.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] uio/uio_pci_generic: Introduce refcnt on open/release
Date:   Wed, 13 Apr 2022 15:01:42 +0800
Message-Id: <1649833302-27299-1-git-send-email-yaohongbo@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If two userspace programs both open the PCI UIO fd, when one
of the program exits uncleanly, the other will cause IO hang
due to bus-mastering disabled.

It's a common usage for spdk/dpdk to use UIO. So, introduce refcnt
to avoid such problems.

Fixes: 865a11f987ab("uio/uio_pci_generic: Disable bus-mastering on release")
Reported-by: Xiu Yang <yangxiu.yx@alibaba-inc.com>
Signed-off-by: Yao Hongbo <yaohongbo@linux.alibaba.com>
---
Changes for v2:
	Use refcount_t instead of atomic_t to catch overflow/underflows.
---
 drivers/uio/uio_pci_generic.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/uio/uio_pci_generic.c b/drivers/uio/uio_pci_generic.c
index e03f9b5..1a5e1fd 100644
--- a/drivers/uio/uio_pci_generic.c
+++ b/drivers/uio/uio_pci_generic.c
@@ -31,6 +31,7 @@
 struct uio_pci_generic_dev {
 	struct uio_info info;
 	struct pci_dev *pdev;
+	refcount_t refcnt;
 };
 
 static inline struct uio_pci_generic_dev *
@@ -39,6 +40,14 @@ struct uio_pci_generic_dev {
 	return container_of(info, struct uio_pci_generic_dev, info);
 }
 
+static int open(struct uio_info *info, struct inode *inode)
+{
+	struct uio_pci_generic_dev *gdev = to_uio_pci_generic_dev(info);
+
+	refcount_inc(&gdev->refcnt);
+	return 0;
+}
+
 static int release(struct uio_info *info, struct inode *inode)
 {
 	struct uio_pci_generic_dev *gdev = to_uio_pci_generic_dev(info);
@@ -51,7 +60,9 @@ static int release(struct uio_info *info, struct inode *inode)
 	 * Note that there's a non-zero chance doing this will wedge the device
 	 * at least until reset.
 	 */
-	pci_clear_master(gdev->pdev);
+	if (refcount_dec_and_test(&gdev->refcnt))
+		pci_clear_master(gdev->pdev);
+
 	return 0;
 }
 
@@ -92,8 +103,11 @@ static int probe(struct pci_dev *pdev,
 
 	gdev->info.name = "uio_pci_generic";
 	gdev->info.version = DRIVER_VERSION;
+	gdev->info.open = open;
 	gdev->info.release = release;
 	gdev->pdev = pdev;
+	refcount_set(&gdev->refcnt, 0);
+
 	if (pdev->irq && (pdev->irq != IRQ_NOTCONNECTED)) {
 		gdev->info.irq = pdev->irq;
 		gdev->info.irq_flags = IRQF_SHARED;
-- 
1.8.3.1

