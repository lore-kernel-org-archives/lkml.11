Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A61CCA47E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jun 2022 17:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiFXR4z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jun 2022 13:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiFXR4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:56:53 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5FDA9585;
        Fri, 24 Jun 2022 10:56:51 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.92,218,1650898800"; 
   d="scan'208";a="125577364"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 25 Jun 2022 02:56:50 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 84329400F791;
        Sat, 25 Jun 2022 02:56:47 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] irqchip/sifive-plic: Make struct irq_chip const
Date:   Fri, 24 Jun 2022 18:56:39 +0100
Message-Id: <20220624175639.2677-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These should be const, so make it so.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/irqchip/irq-sifive-plic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index bb87e4c3b88e..173446cc9204 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -176,7 +176,7 @@ static void plic_irq_eoi(struct irq_data *d)
 	}
 }
 
-static struct irq_chip plic_chip = {
+static const struct irq_chip plic_chip = {
 	.name		= "SiFive PLIC",
 	.irq_mask	= plic_irq_mask,
 	.irq_unmask	= plic_irq_unmask,
-- 
2.25.1

