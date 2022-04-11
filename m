Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4313C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Apr 2022 22:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbiDKWYq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 18:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350446AbiDKWYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 18:24:30 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E3513EA3;
        Mon, 11 Apr 2022 15:22:12 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1649715729; bh=EJZTC/ClSFKyr/qub0lf6Q+PSSWH+Yce7kdkcf2d4vY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=DCTjTMULcjbFUSOvZ8DpPqsy4YspOWq5V0XcpueglHW4vK03njzDfMUHLbVb902HB
         VDcU5HQub2U9RQbFqUzjPzHwEn61ljMeRbGMDnsW9u0yRxW2cS0OUom50mYhdgAa9C
         AlK8biOu4kczo/F+wldczavCD0cFaNn7i3tv1tx0=
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Subject: [PATCH v2 1/2] dt-bindings: dma: Add Apple ADMAC
Date:   Tue, 12 Apr 2022 00:22:03 +0200
Message-Id: <20220411222204.96860-2-povik+lin@cutebit.org>
In-Reply-To: <20220411222204.96860-1-povik+lin@cutebit.org>
References: <20220411222204.96860-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apple's Audio DMA Controller (ADMAC) is used to fetch and store audio
samples on SoCs from the "Apple Silicon" family.

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---

After the v1 discussion, I dropped the apple,internal-irq-destination
property and instead the index of the usable interrupt is now signified
by prepending -1 entries to the interrupts= list. This works when I do
it like this:

  interrupt-parent = <&aic>;
  interrupts = <AIC_IRQ 0xffffffff 0>,
               <AIC_IRQ 626 IRQ_TYPE_LEVEL_HIGH>;

I would find it neat to do it like this:

  interrupts-extended = <0xffffffff>,
                        <&aic AIC_IRQ 626 IRQ_TYPE_LEVEL_HIGH>;

but unfortunately the kernel doesn't pick up on it:

[    0.767964] apple-admac 238200000.dma-controller: error -6: IRQ index 0 not found
[    0.773943] apple-admac 238200000.dma-controller: error -6: IRQ index 1 not found
[    0.780154] apple-admac 238200000.dma-controller: error -6: IRQ index 2 not found
[    0.786367] apple-admac 238200000.dma-controller: error -6: IRQ index 3 not found
[    0.788592] apple-admac 238200000.dma-controller: error -6: no usable interrupt

 .../devicetree/bindings/dma/apple,admac.yaml  | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/apple,admac.yaml

diff --git a/Documentation/devicetree/bindings/dma/apple,admac.yaml b/Documentation/devicetree/bindings/dma/apple,admac.yaml
new file mode 100644
index 000000000000..bbd5eaf5f709
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/apple,admac.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/apple,admac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple Audio DMA Controller (ADMAC)
+
+description: |
+  Apple's Audio DMA Controller (ADMAC) is used to fetch and store audio samples
+  on SoCs from the "Apple Silicon" family.
+
+  The controller has been seen with up to 24 channels. Even-numbered channels
+  are TX-only, odd-numbered are RX-only. Individual channels are coupled to
+  fixed device endpoints.
+
+maintainers:
+  - Martin Povišer <povik+lin@cutebit.org>
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - apple,t6000-admac
+          - apple,t8103-admac
+      - const: apple,admac
+
+  reg:
+    maxItems: 1
+
+  '#dma-cells':
+    const: 1
+    description:
+      Clients specify single cell with channel number.
+
+  dma-channels:
+    maximum: 24
+
+  interrupts:
+    minItems: 1
+    maxItems: 4
+
+required:
+  - compatible
+  - reg
+  - '#dma-cells'
+  - dma-channels
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/apple-aic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    admac: dma-controller@238200000 {
+      compatible = "apple,t8103-admac", "apple,admac";
+      reg = <0x38200000 0x34000>;
+      dma-channels = <24>;
+      interrupt-parent = <&aic>;
+      interrupts = <AIC_IRQ 0xffffffff 0>,
+                   <AIC_IRQ 626 IRQ_TYPE_LEVEL_HIGH>;
+      #dma-cells = <1>;
+    };
-- 
2.33.0

