Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A10C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Jul 2022 10:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238088AbiGHKwv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Jul 2022 06:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237850AbiGHKwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 06:52:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65A1B84EFE;
        Fri,  8 Jul 2022 03:52:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DA7A1655;
        Fri,  8 Jul 2022 03:52:48 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A16CD3F70D;
        Fri,  8 Jul 2022 03:52:46 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v13 2/7] dt-bindings: pinctrl: sunxi: Make interrupts optional
Date:   Fri,  8 Jul 2022 11:52:30 +0100
Message-Id: <20220708105235.3983266-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708105235.3983266-1-andre.przywara@arm.com>
References: <20220708105235.3983266-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The R_PIO pinctrl device on the Allwinner H616 SoC does not have an
interrupt (it features only two pins).
However the binding requires at least naming one upstream interrupt,
plus the #interrupt-cells and interrupt-controller properties.

Drop the unconditional requirement for the interrupt properties, and
make them dependent on being not this particular pinctrl device.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Samuel Holland <samuel@sholland.org>
---
 .../pinctrl/allwinner,sun4i-a10-pinctrl.yaml     | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
index bfce850c20351..360dcd757e9da 100644
--- a/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
@@ -133,14 +133,11 @@ patternProperties:
 
 required:
   - "#gpio-cells"
-  - "#interrupt-cells"
   - compatible
   - reg
-  - interrupts
   - clocks
   - clock-names
   - gpio-controller
-  - interrupt-controller
 
 allOf:
   # FIXME: We should have the pin bank supplies here, but not a lot of
@@ -148,6 +145,19 @@ allOf:
   # warnings.
 
   - $ref: "pinctrl.yaml#"
+  - if:
+      not:
+        properties:
+          compatible:
+            enum:
+              - allwinner,sun50i-h616-r-pinctrl
+
+    then:
+      required:
+        - "#interrupt-cells"
+        - interrupts
+        - interrupt-controller
+
   - if:
       properties:
         compatible:
-- 
2.25.1

