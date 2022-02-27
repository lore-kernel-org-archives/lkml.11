Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E740EC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Feb 2022 20:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbiB0Uik (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Feb 2022 15:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiB0Uif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 15:38:35 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68A7E5AA52;
        Sun, 27 Feb 2022 12:37:58 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.90,141,1643641200"; 
   d="scan'208";a="111718866"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 28 Feb 2022 05:37:57 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id CAE3C40175FE;
        Mon, 28 Feb 2022 05:37:55 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 01/12] arm64: dts: renesas: r9a07g054: Fillup the SDHI{0,1} stub nodes
Date:   Sun, 27 Feb 2022 20:37:33 +0000
Message-Id: <20220227203744.18355-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220227203744.18355-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220227203744.18355-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fillup the SDHI{0,1} stub nodes in RZ/V2L (R9A07G054) SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 26 ++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index 3ddf0f24071c..0b0e924e28ae 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -398,13 +398,35 @@
 		};
 
 		sdhi0: mmc@11c00000  {
+			compatible = "renesas,sdhi-r9a07g054",
+				     "renesas,rcar-gen3-sdhi";
 			reg = <0x0 0x11c00000 0 0x10000>;
-			/* place holder */
+			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A07G054_SDHI0_IMCLK>,
+				 <&cpg CPG_MOD R9A07G054_SDHI0_CLK_HS>,
+				 <&cpg CPG_MOD R9A07G054_SDHI0_IMCLK2>,
+				 <&cpg CPG_MOD R9A07G054_SDHI0_ACLK>;
+			clock-names = "core", "clkh", "cd", "aclk";
+			resets = <&cpg R9A07G054_SDHI0_IXRST>;
+			power-domains = <&cpg>;
+			status = "disabled";
 		};
 
 		sdhi1: mmc@11c10000 {
+			compatible = "renesas,sdhi-r9a07g054",
+				     "renesas,rcar-gen3-sdhi";
 			reg = <0x0 0x11c10000 0 0x10000>;
-			/* place holder */
+			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A07G054_SDHI1_IMCLK>,
+				 <&cpg CPG_MOD R9A07G054_SDHI1_CLK_HS>,
+				 <&cpg CPG_MOD R9A07G054_SDHI1_IMCLK2>,
+				 <&cpg CPG_MOD R9A07G054_SDHI1_ACLK>;
+			clock-names = "core", "clkh", "cd", "aclk";
+			resets = <&cpg R9A07G054_SDHI1_IXRST>;
+			power-domains = <&cpg>;
+			status = "disabled";
 		};
 
 		eth0: ethernet@11c20000 {
-- 
2.17.1

