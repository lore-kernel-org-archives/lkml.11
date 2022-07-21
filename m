Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40531C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jul 2022 21:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbiGUVvw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jul 2022 17:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbiGUVvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:51:51 -0400
Received: from luna (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net [86.15.83.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C0387234
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:51:50 -0700 (PDT)
Received: from ben by luna with local (Exim 4.96)
        (envelope-from <ben@luna.fluff.org>)
        id 1oEe5E-001y0G-2Z;
        Thu, 21 Jul 2022 22:51:48 +0100
From:   Ben Dooks <ben-linux@fluff.org>
To:     linux-kernel@vger.kernel.org
Cc:     maz@kernel.org, tglx@linutronix.de, Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH] irqchip/mmp: fix missing extern init code
Date:   Thu, 21 Jul 2022 22:51:47 +0100
Message-Id: <20220721215147.468971-1-ben-linux@fluff.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions icu_init_irq and mmp2_init_icu are exported
from this code, so declare them in the header file to avoid
the following sparse warnings:

drivers/irqchip/irq-mmp.c:248:13: warning: symbol 'icu_init_irq' was not declared. Should it be static?
drivers/irqchip/irq-mmp.c:271:13: warning: symbol 'mmp2_init_icu' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 include/linux/irqchip/mmp.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/irqchip/mmp.h b/include/linux/irqchip/mmp.h
index cb8455c87c8a..aa1813749a4f 100644
--- a/include/linux/irqchip/mmp.h
+++ b/include/linux/irqchip/mmp.h
@@ -4,4 +4,7 @@
 
 extern struct irq_chip icu_irq_chip;
 
+extern void icu_init_irq(void);
+extern void mmp2_init_icu(void);
+
 #endif	/* __IRQCHIP_MMP_H */
-- 
2.35.1

