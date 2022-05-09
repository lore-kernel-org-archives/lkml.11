Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FDBC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 May 2022 19:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240389AbiEITHm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 May 2022 15:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235698AbiEITHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 15:07:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05E3294483
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 12:03:45 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652123023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=NIOsonAWv5DdAuk0vq0Sjr+GFj0uOYtGmSbHPX0iOHw=;
        b=ExwVr8gNiMoVwLvh0/cOO0WzwT6Oc9BNbj6TAA9MlTckiCb+sbpw4sH4z2ktIm1QngzusQ
        qa5lxFwhiamuzz0jJODev0yBbadwishMPFTT1m2AEApOv82CeMLlQAeFHAcAokhl6UvHjK
        AzQ0lFV3vYSTLgoUGR0MUlXIDXZZhRbPPKRXZ+u/RHr+s6T9TwPShdwHtGBrfg9+f4sKfH
        mgsD6r0CuDn/xKCCAkP6zutOP+E7sq9iGXL9+B5NDoBfRCXtVkbblz41fNTTmCOtWRCFrV
        X6/irYPwoU7wwrmbaRROGgv5X0nXAnuv+w10bubCeM5ney9A6+9i21mrVHqjmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652123023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=NIOsonAWv5DdAuk0vq0Sjr+GFj0uOYtGmSbHPX0iOHw=;
        b=YcfPz75VQFwoueIgPKJWPPVEGHM3xa9KNLVfpsExUs/dpMt6igEwAaaOQW52uiFBpYcGHG
        NiCp7zzD5vPptXDg==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>
Subject: lockdep: Delete local_irq_enable_in_hardirq()
Date:   Mon, 09 May 2022 21:03:43 +0200
Message-ID: <8735hir0j4.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No more users and there is no desire to grow new ones.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/interrupt.h |   18 ------------------
 1 file changed, 18 deletions(-)

--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -222,24 +222,6 @@ devm_request_any_context_irq(struct devi
 
 extern void devm_free_irq(struct device *dev, unsigned int irq, void *dev_id);
 
-/*
- * On lockdep we dont want to enable hardirqs in hardirq
- * context. Use local_irq_enable_in_hardirq() to annotate
- * kernel code that has to do this nevertheless (pretty much
- * the only valid case is for old/broken hardware that is
- * insanely slow).
- *
- * NOTE: in theory this might break fragile code that relies
- * on hardirq delivery - in practice we dont seem to have such
- * places left. So the only effect should be slightly increased
- * irqs-off latencies.
- */
-#ifdef CONFIG_LOCKDEP
-# define local_irq_enable_in_hardirq()	do { } while (0)
-#else
-# define local_irq_enable_in_hardirq()	local_irq_enable()
-#endif
-
 bool irq_has_action(unsigned int irq);
 extern void disable_irq_nosync(unsigned int irq);
 extern bool disable_hardirq(unsigned int irq);
