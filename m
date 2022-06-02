Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAA1C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jun 2022 03:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiFBD6t (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jun 2022 23:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiFBD6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 23:58:44 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E4249F15
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 20:58:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VF8nk2._1654142316;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VF8nk2._1654142316)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Jun 2022 11:58:40 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     ogabbay@kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 2/2] habanalabs: Fix kernel-doc
Date:   Thu,  2 Jun 2022 11:58:27 +0800
Message-Id: <20220602035827.18012-2-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20220602035827.18012-1-jiapeng.chong@linux.alibaba.com>
References: <20220602035827.18012-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following W=1 kernel warnings:

drivers/misc/habanalabs/common/mmu/mmu_v1.c:425: warning: expecting
prototype for hl_mmu_fini(). Prototype was for hl_mmu_v1_fini() instead.

drivers/misc/habanalabs/common/mmu/mmu_v1.c:449: warning: expecting
prototype for hl_mmu_ctx_init(). Prototype was for hl_mmu_v1_ctx_init()
instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/misc/habanalabs/common/mmu/mmu_v1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/mmu/mmu_v1.c b/drivers/misc/habanalabs/common/mmu/mmu_v1.c
index e2d91a69acc2..ad4b49281cd7 100644
--- a/drivers/misc/habanalabs/common/mmu/mmu_v1.c
+++ b/drivers/misc/habanalabs/common/mmu/mmu_v1.c
@@ -412,7 +412,7 @@ static int hl_mmu_v1_init(struct hl_device *hdev)
 }
 
 /**
- * hl_mmu_fini() - release the MMU module.
+ * hl_mmu_v1_fini() - release the MMU module.
  * @hdev: habanalabs device structure.
  *
  * This function does the following:
@@ -438,7 +438,7 @@ static void hl_mmu_v1_fini(struct hl_device *hdev)
 }
 
 /**
- * hl_mmu_ctx_init() - initialize a context for using the MMU module.
+ * hl_mmu_v1_ctx_init() - initialize a context for using the MMU module.
  * @ctx: pointer to the context structure to initialize.
  *
  * Initialize a mutex to protect the concurrent mapping flow, a hash to hold all
-- 
2.20.1.7.g153144c

