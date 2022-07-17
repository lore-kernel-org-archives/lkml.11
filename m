Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6DCC43334
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jul 2022 12:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbiGQMMF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jul 2022 08:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbiGQML5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 08:11:57 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5436165AE;
        Sun, 17 Jul 2022 05:11:56 -0700 (PDT)
Received: from NTHCCAS01.nuvoton.com (NTHCCAS01.nuvoton.com [10.1.8.28])
        by maillog.nuvoton.com (Postfix) with ESMTP id E3CA51C809A0;
        Sun, 17 Jul 2022 20:11:55 +0800 (CST)
Received: from NTHCCAS03.nuvoton.com (10.1.20.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Sun, 17 Jul
 2022 20:11:55 +0800
Received: from NTHCCAS04.nuvoton.com (10.1.8.29) by NTHCCAS03.nuvoton.com
 (10.1.20.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1847.3; Sun, 17 Jul
 2022 20:11:55 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS04.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Sun, 17 Jul 2022 20:11:55 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 4C13B63A4C; Sun, 17 Jul 2022 15:11:54 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <jic23@kernel.org>, <minyard@acm.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <openbmc@lists.ozlabs.org>,
        <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 2/2] char: ipmi: modify NPCM KCS configuration
Date:   Sun, 17 Jul 2022 15:11:24 +0300
Message-ID: <20220717121124.154734-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220717121124.154734-1-tmaimon77@gmail.com>
References: <20220717121124.154734-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify NPCM IPMI KCS configuration to support all NPCM BMC SoC.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/char/ipmi/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/ipmi/Kconfig b/drivers/char/ipmi/Kconfig
index b061e6b513ed..39565cf74b2c 100644
--- a/drivers/char/ipmi/Kconfig
+++ b/drivers/char/ipmi/Kconfig
@@ -119,13 +119,13 @@ config ASPEED_KCS_IPMI_BMC
 	  provides the access of KCS IO space for BMC side.
 
 config NPCM7XX_KCS_IPMI_BMC
-	depends on ARCH_NPCM7XX || COMPILE_TEST
+	depends on ARCH_NPCM || COMPILE_TEST
 	select IPMI_KCS_BMC
 	select REGMAP_MMIO
-	tristate "NPCM7xx KCS IPMI BMC driver"
+	tristate "NPCM KCS IPMI BMC driver"
 	help
 	  Provides a driver for the KCS (Keyboard Controller Style) IPMI
-	  interface found on Nuvoton NPCM7xx SOCs.
+	  interface found on Nuvoton NPCM SOCs.
 
 	  The driver implements the BMC side of the KCS contorller, it
 	  provides the access of KCS IO space for BMC side.
-- 
2.33.0

