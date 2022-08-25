Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A93BC32774
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Aug 2022 14:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241371AbiHYO6H (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Aug 2022 10:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242308AbiHYO5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:57:50 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BFEB56F5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:57:48 -0700 (PDT)
X-QQ-mid: bizesmtp68t1661439461tuz3351z
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 25 Aug 2022 22:57:36 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: C2zsvWT0ctX+Yb5jdl4710LP4IZdplQJBM1PuptFxlGY4q34zfAg3HjKJUSb0
        Cg55bels/ntC3wwrA/Avahr29axNi4wPCgIKg+ucdotv8aRNtLP6Uy9lLwuWzSGkBhaTRZa
        RVpHuvv3ieU6HTlb24vmLqtwhdkcq/YXQ0Ku9YrTUgxAD6VTyfhOEZ8g5HSDg9onITDHvq+
        qazTkeVmPLZ+TrtmJrlcE/A+3NNShUw5Ir2qQ2jLRhhBcqG1TOJGr4Nra5sLEWYyRVwyFFr
        I78LScaBqURckHPGaykkZsYsD0fRyofo5HPs0IvIffcyT1rYWh2PI3h9DgHS+VS1fLE6oKF
        PbsT820P2OGPvC75VaNB6TiXtq6CjqaMkCbYCKoqdCOAhq9s7knD7BpUcBn4w==
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     stuyoder@gmail.com, laurentiu.tudor@nxp.com,
        linux-kernel@vger.kernel.org
Cc:     Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] bus: fsl-mc-msi: Fix comments typo
Date:   Thu, 25 Aug 2022 10:57:35 -0400
Message-Id: <20220825145735.7349-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix double word "for" in comments.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/bus/fsl-mc/fsl-mc-msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-msi.c b/drivers/bus/fsl-mc/fsl-mc-msi.c
index 0cfe859a4ac4..df3318f1a292 100644
--- a/drivers/bus/fsl-mc/fsl-mc-msi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
@@ -96,7 +96,7 @@ static void __fsl_mc_msi_write_msg(struct fsl_mc_device *mc_bus_dev,
 		}
 	} else {
 		/*
-		 * IRQ is for for a child device of mc_bus_dev
+		 * IRQ is for a child device of mc_bus_dev
 		 */
 		error = dprc_set_obj_irq(mc_bus_dev->mc_io,
 					 MC_CMD_FLAG_INTR_DIS | MC_CMD_FLAG_PRI,
-- 
2.35.1

