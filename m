Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57EAC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 May 2022 11:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240335AbiEKLH6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 May 2022 07:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbiEKLHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 07:07:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F595AEDF
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 04:07:53 -0700 (PDT)
Date:   Wed, 11 May 2022 13:07:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652267271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cnBpG1OxW2REebVX/lgmjbtDVLff4Jk0FJGeiaRZN3s=;
        b=xgHuWHYBMLL5PoRcPsx/tdx0+K3MzokdulwTlsxRx0Ts4UdxL+o+f6kfkzVFhFPvd4kpk0
        brgEN5S3lVKUTJCAOzZcJW/tExHXoQagP8OnfRAvJZSVeRQ8fSVIPSnjCJYfTfzRYrF/yr
        OWBf1+fuB0AwTqpoxNXnghocVEWvjvHONa4TbnVmQPD/xW852Ji7GyECwNPmYMrq0M3l4q
        UICQ09IUl8EaRwYZERW61exAgfhyV4Qe9n5bv7ig+SBVOCNKy0Knlk87DzdrasNytFKCKy
        sfAsUfYdeMvw3dtOK3Ae/RWWegLKDwJVkYAqNZWduQvKRohNs3BTHOy5dNUq9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652267271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cnBpG1OxW2REebVX/lgmjbtDVLff4Jk0FJGeiaRZN3s=;
        b=Hzf1aIpRWGUyFjQG2AOli30aEAVw1f1CC3cFCxrmxZ93ANzIe2y5/VsZfW9isoyfPnnt0l
        uHZil8YCE5E82KCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] genirq/irq_sim: Make the irq_work always run in hard irq
 context.
Message-ID: <YnuZBoEVMGwKkLm+@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IRQ simulator uses irq_work to trigger an interrupt. Without the
IRQ_WORK_HARD_IRQ flag the irq_work will be performed in thread context
on PREEMPT_RT. This causes locking errors later in handle_simple_irq()
which expects to be invoked with disabled interrupts.

Triggering individual interrupts in hardirq context should not lead to
unexpected high latencies since this is also what the hardware
controller does. Also it is used as a simulator so=E2=80=A6

Use IRQ_WORK_INIT_HARD() to carry out the irq_work in hardirq context on
PREEMPT_RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/irq/irq_sim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index 0cd02efa3a742..dd76323ea3fd7 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -181,7 +181,7 @@ struct irq_domain *irq_domain_create_sim(struct fwnode_=
handle *fwnode,
 		goto err_free_bitmap;
=20
 	work_ctx->irq_count =3D num_irqs;
-	init_irq_work(&work_ctx->work, irq_sim_handle_irq);
+	work_ctx->work =3D IRQ_WORK_INIT_HARD(irq_sim_handle_irq);
=20
 	return work_ctx->domain;
=20
--=20
2.36.1

