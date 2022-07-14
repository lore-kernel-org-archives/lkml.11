Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10DDC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jul 2022 01:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbiGNB3P (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jul 2022 21:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiGNB3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 21:29:14 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDA6B4BF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 18:29:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VJGv6Um_1657762149;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VJGv6Um_1657762149)
          by smtp.aliyun-inc.com;
          Thu, 14 Jul 2022 09:29:10 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     ogabbay@kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] habanalabs: Simplify bool conversion
Date:   Thu, 14 Jul 2022 09:29:08 +0800
Message-Id: <20220714012908.4948-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:
./drivers/misc/habanalabs/gaudi2/gaudi2.c:9727:48-53: WARNING:
conversion to bool not needed here

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 98336a1a84b0..344b4dedef41 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -9724,7 +9724,7 @@ static int gaudi2_get_mmu_base(struct hl_device *hdev, u64 mmu_id, u32 *mmu_base
 
 static void gaudi2_ack_mmu_error(struct hl_device *hdev, u64 mmu_id)
 {
-	bool is_pmmu = (mmu_id == HW_CAP_PMMU ? true : false);
+	bool is_pmmu = (mmu_id == HW_CAP_PMMU);
 	struct gaudi2_device *gaudi2 = hdev->asic_specific;
 	u32 mmu_base;
 
-- 
2.20.1.7.g153144c

