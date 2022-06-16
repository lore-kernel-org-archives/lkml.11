Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76323C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jun 2022 15:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377721AbiFPPBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jun 2022 11:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377684AbiFPPBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:01:17 -0400
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80DBD3DA5A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=84+Pu
        5fnKooo8qCA8FiEHjFCWoachPuybfQHB/YT+D4=; b=Js2gilubOdDxh+PD8PWF3
        YqzMmab94jo7Bzhp09vLZkmKEnuMlQBZPUARqUsIHwfR/i0YBgsISxpgIcTSQOA7
        v/b5L0p4NE6mirAZNW49dGm32dKEt+HTy8xZqwnc2oS9s5DKgpTpa+gyciVdxoCQ
        PZtd1slQAPnQ2QXMMcMQr0=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp8 (Coremail) with SMTP id NORpCgBXxHCARatitiMWFw--.50124S2;
        Thu, 16 Jun 2022 23:00:16 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     linux@armlinux.org.uk, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Cc:     windhl@126.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm: mach-imx: Fix refcount leak in mm-imx3.c
Date:   Thu, 16 Jun 2022 23:00:15 +0800
Message-Id: <20220616150015.3988416-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgBXxHCARatitiMWFw--.50124S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF4UXry8JryrKry3KF4xCrg_yoW3WFc_ZF
        4SgwnrJr4rCF4vvr1Uuw4fKa12va1rCFs8Ww1jy3WDtwsIvF17CrsFvFyIqa45Gw43KrW5
        ArWkuF4Yy34akjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUj1rW7UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi3AAiF1pEDu8btAAAs5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In imx31_init_early(), of_find_compatible_node() will return a
node pointer with refcount incremented. We should use of_node_put()
when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/arm/mach-imx/mm-imx3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
index 28db97289ee8..0944ffb08f40 100644
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@ -107,6 +107,7 @@ void __init imx31_init_early(void)
 	arm_pm_idle = imx31_idle;
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx31-ccm");
 	mx3_ccm_base = of_iomap(np, 0);
+	of_node_put(np);
 	BUG_ON(!mx3_ccm_base);
 }
 #endif /* ifdef CONFIG_SOC_IMX31 */
-- 
2.25.1

