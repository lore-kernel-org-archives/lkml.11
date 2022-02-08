Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA908C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 18:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385133AbiBHSlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 13:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385074AbiBHSlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:41:42 -0500
X-Greylist: delayed 402 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 10:41:39 PST
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493F7C06174F;
        Tue,  8 Feb 2022 10:41:38 -0800 (PST)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1644345292; bh=NP1f3DAdp/xVOoC98TgjO/QBsLcOum1NWt02zNNuht8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=D02vLUnaEP1xPiUSMEO1n6vQ0Ukf07veGt7kCI5nDbdBqEY7jTvJxnCAoKZwtvhCW
         KzHJA/SoAIQQyIBxqkqkQkQ6WXcH9rae+6sjZaR83ZRFhHO5u748wboQ5AFQiVhwyv
         YNRjgJlmyKr3n3AZ8luDqNAp64DJQgkcrAC8SLRU=
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Kettenis <kettenis@openbsd.org>,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/3] dt-bindings: clock: Add Apple NCO
Date:   Tue,  8 Feb 2022 19:34:09 +0100
Message-Id: <20220208183411.61090-2-povik+lin@cutebit.org>
In-Reply-To: <20220208183411.61090-1-povik+lin@cutebit.org>
References: <20220208183411.61090-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NCO block found on Apple SoCs is a programmable clock generator
performing fractional division of a high frequency input clock.

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 .../devicetree/bindings/clock/apple,nco.yaml  | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/apple,nco.yaml

diff --git a/Documentation/devicetree/bindings/clock/apple,nco.yaml b/Documentation/devicetree/bindings/clock/apple,nco.yaml
new file mode 100644
index 000000000000..23ee3964fbde
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/apple,nco.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/apple,nco.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple SoCs' NCO block
+
+maintainers:
+  - Martin Povišer <povik+lin@cutebit.org>
+
+description: |
+  The NCO (Numerically Controlled Oscillator) block found on Apple SoCs
+  such as the t8103 (M1) is a programmable clock generator performing
+  fractional division of a high frequency input clock.
+
+  It carries a number of independent channels and is typically used for
+  generation of audio bitclocks.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - apple,t6000-nco
+          - apple,t8103-nco
+      - const: apple,nco
+
+  clocks:
+    description:
+      Specifies the reference clock from which the output clocks
+      are derived through fractional division.
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - clocks
+  - '#clock-cells'
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    nco_clkref: clock-ref {
+      compatible = "fixed-clock";
+      #clock-cells = <0>;
+      clock-frequency = <900000000>;
+      clock-output-names = "nco-ref";
+    };
+
+    nco: clock-controller@23b044000 {
+      compatible = "apple,t8103-nco", "apple,nco";
+      reg = <0x3b044000 0x14000>;
+      #clock-cells = <1>;
+      clocks = <&nco_clkref>;
+    };
-- 
2.33.0

