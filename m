Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED58C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Mar 2022 02:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358501AbiCQCqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Mar 2022 22:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236570AbiCQCqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 22:46:07 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE68D201B6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 19:44:51 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 17 Mar
 2022 10:44:50 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Thu, 17 Mar
 2022 10:44:49 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <benh@kernel.crashing.org>, <masahiroy@kernel.org>,
        <adobriyan@gmail.com>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        "Haowen Bai" <baihaowen@meizu.com>
Subject: [PATCH] macintosh: smu: Fix warning comparing pointer to 0
Date:   Thu, 17 Mar 2022 10:44:48 +0800
Message-ID: <1647485088-16068-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid pointer type value compared with 0 to make code clear.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/macintosh/smu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
index a4fbc3f..d72d073 100644
--- a/drivers/macintosh/smu.c
+++ b/drivers/macintosh/smu.c
@@ -1087,7 +1087,7 @@ static int smu_open(struct inode *inode, struct file *file)
 	unsigned long flags;
 
 	pp = kzalloc(sizeof(struct smu_private), GFP_KERNEL);
-	if (pp == 0)
+	if (!pp)
 		return -ENOMEM;
 	spin_lock_init(&pp->lock);
 	pp->mode = smu_file_commands;
@@ -1254,7 +1254,7 @@ static __poll_t smu_fpoll(struct file *file, poll_table *wait)
 	__poll_t mask = 0;
 	unsigned long flags;
 
-	if (pp == 0)
+	if (!pp)
 		return 0;
 
 	if (pp->mode == smu_file_commands) {
@@ -1277,7 +1277,7 @@ static int smu_release(struct inode *inode, struct file *file)
 	unsigned long flags;
 	unsigned int busy;
 
-	if (pp == 0)
+	if (!pp)
 		return 0;
 
 	file->private_data = NULL;
-- 
2.7.4

