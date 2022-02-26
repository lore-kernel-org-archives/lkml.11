Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A6AC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Feb 2022 10:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiBZK6t (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Feb 2022 05:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiBZK6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 05:58:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5E1C2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 02:58:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C84F260C3C
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 10:58:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4FCC340E8;
        Sat, 26 Feb 2022 10:58:09 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V9 06/10] irqchip/loongson-htvec: Add suspend/resume support
Date:   Sat, 26 Feb 2022 18:53:03 +0800
Message-Id: <20220226105307.77053-7-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220226105307.77053-1-chenhuacai@loongson.cn>
References: <20220226105307.77053-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suspend/resume support for HTVEC irqchip, which is needed for
suspend/hibernation.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/irqchip/irq-loongson-htvec.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/irqchip/irq-loongson-htvec.c b/drivers/irqchip/irq-loongson-htvec.c
index 8efb00c79b55..8c63165460f9 100644
--- a/drivers/irqchip/irq-loongson-htvec.c
+++ b/drivers/irqchip/irq-loongson-htvec.c
@@ -16,6 +16,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/syscore_ops.h>
 
 /* Registers */
 #define HTVEC_EN_OFF		0x20
@@ -30,6 +31,7 @@ struct htvec {
 	struct irq_domain	*htvec_domain;
 	raw_spinlock_t		htvec_lock;
 	struct fwnode_handle	*domain_handle;
+	u32			saved_vec_en[HTVEC_MAX_PARENT_IRQ];
 };
 
 static struct htvec *htvec_priv;
@@ -157,6 +159,29 @@ static void htvec_reset(struct htvec *priv)
 	}
 }
 
+static int htvec_suspend(void)
+{
+	int i;
+
+	for (i = 0; i < htvec_priv->num_parents; i++)
+		htvec_priv->saved_vec_en[i] = readl(htvec_priv->base + HTVEC_EN_OFF + 4 * i);
+
+	return 0;
+}
+
+static void htvec_resume(void)
+{
+	int i;
+
+	for (i = 0; i < htvec_priv->num_parents; i++)
+		writel(htvec_priv->saved_vec_en[i], htvec_priv->base + HTVEC_EN_OFF + 4 * i);
+}
+
+static struct syscore_ops htvec_syscore_ops = {
+	.suspend = htvec_suspend,
+	.resume = htvec_resume,
+};
+
 static int htvec_init(phys_addr_t addr, unsigned long size,
 		int num_parents, int parent_irq[], struct fwnode_handle *domain_handle)
 {
@@ -190,6 +215,8 @@ static int htvec_init(phys_addr_t addr, unsigned long size,
 
 	htvec_priv = priv;
 
+	register_syscore_ops(&htvec_syscore_ops);
+
 	return 0;
 
 iounmap_base:
-- 
2.27.0

