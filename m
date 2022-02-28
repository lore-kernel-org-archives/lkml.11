Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133DEC433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Feb 2022 18:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240772AbiB1SEB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Feb 2022 13:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239663AbiB1RxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:53:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB202AA2C2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:40:44 -0800 (PST)
Date:   Mon, 28 Feb 2022 17:40:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646070040;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6MRA8mvPWezaGuoP0ZtY9X0QAiWbcqEgiJIfoBnk4/I=;
        b=ixF59cL0uVn5r7KIGX5Ma8BIXtvpT/PsLamSKoFiCz7JAr7+lP/cRSZ1kAPoPCIlEf3Rzb
        7trqFYoVCFDCfdLcCF3DY9hISsaBIeDiKgPwP2aN1cyt5q7schjfmWRNiO+VGpRreIjja+
        MgU87u6JjMpEhuDVDtWCsmSwXYG2KsJ2I4dJtj70WPka3tCnReZoaiWHCZS3iKrERMPOk7
        0Q0XSC4GMtn5oRCmrvj9/UYzJw0OFRNGsbj05vR8kswd3HOOoCq3OwZQHf0Ok24IyVTrtF
        Xn40uXS/k5GV4ywWe1D3T0XOpwH1pdhm6CjHVAounVY4AT4+wOb5xbIUxr3rsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646070040;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6MRA8mvPWezaGuoP0ZtY9X0QAiWbcqEgiJIfoBnk4/I=;
        b=Wyuyb+dOvS3uVvLRgy2FAJ5pnnlh0wloK6XrURAppDtaK+UPY2bchm+gVvoAU5ywePo9GW
        9ZTfFxkHDXlYNZAA==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/qcom-pdc: Fix broken locking
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220224101226.88373-5-maz@kernel.org>
References: <20220224101226.88373-5-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <164607003952.16921.11921713857633233436.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     bd9fce2e5ea12ee82821dbc725fa4f97f9094ba1
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/bd9fce2e5ea12ee82821dbc725fa4f97f9094ba1
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 24 Feb 2022 10:12:25 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 28 Feb 2022 17:32:26 

irqchip/qcom-pdc: Fix broken locking

pdc_enable_intr() serves as a primitive to qcom_pdc_gic_{en,dis}able,
and has a raw spinlock for mutual exclusion, which is uses with
interruptible primitives.

This means that this critical section can itself be interrupted.
Should the interrupt also be a PDC interrupt, and the endpoint driver
perform an irq_disable() on that interrupt, we end-up in a deadlock.

Fix this by using the irqsave/irqrestore variants of the locking
primitives.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220224101226.88373-5-maz@kernel.org
---
 drivers/irqchip/qcom-pdc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index 837ca69..0cd20dd 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -55,17 +55,18 @@ static u32 pdc_reg_read(int reg, u32 i)
 static void pdc_enable_intr(struct irq_data *d, bool on)
 {
 	int pin_out = d->hwirq;
+	unsigned long flags;
 	u32 index, mask;
 	u32 enable;
 
 	index = pin_out / 32;
 	mask = pin_out % 32;
 
-	raw_spin_lock(&pdc_lock);
+	raw_spin_lock_irqsave(&pdc_lock, flags);
 	enable = pdc_reg_read(IRQ_ENABLE_BANK, index);
 	enable = on ? ENABLE_INTR(enable, mask) : CLEAR_INTR(enable, mask);
 	pdc_reg_write(IRQ_ENABLE_BANK, index, enable);
-	raw_spin_unlock(&pdc_lock);
+	raw_spin_unlock_irqrestore(&pdc_lock, flags);
 }
 
 static void qcom_pdc_gic_disable(struct irq_data *d)
