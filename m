Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901B1C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Mar 2022 02:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345686AbiCKCkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 21:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235051AbiCKCkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 21:40:06 -0500
Received: from mail.meizu.com (edge01.meizu.com [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AEE187B9D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 18:39:03 -0800 (PST)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 11 Mar
 2022 10:39:02 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Fri, 11 Mar
 2022 10:39:00 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <fei1.li@intel.com>, <hdegoede@redhat.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH] virt: fsl_hypervisor: Directly return 0 instead of using local ret variable
Date:   Fri, 11 Mar 2022 10:38:51 +0800
Message-ID: <1646966331-16813-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixes coccinelle warning:
drivers/virt/fsl_hypervisor.c:690:5-8: Unneeded variable: "ret". Return "0" on line 698

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/virt/fsl_hypervisor.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/virt/fsl_hypervisor.c b/drivers/virt/fsl_hypervisor.c
index 46ee0a0..e49bec8 100644
--- a/drivers/virt/fsl_hypervisor.c
+++ b/drivers/virt/fsl_hypervisor.c
@@ -687,15 +687,13 @@ static int fsl_hv_close(struct inode *inode, struct file *filp)
 	struct doorbell_queue *dbq = filp->private_data;
 	unsigned long flags;
 
-	int ret = 0;
-
 	spin_lock_irqsave(&db_list_lock, flags);
 	list_del(&dbq->list);
 	spin_unlock_irqrestore(&db_list_lock, flags);
 
 	kfree(dbq);
 
-	return ret;
+	return 0;
 }
 
 static const struct file_operations fsl_hv_fops = {
-- 
2.7.4

