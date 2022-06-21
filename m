Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91877CCA480
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jun 2022 08:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347583AbiFUIz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jun 2022 04:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347098AbiFUIzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 04:55:24 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052EF26AE8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 01:55:16 -0700 (PDT)
X-QQ-mid: bizesmtp72t1655801711talo4mx2
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 16:55:08 +0800 (CST)
X-QQ-SSF: 0100000000700020B000B00A0000000
X-QQ-FEAT: 2jrz+7Xgw5qDVeHR0n0OiJFwquw8NwZVWIk8kZoUm/hBmndiygU7wjdMGVRPl
        mDCL3o9nJrGH48S/lLxts2iGQSKEZ4mFcZDS8lWB747TFqNU5W6ClqgJQx+mFpNCMOSyVKM
        iO+TGE+DySjoEu8CnOY6Vnq/JATsBorNtapfkXXbs8nV6szuxyMIR+4+AfKuP8kL1GEZldD
        +Hpscmmt+NCcJM28z0IlwHPX+lS2HLKjg54bXVOBosHpNCYZ4t0NkMP9KTnlRt9qyMbh2ri
        A7W0RM0vLdoKGWI48rJbimmFPqmlmdGWsmibnWP+BknrCKZBGrhJXTg2CIPttThsSRLPCIL
        l7UApevGJE4sXROWJI=
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     richard@nod.at, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, jiangjian@cdjrlc.com
Subject: [PATCH] ubi: remove unexpected word "the"
Date:   Tue, 21 Jun 2022 16:55:06 +0800
Message-Id: <20220621085506.64039-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word "the" in the comments that need to be removed

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/mtd/ubi/wl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
index 55bae06cf408..330f9ffec3a7 100644
--- a/drivers/mtd/ubi/wl.c
+++ b/drivers/mtd/ubi/wl.c
@@ -429,7 +429,7 @@ static int prot_queue_del(struct ubi_device *ubi, int pnum)
 /**
  * sync_erase - synchronously erase a physical eraseblock.
  * @ubi: UBI device description object
- * @e: the the physical eraseblock to erase
+ * @e: the physical eraseblock to erase
  * @torture: if the physical eraseblock has to be tortured
  *
  * This function returns zero in case of success and a negative error code in
-- 
2.17.1

