Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C797DC00140
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 22:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349241AbiHOWct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 18:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350959AbiHOW1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 18:27:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321076B161;
        Mon, 15 Aug 2022 12:45:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3F99B80EB2;
        Mon, 15 Aug 2022 19:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11350C433C1;
        Mon, 15 Aug 2022 19:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660592749;
        bh=jtlJ/aF5jzgzQ3e/YRU9ZDxBgf3Qo3d8ZkJO5zUFZe0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X1DQIFdWBHIKxOcG4mLPhdWu6eo2CwmRY7g70ahFVlDn+hgkMq+xIaxgrmjLyFYX6
         hQSYG55bHNrlpl895pTP5noc3Nf5gDoN6VmfFXKf4iMgK1hmJ53LpGULA7CeDn2VtA
         NksHaqI49YAw3SVadcVvPfUMlpjY9eqj6ykVrblU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Samuel Holland <samuel@sholland.org>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.19 0159/1157] genirq: GENERIC_IRQ_IPI depends on SMP
Date:   Mon, 15 Aug 2022 19:51:55 +0200
Message-Id: <20220815180446.050699655@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815180439.416659447@linuxfoundation.org>
References: <20220815180439.416659447@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Holland <samuel@sholland.org>

[ Upstream commit 0f5209fee90b4544c58b4278d944425292789967 ]

The generic IPI code depends on the IRQ affinity mask being allocated
and initialized. This will not be the case if SMP is disabled. Fix up
the remaining driver that selected GENERIC_IRQ_IPI in a non-SMP config.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220701200056.46555-3-samuel@sholland.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/Kconfig | 2 +-
 kernel/irq/Kconfig      | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 12664ac6ac2d..6b287dc025a9 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -177,7 +177,7 @@ config MADERA_IRQ
 config IRQ_MIPS_CPU
 	bool
 	select GENERIC_IRQ_CHIP
-	select GENERIC_IRQ_IPI if SYS_SUPPORTS_MULTITHREADING
+	select GENERIC_IRQ_IPI if SMP && SYS_SUPPORTS_MULTITHREADING
 	select IRQ_DOMAIN
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
 
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 10929eda9825..fc760d064a65 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -82,6 +82,7 @@ config IRQ_FASTEOI_HIERARCHY_HANDLERS
 # Generic IRQ IPI support
 config GENERIC_IRQ_IPI
 	bool
+	depends on SMP
 	select IRQ_DOMAIN_HIERARCHY
 
 # Generic MSI interrupt support
-- 
2.35.1



