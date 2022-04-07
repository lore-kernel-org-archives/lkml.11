Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C266C433FE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Apr 2022 15:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345043AbiDGPq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Apr 2022 11:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345018AbiDGPqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:46:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2191BB6E5A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 08:44:05 -0700 (PDT)
Received: from dude03.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::39])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ncUIh-0007bF-6x; Thu, 07 Apr 2022 17:43:59 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, Antoine Tenart <atenart@kernel.org>
Subject: [PATCH 03/14] dt-bindings: reset: berlin: Convert to yaml
Date:   Thu,  7 Apr 2022 17:43:27 +0200
Message-Id: <20220407154338.4190674-3-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220407154338.4190674-1-p.zabel@pengutronix.de>
References: <20220407154338.4190674-1-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::39
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the device tree bindings for the Marvell Berlin reset controller
to YAML schema to allow participating in DT validation.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Antoine Tenart <atenart@kernel.org>
---
 .../bindings/reset/berlin,reset.txt           | 23 -----------
 .../bindings/reset/marvell,berlin2-reset.yaml | 38 +++++++++++++++++++
 2 files changed, 38 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/reset/berlin,reset.txt
 create mode 100644 Documentation/devicetree/bindings/reset/marvell,berlin2-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/berlin,reset.txt b/Documentation/devicetree/bindings/reset/berlin,reset.txt
deleted file mode 100644
index 514fee098b4b..000000000000
--- a/Documentation/devicetree/bindings/reset/berlin,reset.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-Marvell Berlin reset controller
-===============================
-
-Please also refer to reset.txt in this directory for common reset
-controller binding usage.
-
-The reset controller node must be a sub-node of the chip controller
-node on Berlin SoCs.
-
-Required properties:
-- compatible: should be "marvell,berlin2-reset"
-- #reset-cells: must be set to 2
-
-Example:
-
-chip_rst: reset {
-	compatible = "marvell,berlin2-reset";
-	#reset-cells = <2>;
-};
-
-&usb_phy0 {
-	resets = <&chip_rst 0x104 12>;
-};
diff --git a/Documentation/devicetree/bindings/reset/marvell,berlin2-reset.yaml b/Documentation/devicetree/bindings/reset/marvell,berlin2-reset.yaml
new file mode 100644
index 000000000000..d71d0f0a13ee
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/marvell,berlin2-reset.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2015 Antoine Tenart <atenart@kernel.org>
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/reset/marvell,berlin2-reset.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Marvell Berlin reset controller
+
+maintainers:
+  - Antoine Tenart <atenart@kernel.org>
+
+description: The reset controller node must be a sub-node of the chip
+  controller node on Berlin SoCs.
+
+properties:
+  compatible:
+    const: marvell,berlin2-reset
+
+  "#reset-cells":
+    const: 2
+
+required:
+  - compatible
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    chip: chip-control@ea0000 {
+        reg = <0xea0000 0x400>;
+
+        chip_rst: reset {
+            compatible = "marvell,berlin2-reset";
+            #reset-cells = <2>;
+        };
+    };
-- 
2.30.2

