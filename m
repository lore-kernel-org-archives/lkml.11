Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63843C19F29
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Aug 2022 02:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237536AbiHDCyc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Aug 2022 22:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiHDCyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 22:54:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4053E5A152
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 19:54:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE986617D5
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 02:54:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25112C433D6;
        Thu,  4 Aug 2022 02:54:26 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] irqchip/loongson-eiointc: Fix irq affinity setting
Date:   Thu,  4 Aug 2022 10:54:21 +0800
Message-Id: <20220804025421.211958-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In multi-node case, csr_any_send() should set EIOINTC_REG_ENABLE of
the first core of target node, not the first core of the whole.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/irqchip/irq-loongson-eiointc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index 80d8ca6f2d46..317467857478 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -111,11 +111,15 @@ static int eiointc_set_irq_affinity(struct irq_data *d, const struct cpumask *af
 	regaddr = EIOINTC_REG_ENABLE + ((vector >> 5) << 2);
 
 	/* Mask target vector */
-	csr_any_send(regaddr, EIOINTC_ALL_ENABLE & (~BIT(vector & 0x1F)), 0x0, 0);
+	csr_any_send(regaddr, EIOINTC_ALL_ENABLE & (~BIT(vector & 0x1F)),
+			0x0, priv->node * CORES_PER_EIO_NODE);
+
 	/* Set route for target vector */
 	eiointc_set_irq_route(vector, cpu, priv->node, &priv->node_map);
+
 	/* Unmask target vector */
-	csr_any_send(regaddr, EIOINTC_ALL_ENABLE, 0x0, 0);
+	csr_any_send(regaddr, EIOINTC_ALL_ENABLE,
+			0x0, priv->node * CORES_PER_EIO_NODE);
 
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
-- 
2.31.1

