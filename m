Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C800C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jul 2022 13:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbiGRNPP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jul 2022 09:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbiGRNPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:15:10 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563DE25B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:15:04 -0700 (PDT)
X-QQ-mid: bizesmtp77t1658150099tdrpbhwo
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 21:14:58 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000C00A0000020
X-QQ-FEAT: e3eLb0+LQTlJiu85ZTDmOaG3RbOwRZcFxywT2fN7gOhJ3V8EdK4ejdHlOOvOV
        rTwXwBBYqhZzu2bk5tCz7NDs30XqQN+b4IQTdj+9PbZQa23tIoPCw0HR3aQJ9x44ZnGAO1P
        D7P8a3DRZdi0fy2cXzvYAOsn/DS9DjIn+ZaXBeA+NzsymMZbJUwRMJzvzVztM1YUHMr1vye
        BpHt19tPAWNqouNc/YfJUCFPhrzeSpW6Bt3IdBjUblQu1PZprrcliYF4fqh1mndH2+HGw2J
        3WaBkC0dEG7yNKZel9fHbVwtbbueds3PuMW0i7Apr2Kx5hsGXykrm9o18aIw0EMkrvQWoWk
        8UknB4KqEt1Y8io8iBQ6aZVKTDv5/6ntAlajFDa6rry64N+WmXBb4THuyUO5acuL+gtbmE/
        iX6Lb0vtr0c=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     maz@kernel.org
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] irqchip/gic-v3: Fix comment typo
Date:   Fri, 15 Jul 2022 13:12:58 +0800
Message-Id: <20220715051258.28889-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' is duplicated in line 1786, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/irqchip/irq-gic-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 2d25bca63d2a..65c27d1919eb 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1783,7 +1783,7 @@ static void gic_enable_nmi_support(void)
 	 * the security state of the GIC (controlled by the GICD_CTRL.DS bit)
 	 * and if Group 0 interrupts can be delivered to Linux in the non-secure
 	 * world as FIQs (controlled by the SCR_EL3.FIQ bit). These affect the
-	 * the ICC_PMR_EL1 register and the priority that software assigns to
+	 * ICC_PMR_EL1 register and the priority that software assigns to
 	 * interrupts:
 	 *
 	 * GICD_CTRL.DS | SCR_EL3.FIQ | ICC_PMR_EL1 | Group 1 priority
-- 
2.35.1

