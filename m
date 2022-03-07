Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C7EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Mar 2022 14:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243127AbiCGORa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Mar 2022 09:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243086AbiCGORP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:17:15 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98088EB52;
        Mon,  7 Mar 2022 06:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646662579;
  x=1678198579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TaZzkNMvcFak609V5gjWjr2ZiX5c1heN+EdAxQCepfE=;
  b=lcyX1Fp4POJF6YrkNk/MzrgEwAXN8o7QZZyTQPQ4Gm1xwzmKJKWLA3kI
   2o0bZ4OVMvZDhy3GP3OJ7mcAqsd40QOtZah2tw3lum8nhbS5evYfHPysl
   pDlop18609Na38nWKIbWOxyOjA7pwoCmNVM9sHjW5WEpn7jgqfa6Cofg5
   3Q60i9T6c5RD7c0pSwpS/71HwWhXciFQkn+wk4n3O9+oCrWI4ZPR5WHiV
   kd7JOnurtNjgWtFL4MiH7u2SsYzCkN6JfvI0YrjA0V4e93k08nI5AuZVO
   rcifoIjVgNIHDKfPZ9oct9ekO4+QaxqxP0BUgtrpfOE7vOZVoRY5ADBrf
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <vigneshr@ti.com>, <richard@nod.at>, <miquel.raynal@bootlin.com>,
        <joern@lazybastard.org>
CC:     <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <frowand.list@gmail.com>, <krzysztof.kozlowski@canonical.com>,
        <robh+dt@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH 2/4] dt-bindings: reserved-memory: Add phram
Date:   Mon, 7 Mar 2022 15:15:47 +0100
Message-ID: <20220307141549.2732179-3-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220307141549.2732179-1-vincent.whitchurch@axis.com>
References: <20220307141549.2732179-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings to allow MTD/block devices to be created in reserved-memory
regions using the "phram" driver.

This allows things like partitioning to be specified via the existing
devicetree bindings.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 .../bindings/reserved-memory/phram.yaml       | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/phram.yaml

diff --git a/Documentation/devicetree/bindings/reserved-memory/phram.yaml b/Documentation/devicetree/bindings/reserved-memory/phram.yaml
new file mode 100644
index 000000000000..92e7a80ee87a
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/phram.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/phram.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MTD/block device in RAM
+
+description: |
+  Use the reserved memory region as an MTD or block device.
+
+  If no-map is not set, cached mappings will be used for the memory region.
+
+maintainers:
+  - Vincent Whitchurch <vincent.whitchurch@axis.com>
+
+allOf:
+  - $ref: "reserved-memory.yaml"
+  - $ref: "../mtd/mtd.yaml"
+
+properties:
+  compatible:
+    const: phram
+
+  reg:
+    description: region of memory that contains the MTD/block device
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    reserved-memory {
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        phram: flash@12340000 {
+            compatible = "phram";
+            label = "rootfs";
+            reg = <0x12340000 0x00800000>;
+        };
+    };
-- 
2.34.1

