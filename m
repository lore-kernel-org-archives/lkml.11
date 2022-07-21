Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A4ACCA479
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jul 2022 13:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiGUNn2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jul 2022 09:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiGUNmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:42:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B066E2EE;
        Thu, 21 Jul 2022 06:42:37 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7C2756601AB1;
        Thu, 21 Jul 2022 14:42:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658410955;
        bh=PxVOdo3kmX5GhVqhInInTAsKF/mvybao/JRyPYM/wN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cJNzoD20dvOfLbAiqZBy7pcLSt3Rveh1ZcqZcd4l/bAFKjUef6AExV9iPKOW0SWDh
         EuC9msbg50W57KzztU5B5Zq8h3Q8NHgF6r7CJrN7AUbqHMp5qS/aTt7x6OwkFzJnnQ
         A1Hb7rrsfrnMhR5fVFia1KYKZuuCnqnrxDiAyaEcyN/T+QVWFakRPOg6+jQKi2bR5e
         KlpsBJE0f+WNau0FKKUOVKNRvjWLYBfXkLJIsaIeWbGcFjP6mvE+Cnj4L5q1jCVdXg
         3HWcxdm/Z+sVVA2b1YSzQtxxsIHG955XyL238G29WI3q4aSk3ypuOaAF/Xdn73If5p
         cVjk6jn56XPfA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 7/8] arm64: dts: mediatek: cherry: Enable keyboard PWM backlight
Date:   Thu, 21 Jul 2022 15:42:27 +0200
Message-Id: <20220721134228.310178-8-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220721134228.310178-1-angelogioacchino.delregno@collabora.com>
References: <20220721134228.310178-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a pwm-leds node to enable the PWM controlled keyboard backlight.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index ca9955a97f8f..9086a440a995 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
 #include "mt8195.dtsi"
 #include "mt6359.dtsi"
 
@@ -31,6 +32,18 @@ dmic_codec: dmic-codec {
 		wakeup-delay-ms = <50>;
 	};
 
+	led-controller {
+		compatible = "pwm-leds";
+
+		keyboard_backlight: keyboard-backlight {
+			default-state = "off";
+			function = LED_FUNCTION_KBD_BACKLIGHT;
+			label = "cros_ec::kbd_backlight";
+			max-brightness = <1023>;
+			pwms = <&cros_ec_pwm 3>;
+		};
+	};
+
 	memory@40000000 {
 		device_type = "memory";
 		reg = <0 0x40000000 0 0x80000000>;
-- 
2.35.1

