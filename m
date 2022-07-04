Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9C2C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Jul 2022 00:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbiGDAWY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Jul 2022 20:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbiGDAWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 20:22:03 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4AED86330;
        Sun,  3 Jul 2022 17:21:49 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 04 Jul 2022 09:21:38 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id ED4022011964;
        Mon,  4 Jul 2022 09:21:37 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 4 Jul 2022 09:21:38 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id BE8CE1DDD;
        Mon,  4 Jul 2022 09:21:37 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 0/9] Update UniPhier armv8 devicetree
Date:   Mon,  4 Jul 2022 09:21:05 +0900
Message-Id: <1656894074-15751-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update devicetree sources for UniPhier armv8 SoCs to remove dtschema
warnings, add support existing features that haven't yet been
described, and replace constants with macros.

Kunihiko Hayashi (9):
  arm64: dts: uniphier: Fix USB interrupts for PXs3 SoC
  arm64: dts: uniphier: Rename pvtctl node to thermal-sensor
  arm64: dts: uniphier: Rename usb-phy node to usb-glue
  arm64: dts: uniphier: Rename gpio-hog nodes
  arm64: dts: uniphier: Use GIC interrupt definitions
  arm64: dts: uniphier: Add ahci controller and glue layer nodes for
    PXs3
  arm64: dts: uniphier: Add USB-device support for PXs3 reference board
  arm64: dts: uniphier: Fix opp-table node name for LD20
  arm64: dts: uniphier: Remove compatible "snps,dw-pcie" from pcie node

 arch/arm/boot/dts/uniphier-pinctrl.dtsi       |  10 ++
 arch/arm64/boot/dts/socionext/Makefile        |   4 +-
 .../boot/dts/socionext/uniphier-ld11-ref.dts  |   6 +-
 .../boot/dts/socionext/uniphier-ld11.dtsi     |  53 +++----
 .../dts/socionext/uniphier-ld20-akebi96.dts   |   6 +-
 .../boot/dts/socionext/uniphier-ld20-ref.dts  |   6 +-
 .../boot/dts/socionext/uniphier-ld20.dtsi     |  68 +++++----
 .../socionext/uniphier-pxs3-ref-gadget0.dts   |  41 +++++
 .../socionext/uniphier-pxs3-ref-gadget1.dts   |  40 +++++
 .../boot/dts/socionext/uniphier-pxs3-ref.dts  |  14 +-
 .../boot/dts/socionext/uniphier-pxs3.dtsi     | 144 ++++++++++++++----
 11 files changed, 289 insertions(+), 103 deletions(-)
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-pxs3-ref-gadget0.dts
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-pxs3-ref-gadget1.dts

-- 
2.25.1

