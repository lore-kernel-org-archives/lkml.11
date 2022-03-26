Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EE8C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Mar 2022 19:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbiCZTmT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Mar 2022 15:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbiCZTmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 15:42:17 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0ED412E74B;
        Sat, 26 Mar 2022 12:40:40 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id E4F5A22246;
        Sat, 26 Mar 2022 20:40:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1648323635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZKJiQOoIfnoR4SoBeTOO/J+vFzjnMtA36ogD7pHyfFE=;
        b=hiCCJuqLV5S9qnCI9uFM8gL/mao1h+3FgGcseLa1IGb7UKjAhNhlF4CidvZNJkQAvD8cnh
        FvmEsBZzymbsr8DH4aMP6OsOuRuSHLhN39bzdYlLQG/rjHAOe42B45bf/BLm+FEAvPCCI8
        cwl2Cutu5cpWmxcfvJU1rUHQlHEWTUY=
From:   Michael Walle <michael@walle.cc>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] ARM: dts: lan966x: fix sys_clk frequency
Date:   Sat, 26 Mar 2022 20:40:28 +0100
Message-Id: <20220326194028.2945985-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sys_clk frequency is 165.625MHz. The register reference of the
Generic Clock controller lists the CPU clock as 600MHz, the DDR clock as
300MHz and the SYS clock as 162.5MHz. This is wrong. It was first
noticed during the fan driver development and it was measured and
verified via the CLK_MON output of the SoC which can be configured to
output sys_clk/64.

The core PLL settings (which drives the SYS clock) seems to be as
follows:
  DIVF = 52
  DIVQ = 3
  DIVR = 1

With a refernce clock of 25MHz, this means we have a post divider clock
  Fpfd = Fref / (DIVR + 1) = 25MHz / (1 + 1) = 12.5MHz

The resulting VCO frequency is then
  Fvco = Fpfd * (DIVF + 1) * 2 = 12.5MHz * (52 + 1) * 2 = 1325MHz

And the output frequency is
  Fout = Fvco / 2^DIVQ = 1325MHz / 2^3 = 165.625Mhz

This all adds up to the constrains of the PLL:
    10MHz <= Fpfd <= 200MHz
    20MHz <= Fout <= 1000MHz
  1000MHz <= Fvco <= 2000MHz

Fixes: 290deaa10c50 ("ARM: dts: add DT for lan966 SoC and 2-port board pcb8291")
Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm/boot/dts/lan966x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/lan966x.dtsi b/arch/arm/boot/dts/lan966x.dtsi
index 14c9cb3c0f3b..03045ec4aca4 100644
--- a/arch/arm/boot/dts/lan966x.dtsi
+++ b/arch/arm/boot/dts/lan966x.dtsi
@@ -38,7 +38,7 @@ clocks {
 		sys_clk: sys_clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-			clock-frequency = <162500000>;
+			clock-frequency = <165625000>;
 		};
 
 		cpu_clk: cpu_clk {
-- 
2.30.2

