Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A32C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jun 2022 13:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347152AbiFONoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jun 2022 09:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346552AbiFONoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:44:15 -0400
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11DE326122
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 06:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=tXHj9
        XWBCa1d5K2tDQrGXu94LvSsJCP4E0y+hhaLTRw=; b=pr5XAKehJ1AaisOiQW5Qz
        NNyxd1cP4ArhdLQps6SfZ0MhwFsN09hpz2gyNYAADguYaeKEk2xPgbEyfQ9b5TzN
        WK1nlYPUKpok2qDSNwzEM06o+2fbnBTp5L2hqfDdeAAJMkorKPP1XuW+5mceOP6Z
        QhnoYCly93n64Wt/CurLfA=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp8 (Coremail) with SMTP id NORpCgBn5XHt4ali432nFg--.53770S2;
        Wed, 15 Jun 2022 21:43:11 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     linux@armlinux.org.uk, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        mark.rutland@arm.com, maz@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH] arch: arm: mach-imx: Add missing of_node_put() in avic.c
Date:   Wed, 15 Jun 2022 21:43:08 +0800
Message-Id: <20220615134308.3967616-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgBn5XHt4ali432nFg--.53770S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JrWkWFyUWF4fZw4kJr1UWrg_yoWkGFX_Zr
        1Sgwnrur1rAF4vvr4v9anxWrnru395Wr48tr4qvF1Ygw4avr4UArnayF97XryUWrWakFW7
        Cws3ZrW3tw47CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xREQJ5DUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi2g8hF1uwMNWzBAAAsa
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mxc_init_irq(), we need to use two of_node_put() for two
of_find_compatible_node() functions which return node pointers
with refcount incremented.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/arm/mach-imx/avic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/avic.c b/arch/arm/mach-imx/avic.c
index cf6546ddc7a3..1c9af0092a07 100644
--- a/arch/arm/mach-imx/avic.c
+++ b/arch/arm/mach-imx/avic.c
@@ -173,7 +173,7 @@ static void __init mxc_init_irq(void __iomem *irqbase)
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx25-ccm");
 	mx25_ccm_base = of_iomap(np, 0);
-
+	of_node_put(np);
 	if (mx25_ccm_base) {
 		/*
 		 * By default, we mask all interrupts. We set the actual mask
@@ -203,6 +203,7 @@ static void __init mxc_init_irq(void __iomem *irqbase)
 	np = of_find_compatible_node(NULL, NULL, "fsl,avic");
 	domain = irq_domain_add_legacy(np, AVIC_NUM_IRQS, irq_base, 0,
 				       &irq_domain_simple_ops, NULL);
+	of_node_put(np);					   
 	WARN_ON(!domain);
 
 	for (i = 0; i < AVIC_NUM_IRQS / 32; i++, irq_base += 32)
-- 
2.25.1

