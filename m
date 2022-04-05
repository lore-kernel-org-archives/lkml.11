Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444CEC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 01:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1840676AbiDFBLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 21:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457563AbiDEQKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:10:48 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC7C764F;
        Tue,  5 Apr 2022 09:08:45 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 7687B22247;
        Tue,  5 Apr 2022 18:08:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1649174924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=h6X3/D3utwq+kJMZuybBLFCBUbNYycHilQpxUt5aIVA=;
        b=sb4RLOw06F2OUikWNR7VIXmVEnMHuJWPtX2SRlNJukEY65dgHr+D1emUjY3vKtAHv2GS+9
        Fj4MmL/WHm5eROQx1OqqoK+XXptio9gUyK3rZzfxlTtLJKsn8u2jd2ussYbLL6sSciesS9
        3jNOznvAHXDr16PAnTAIF88lO/HUwwg=
From:   Michael Walle <michael@walle.cc>
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tudor.Ambarus@microchip.com, Michael Walle <michael@walle.cc>
Subject: [PATCH v3 0/7] ARM: dts: lan966x: dtsi improvements and KSwitch D10 support
Date:   Tue,  5 Apr 2022 18:08:30 +0200
Message-Id: <20220405160837.4093563-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing nodes for the flexcom blocks and a node for the SGPIO
block. Then add basic support for the Kontron KSwitch D10.

Microchip, please take a closer look at the compatible strings of
the newly added nodes.

changes since v2:
 - add second kontron board variant and moved common stuff into a
   new dtsi
 - moved the uart/i2c nodes inside of the flexcom node
 - moved sgpio child nodes inside of the sgpio node

changes since v1:
 - fixed indendation
 - keep compatible, reg first, move #address-cells and #size-cells
   towards the end

Michael Walle (7):
  ARM: dts: lan966x: swap dma channels for crypto node
  ARM: dts: lan966x: add sgpio node
  ARM: dts: lan966x: add missing uart DMA channel
  ARM: dts: lan966x: add all flexcom usart nodes
  ARM: dts: lan966x: add flexcom SPI nodes
  ARM: dts: lan966x: add flexcom I2C nodes
  ARM: dts: lan966x: add basic Kontron KSwitch D10 support

 arch/arm/boot/dts/Makefile                    |   4 +-
 ...lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts |  77 ++++++
 .../lan966x-kontron-kswitch-d10-mmt-8g.dts    |  13 +
 .../dts/lan966x-kontron-kswitch-d10-mmt.dtsi  |  75 ++++++
 arch/arm/boot/dts/lan966x.dtsi                | 227 +++++++++++++++++-
 5 files changed, 392 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts
 create mode 100644 arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dts
 create mode 100644 arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi

-- 
2.30.2

