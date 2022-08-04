Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3021AC19F2A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Aug 2022 13:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237338AbiHDN0Q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Aug 2022 09:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbiHDN0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:26:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872F6BE3D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 06:26:05 -0700 (PDT)
Date:   Thu, 04 Aug 2022 13:26:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659619563;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=actxm17J1u9+a5S7ejW8aD7uHgzwTLbARsY1csd+A7U=;
        b=QTpLjUXRlXvsVjFfPINDQztJp/H3cNQTNtd7ux/2iNeroMnx+zoQl4iGag4sE/J7WTrUkY
        bbiu+E26vYuR76lZtu+V+fYMZwV24gsSKaCHpgNgNFJt8s8RCcE8OoaVtzUC+xciZl+czN
        lJJdCzMG6ppXANEKX1jbz+yW1tTcO/7rU2eSW2U2a7kBK5QwlYNMSbjVKZ5K+03b1A2eZE
        eELlr9dT6PXmNX9K8YpUsuGByW+u+CeL6RNmflgSUP20xnC7l8juSYn9migkhBwqhIQGtw
        EOwyBLQivRHrC61G3FcmXm9fkzgeHB7MnD995jzx1wfXi69fUgtI9Es8QZqoxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659619563;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=actxm17J1u9+a5S7ejW8aD7uHgzwTLbARsY1csd+A7U=;
        b=XIZp0qPy8cXOBT2gHnS2l474Bz/Hwd6nqMzkA0iS/D6nOXxGeeWJa6kzMHODZO/2qPd5Jx
        4HHCiZBXtqlCfZBw==
From:   "irqchip-bot for Huacai Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/loongson-eiointc: Fix a build warning
Cc:     kernel test robot <lkp@intel.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220804025457.213979-1-chenhuacai@loongson.cn>
References: <20220804025457.213979-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Message-ID: <165961956239.15455.13873160402185072060.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     54cfa910b443b3d90b3e00bd96cdf563a285390b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/54cfa910b443b3d90b3e00bd96cdf563a285390b
Author:        Huacai Chen <chenhuacai@loongson.cn>
AuthorDate:    Thu, 04 Aug 2022 10:54:57 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 04 Aug 2022 10:04:57 +01:00

irqchip/loongson-eiointc: Fix a build warning

Make acpi_get_vec_parent() be a static function, to avoid:
drivers/irqchip/irq-loongson-eiointc.c:289:20: warning: no previous prototype for 'acpi_get_vec_parent'

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220804025457.213979-1-chenhuacai@loongson.cn
---
 drivers/irqchip/irq-loongson-eiointc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index 3174678..bffb7b3 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -290,7 +290,7 @@ static void acpi_set_vec_parent(int node, struct irq_domain *parent, struct acpi
 	}
 }
 
-struct irq_domain *acpi_get_vec_parent(int node, struct acpi_vector_group *vec_group)
+static struct irq_domain *acpi_get_vec_parent(int node, struct acpi_vector_group *vec_group)
 {
 	int i;
 
