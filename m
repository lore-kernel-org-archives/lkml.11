Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC17C43334
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Jul 2022 11:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbiGALZ0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Jul 2022 07:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbiGALZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:25:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7861C81487;
        Fri,  1 Jul 2022 04:25:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87F0C113E;
        Fri,  1 Jul 2022 04:25:14 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 951983F66F;
        Fri,  1 Jul 2022 04:25:12 -0700 (PDT)
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
Subject: [PATCH v12 5/7] dt-bindings: arm: sunxi: Add two H616 board compatible strings
Date:   Fri,  1 Jul 2022 12:24:51 +0100
Message-Id: <20220701112453.2310722-6-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220701112453.2310722-1-andre.przywara@arm.com>
References: <20220701112453.2310722-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the two board compatible strings of two boards with the
Allwinner H616 SoC. One is a development board from OrangePi, the other
some TV box from some formerly unused vendor. Add that vendor to the
vendor list on the way.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml       | 10 ++++++++++
 Documentation/devicetree/bindings/vendor-prefixes.yaml |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 95278a6a9a8ec..0c2356778208a 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -863,6 +863,11 @@ properties:
           - const: yones-toptech,bs1078-v2
           - const: allwinner,sun6i-a31s
 
+      - description: X96 Mate TV box
+        items:
+          - const: hechuang,x96-mate
+          - const: allwinner,sun50i-h616
+
       - description: Xunlong OrangePi
         items:
           - const: xunlong,orangepi
@@ -963,4 +968,9 @@ properties:
           - const: xunlong,orangepi-zero-plus2-h3
           - const: allwinner,sun8i-h3
 
+      - description: Xunlong OrangePi Zero 2
+        items:
+          - const: xunlong,orangepi-zero2
+          - const: allwinner,sun50i-h616
+
 additionalProperties: true
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 0496773a3c4d8..f0db732096941 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -510,6 +510,8 @@ patternProperties:
     description: Haoyu Microelectronic Co. Ltd.
   "^hardkernel,.*":
     description: Hardkernel Co., Ltd
+  "^hechuang,.*":
+    description: Shenzhen Hechuang Intelligent Co.
   "^hideep,.*":
     description: HiDeep Inc.
   "^himax,.*":
-- 
2.25.1

