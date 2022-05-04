Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C8EC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 May 2022 16:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353258AbiEDQTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 May 2022 12:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353241AbiEDQSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 12:18:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFC960F9
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 09:15:14 -0700 (PDT)
Date:   Wed, 04 May 2022 16:15:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651680912;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TX7v4hj9OaboXJwRxyI6gRUapltS3uSk8jyNNtPJD38=;
        b=kpuz8ztUsk1yQ446W8IHJr0Ovz5YBumzWb7vQGx9KDqNhaGeAXj8CtUYxnzLBBfOmAH8/N
        znSChCs/o82uhgldImKAb11T82aUaSyPKDa/JRnHDnZM/kpZ7ZEys80jkVqo2bdAZFVhvs
        5cFu3d7TjcJ8ij0cxSJhZjiTa7KgRPknUeP7Jq73o5W0hXNsj9E9dvqqXQSL1EWroYUU8o
        09hgwEiW8vk59EIUc3IWGZsFJV+1Y0TDZA4MYZjntgpX1csVhyS540j7GzmMsFPWYA+srb
        daVRawl0AgcprC4D5vctX4mI4wqnr5HKDz7xRzyVCuK4Bd7HgALfQUu47Q3CXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651680912;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TX7v4hj9OaboXJwRxyI6gRUapltS3uSk8jyNNtPJD38=;
        b=RyLVAzd5JuFMnm9kwwOt1Pic3KC1BvC66uh5eKcbTq3uVkq6czBSOTgUTJLU9l1X0igfaU
        ZB9d8tpdHrxX7EAw==
From:   "irqchip-bot for Krzysztof Kozlowski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/aspeed-i2c-ic: Fix
 irq_of_parse_and_map() return value
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220423094227.33148-1-krzysztof.kozlowski@linaro.org>
References: <20220423094227.33148-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Message-ID: <165168091171.4207.2648485341922184325.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     50f0f26e7c8665763d0d7d3372dbcf191f94d077
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/50f0f26e7c8665763d0d7d3372dbcf191f94d077
Author:        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
AuthorDate:    Sat, 23 Apr 2022 11:42:26 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 04 May 2022 16:37:48 +01:00

irqchip/aspeed-i2c-ic: Fix irq_of_parse_and_map() return value

The irq_of_parse_and_map() returns 0 on failure, not a negative ERRNO.

Fixes: f48e699ddf70 ("irqchip/aspeed-i2c-ic: Add I2C IRQ controller for Aspeed")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220423094227.33148-1-krzysztof.kozlowski@linaro.org
---
 drivers/irqchip/irq-aspeed-i2c-ic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-aspeed-i2c-ic.c b/drivers/irqchip/irq-aspeed-i2c-ic.c
index a47db16..9c9fc3e 100644
--- a/drivers/irqchip/irq-aspeed-i2c-ic.c
+++ b/drivers/irqchip/irq-aspeed-i2c-ic.c
@@ -77,8 +77,8 @@ static int __init aspeed_i2c_ic_of_init(struct device_node *node,
 	}
 
 	i2c_ic->parent_irq = irq_of_parse_and_map(node, 0);
-	if (i2c_ic->parent_irq < 0) {
-		ret = i2c_ic->parent_irq;
+	if (!i2c_ic->parent_irq) {
+		ret = -EINVAL;
 		goto err_iounmap;
 	}
 
