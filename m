Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7A4C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jun 2022 18:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244168AbiFMSFQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243668AbiFMSC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:02:59 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3292A19C751
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 06:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=fLUNk65jsjqLsF
        /LI/ZK5kJUX90RQrtexSRVMpT9jyo=; b=QIUZdsYv7amraMM9W40Q12xmGElR/m
        GnufIezPUagdB3u4R3fcwHxfHujc1Lbz3T3pqyz51evtv9ql7PD8bQvsvDeOqCkd
        KRjKCeJypMSqtc+8VrFcZC9ouHRwqgGK4C/ex8O+AV8p3ssbvuHaMrDkO5EcG7Uu
        0NZaICl1VuDek=
Received: (qmail 1316305 invoked from network); 13 Jun 2022 15:49:21 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Jun 2022 15:49:21 +0200
X-UD-Smtp-Session: l3s3148p1@jG8SjlThTAlZD+yY
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: renesas: spider-cpu: Enable SCIF0 on second connector
Date:   Mon, 13 Jun 2022 15:49:14 +0200
Message-Id: <20220613134914.18655-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220613134914.18655-1-wsa+renesas@sang-engineering.com>
References: <20220613134914.18655-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The schematics label it as SCIF0 debug port.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 .../arm64/boot/dts/renesas/r8a779f0-spider-cpu.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

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
-- 
2.35.1

