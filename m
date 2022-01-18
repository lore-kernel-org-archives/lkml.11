Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A291C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jan 2022 19:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348712AbiARTVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jan 2022 14:21:12 -0500
Received: from mail-4316.protonmail.ch ([185.70.43.16]:46589 "EHLO
        mail-4316.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348702AbiARTVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 14:21:10 -0500
Date:   Tue, 18 Jan 2022 19:21:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1642533669;
        bh=pkLtUxOb2ep7xRNJzqsPL9nabKjn2rx2SwLFDqIZE84=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=Xmixi+Sx2GexwyHdSMKQRFtjcpJ0XufI3IvnC7rhifotvJeSjB7wr5Cl+J3dcvp7A
         847BZIszUVhlTCtb0eeUIqYduHumUdcXimL7Wzm4Ro6KKb2D0JJ2H7IROCV9izrOcp
         9dVlVTTUEw0FuY97910fMJbNpeu0kYPvQTJyVVtkwp9bw7FVH8D8hJ4AbEb+afxM89
         pbENgvRj4VzjTlpbXRaXMEXpAWPr3vBLymoQOdWE+n23AA3p38pH2HCzhkmwIXf2Bq
         +wXXOK/AvKIOmez2YBBhlYbaRiroTfaOqckyE+YP1PC2rbZbz2OtJIfzdooGsRomXA
         F1ax5TFr6XKIw==
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@protonmail.com>
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kettenis@openbsd.org,
        =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@protonmail.com>
Reply-To: =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@protonmail.com>
Subject: [PATCH v2 1/3] dt-bindings: clock: Add Apple NCO
Message-ID: <20220118191839.64086-2-povik+lin@protonmail.com>
In-Reply-To: <20220118191839.64086-1-povik+lin@protonmail.com>
References: <20220118191839.64086-1-povik+lin@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NCO block found on Apple SoCs is a programmable clock generator
performing fractional division of a high frequency input clock.

Signed-off-by: Martin Povi=C5=A1er <povik+lin@protonmail.com>
---
 .../devicetree/bindings/clock/apple,nco.yaml  | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/apple,nco.yaml

diff --git a/Documentation/devicetree/bindings/clock/apple,nco.yaml b/Docum=
entation/devicetree/bindings/clock/apple,nco.yaml
new file mode 100644
index 000000000000..da56b64b8fff
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
+  - Martin Povi=C5=A1er <povik+lin@protonmail.com>
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
+        - apple,t6000-nco
+        - apple,t8103-nco
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
+      compatible =3D "fixed-clock";
+      #clock-cells =3D <0>;
+      clock-frequency =3D <900000000>;
+      clock-output-names =3D "nco-ref";
+    };
+
+    nco: clock-controller@23b044000 {
+      compatible =3D "apple,t8103-nco", "apple,nco";
+      reg =3D <0x3b044000 0x14000>;
+      #clock-cells =3D <1>;
+      clocks =3D <&nco_clkref>;
+    };
--
2.33.0


