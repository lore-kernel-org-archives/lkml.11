Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7318CC43334
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jun 2022 19:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbiFNTaQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jun 2022 15:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbiFNTaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 15:30:11 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FD92A40E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 12:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=JYA73JAUbaXV/TVudQauMuQD88C
        teYoD72mnTRjwInY=; b=GME3YTHxGg9bGDeFoa3lM+IYcom/QK/HaEGLg+IvbXb
        UNrFU9G3+OFXiG+788L13MC/nnm+JNecYgBsKKIaIuO4vA9KzW6y7IZ1ZWJ6pBjH
        a2/sCCKKeK4RYSZgjq+vOiOmlM5gR1VjqJ3ry5t7S//sjHm9ocCbiNqOGbEC+oCM
        =
Received: (qmail 1834197 invoked from network); 14 Jun 2022 21:30:07 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 14 Jun 2022 21:30:07 +0200
X-UD-Smtp-Session: l3s3148p1@Xouhbm3h9JsgAwDtxwyXAGMY7IbT6g6m
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: renesas: spider-cpu: Enable SCIF0 on second connector
Date:   Tue, 14 Jun 2022 21:30:05 +0200
Message-Id: <20220614193005.2652-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The schematics label it as SCIF0 debug port.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Change since v1: added alias

 .../arm64/boot/dts/renesas/r8a779f0-spider-cpu.dtsi | 13 +++++++++++++
 arch/arm64/boot/dts/renesas/r8a779f0-spider.dts     |  1 +
 2 files changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a779f0-spider-cpu.dtsi b/arch/arm64/boot/dts/renesas/r8a779f0-spider-cpu.dtsi
index 3208d2148768..7a62afb64204 100644
--- a/arch/arm64/boot/dts/renesas/r8a779f0-spider-cpu.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779f0-spider-cpu.dtsi
@@ -68,6 +68,11 @@ i2c4_pins: i2c4 {
 		function = "i2c4";
 	};
 
+	scif0_pins: scif0 {
+		groups = "scif0_data", "scif0_ctrl";
+		function = "scif0";
+	};
+
 	scif_clk_pins: scif_clk {
 		groups = "scif_clk";
 		function = "scif_clk";
@@ -79,6 +84,14 @@ &rwdt {
 	status = "okay";
 };
 
+&scif0 {
+	pinctrl-0 = <&scif0_pins>;
+	pinctrl-names = "default";
+
+	uart-has-rtscts;
+	status = "okay";
+};
+
 &scif_clk {
 	clock-frequency = <24000000>;
 };
diff --git a/arch/arm64/boot/dts/renesas/r8a779f0-spider.dts b/arch/arm64/boot/dts/renesas/r8a779f0-spider.dts
index 954ba227bfa7..2c1fe4330c2b 100644
--- a/arch/arm64/boot/dts/renesas/r8a779f0-spider.dts
+++ b/arch/arm64/boot/dts/renesas/r8a779f0-spider.dts
@@ -15,6 +15,7 @@ / {
 
 	aliases {
 		serial0 = &hscif0;
+		serial1 = &scif0;
 	};
 
 	chosen {
-- 
2.35.1

