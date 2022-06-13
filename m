Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85828C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jun 2022 11:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354581AbiFMLd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jun 2022 07:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354330AbiFML3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 07:29:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE8B22B20;
        Mon, 13 Jun 2022 03:43:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98D1360F9A;
        Mon, 13 Jun 2022 10:43:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0640C34114;
        Mon, 13 Jun 2022 10:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655117001;
        bh=Z2Rg58H6WDvcZdH9B/nMDIno5SexIFF77zf26ZQUojA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rJU8tG/eP0lfvlxHI0jaQLVJvB9MmoeHYPpNT1zx7QwOPaG/aJa+PKuWf7+AFXyE7
         6CJsIpRTRmGKIjI/R9JEhNuKWysyW+4ch4sWkEo539Z5UNE9vb06QuYg19Li7gF01g
         guC1Hw+cmqfCl7xWtdgZ/DzpxvtbNP7Vy+cmxpLk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 5.4 251/411] irqchip: irq-xtensa-mx: fix initial IRQ affinity
Date:   Mon, 13 Jun 2022 12:08:44 +0200
Message-Id: <20220613094936.297010791@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220613094928.482772422@linuxfoundation.org>
References: <20220613094928.482772422@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Filippov <jcmvbkbc@gmail.com>

commit a255ee29252066d621df5d6b420bf534c6ba5bc0 upstream.

When irq-xtensa-mx chip is used in non-SMP configuration its
irq_set_affinity callback is not called leaving IRQ affinity set empty.
As a result IRQ delivery does not work in that configuration.
Initialize IRQ affinity of the xtensa MX interrupt distributor to CPU 0
for all external IRQ lines.

Cc: stable@vger.kernel.org
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/irqchip/irq-xtensa-mx.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

--- a/drivers/irqchip/irq-xtensa-mx.c
+++ b/drivers/irqchip/irq-xtensa-mx.c
@@ -151,14 +151,25 @@ static struct irq_chip xtensa_mx_irq_chi
 	.irq_set_affinity = xtensa_mx_irq_set_affinity,
 };
 
+static void __init xtensa_mx_init_common(struct irq_domain *root_domain)
+{
+	unsigned int i;
+
+	irq_set_default_host(root_domain);
+	secondary_init_irq();
+
+	/* Initialize default IRQ routing to CPU 0 */
+	for (i = 0; i < XCHAL_NUM_EXTINTERRUPTS; ++i)
+		set_er(1, MIROUT(i));
+}
+
 int __init xtensa_mx_init_legacy(struct device_node *interrupt_parent)
 {
 	struct irq_domain *root_domain =
 		irq_domain_add_legacy(NULL, NR_IRQS - 1, 1, 0,
 				&xtensa_mx_irq_domain_ops,
 				&xtensa_mx_irq_chip);
-	irq_set_default_host(root_domain);
-	secondary_init_irq();
+	xtensa_mx_init_common(root_domain);
 	return 0;
 }
 
@@ -168,8 +179,7 @@ static int __init xtensa_mx_init(struct
 	struct irq_domain *root_domain =
 		irq_domain_add_linear(np, NR_IRQS, &xtensa_mx_irq_domain_ops,
 				&xtensa_mx_irq_chip);
-	irq_set_default_host(root_domain);
-	secondary_init_irq();
+	xtensa_mx_init_common(root_domain);
 	return 0;
 }
 IRQCHIP_DECLARE(xtensa_mx_irq_chip, "cdns,xtensa-mx", xtensa_mx_init);


