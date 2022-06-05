Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57A9C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jun 2022 13:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350925AbiFEN4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jun 2022 09:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349337AbiFENz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 09:55:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D9C101CB;
        Sun,  5 Jun 2022 06:55:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C93B60F74;
        Sun,  5 Jun 2022 13:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27E2C3411F;
        Sun,  5 Jun 2022 13:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654437292;
        bh=/Kvdx7tqG1iNgX8ozqipv4UszZxDR7mKse1aFAlYVow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r0K5cYFHfxiIphHFNAF3NHv0FmyEml8ZXxFYlFIsDwegGvtSN9R29nYWzjUTzmXAD
         ohlya/gey8MIvlepRo2aidxHWnxOtDKv1MwM0LU9LcGil2nOYqWGld9YR48go68DzP
         vSB0+cRNqLSMZBAcPMLPXzgeVIU7D3E4gcJ2aAMfbTPPh8KeDOX8pOtMSRYnsetF0A
         qG06Pu1L/Cme1bFu9O4fDgcNfihcKP11lotwYUw/9Py7wxRZObzGglbrxzCq7BGMLu
         szkDACs86JEkRJ2f49tVHlN5xJb96+kr+ncP5GEAvU97ln6UM/djHhJvvDZZpYkD/Z
         tcNGSf7ATpumg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH MANUALSEL 5.10 2/5] genirq/irq_sim: Make the irq_work always run in hard irq context
Date:   Sun,  5 Jun 2022 09:54:41 -0400
Message-Id: <20220605135447.61611-2-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220605135447.61611-1-sashal@kernel.org>
References: <20220605135447.61611-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 21673fcb2532dcd189905ff5a5389eb7dcd0e57a ]

The IRQ simulator uses irq_work to trigger an interrupt. Without the
IRQ_WORK_HARD_IRQ flag the irq_work will be performed in thread context
on PREEMPT_RT. This causes locking errors later in handle_simple_irq()
which expects to be invoked with disabled interrupts.

Triggering individual interrupts in hardirq context should not lead to
unexpected high latencies since this is also what the hardware
controller does. Also it is used as a simulator so...

Use IRQ_WORK_INIT_HARD() to carry out the irq_work in hardirq context on
PREEMPT_RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/YnuZBoEVMGwKkLm+@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/irq/irq_sim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index 48006608baf0..1b7e823cb7bb 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -185,7 +185,7 @@ struct irq_domain *irq_domain_create_sim(struct fwnode_handle *fwnode,
 		goto err_free_bitmap;
 
 	work_ctx->irq_count = num_irqs;
-	init_irq_work(&work_ctx->work, irq_sim_handle_irq);
+	work_ctx->work = IRQ_WORK_INIT_HARD(irq_sim_handle_irq);
 
 	return work_ctx->domain;
 
-- 
2.35.1

