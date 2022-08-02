Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2037EC19F2C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Aug 2022 12:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236625AbiHBMBX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Aug 2022 08:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiHBMBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 08:01:21 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFE39FCB;
        Tue,  2 Aug 2022 05:01:16 -0700 (PDT)
X-QQ-mid: bizesmtp87t1659441670twz8rg9f
Received: from kali.lan ( [125.69.43.47])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 02 Aug 2022 20:01:08 +0800 (CST)
X-QQ-SSF: 01000000000000F0U000000A0000020
X-QQ-FEAT: +ynUkgUhZJnUmHwZCmkZIChkaf5SE4MKYil7U/GOw1XlOfEtSZFPuHI3AUyOw
        ZV02BdwlJCwsJ3tIQz304UHB27P1PJXd0Yy8+xUc+u1xcReGUI+SNzFqcpHPpqmazDh1+90
        quXPzQt/tv4N3rkduxL6qS3KSjng9OYnBxFTvNdwwJj6fy7/LcSvWWJnH/1WZXDR074FcUv
        I6N/3mWpHQGnbwRdmwMKvTA7eDJmDX21MF8XN2oWpMsp7B8uLd51dtkfKQp3x+Gjni9CGfw
        JjpqVHYZKIvcYQny5ScMu7MzFPiHobuPgNNPXMnrlBSf+eZg7TkGpgT1zKWV3SZWgNjAjSU
        c6V4RzBgaRJxz68cWpXQDlAh7VOnhcCXnH4KWMUsd8M6eYIbZbncqCG8FqJ3Q==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     maz@kernel.org
Cc:     tsbogend@alpha.franken.de, fancer.lancer@gmail.com,
        tglx@linutronix.de, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] irqchip/mips-gic: Fix comment typo
Date:   Wed,  3 Aug 2022 04:01:06 +0800
Message-Id: <20220802200106.5060-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/irqchip/irq-mips-gic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 1ba0f1555c80..1a6a7a672ad7 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -494,7 +494,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	map = GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin;
 
 	/*
-	 * If adding support for more per-cpu interrupts, keep the the
+	 * If adding support for more per-cpu interrupts, keep the
 	 * array in gic_all_vpes_irq_cpu_online() in sync.
 	 */
 	switch (intr) {
-- 
2.35.1

