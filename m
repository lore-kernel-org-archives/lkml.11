Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D299C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Jul 2022 06:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237254AbiGHGo0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Jul 2022 02:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236513AbiGHGoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 02:44:24 -0400
X-Greylist: delayed 904 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Jul 2022 23:44:23 PDT
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EC94F66B;
        Thu,  7 Jul 2022 23:44:23 -0700 (PDT)
Received: from droid06.amlogic.com (10.18.11.248) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Fri, 8 Jul 2022
 14:29:16 +0800
From:   Yu Tu <yu.tu@amlogic.com>
To:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Neil Armstrong" <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     Yu Tu <yu.tu@amlogic.com>
Subject: [PATCH 0/3] Add S4 SoC clock controller driver
Date:   Fri, 8 Jul 2022 14:27:54 +0800
Message-ID: <20220708062757.3662-1-yu.tu@amlogic.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.18.11.248]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Add clock controller driver for S4 SOC.

Yu Tu (3):
  dt-bindings: clk: meson: add S4 SoC clock controller bindings
  arm64: dts: meson: add S4 Soc clock controller in DT
  clk: meson: s4: add s4 SoC clock controller driver

 .../bindings/clock/amlogic,gxbb-clkc.txt      |    1 +
 MAINTAINERS                                   |    3 +-
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi     |    9 +-
 drivers/clk/meson/Kconfig                     |   17 +
 drivers/clk/meson/Makefile                    |    1 +
 drivers/clk/meson/s4.c                        | 4678 +++++++++++++++++
 drivers/clk/meson/s4.h                        |  156 +
 include/dt-bindings/clock/s4-clkc.h           |  354 ++
 8 files changed, 5217 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/meson/s4.c
 create mode 100644 drivers/clk/meson/s4.h
 create mode 100644 include/dt-bindings/clock/s4-clkc.h


base-commit: 292dcfc1f60eee7d389d0184df4ef27be8b55077
-- 
2.33.1

