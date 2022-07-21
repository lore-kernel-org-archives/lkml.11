Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F473C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jul 2022 21:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbiGUVRl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jul 2022 17:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbiGUVRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:17:36 -0400
Received: from luna (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net [86.15.83.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9290478DF8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:17:35 -0700 (PDT)
Received: from ben by luna with local (Exim 4.96)
        (envelope-from <ben@luna.fluff.org>)
        id 1oEdY2-001tWO-2j;
        Thu, 21 Jul 2022 22:17:30 +0100
From:   Ben Dooks <ben-linux@fluff.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux@armlinux.org.uk, Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH 1/3] arm: add definition of arch_irq_work_raise()
Date:   Thu, 21 Jul 2022 22:17:27 +0100
Message-Id: <20220721211729.451731-2-ben-linux@fluff.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220721211729.451731-1-ben-linux@fluff.org>
References: <20220721211729.451731-1-ben-linux@fluff.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm <asm/irq_work.h> does not define arch_irq_work_raise()
so is triggering the following sparse warning. Add a definiton
to fix this:

kernel/irq_work.c:70:13: warning: symbol 'arch_irq_work_raise' was not declared. Should it be static?
arch/arm/kernel/smp.c:582:6: warning: symbol 'arch_irq_work_raise' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/include/asm/irq_work.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/irq_work.h b/arch/arm/include/asm/irq_work.h
index 8895999834cc..3149e4dc1b54 100644
--- a/arch/arm/include/asm/irq_work.h
+++ b/arch/arm/include/asm/irq_work.h
@@ -9,4 +9,6 @@ static inline bool arch_irq_work_has_interrupt(void)
 	return is_smp();
 }
 
+extern void arch_irq_work_raise(void);
+
 #endif /* _ASM_ARM_IRQ_WORK_H */
-- 
2.35.1

