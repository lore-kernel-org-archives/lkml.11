Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C049EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 13:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356395AbiDLNzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 09:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356352AbiDLNzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:55:25 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7955757488;
        Tue, 12 Apr 2022 06:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1649771588;
  x=1681307588;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jupemliQ8dJWnscgwhDk1djkO0V1yNDM+5JWRzk83NE=;
  b=AsPkKyqRtkZeyL7JAWRqNjITpIQwd2aRv3sIsgEO3000zpSp1w7RwlHG
   9iaNT6vCNeCQdXD+dAmx3OKQbEGaag9JLgIMG3QITu4CDDSo8t+4MiUrt
   sv1UOvMIO7W+b+/BaG9G9Ji/uyncRR7ExGGmXLYCZkem/zHYpWLqyYdqF
   cMLDu36juukh721NzCbP/+J7U0AFr1oLzI8UUjoNqQ9ZVAJ/9Qe93ovld
   VVDqHlyZKvS/E7+NvXwJHB7NnUO9UGCn4WNiCect5HZmBrb4orkf3sWRq
   v/Wi1Ik27HultEwH27w2Sq7i68Jq11RFgt1Z0XWO8QGn8bM5Ea63DG5r7
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <vigneshr@ti.com>, <richard@nod.at>, <miquel.raynal@bootlin.com>,
        <joern@lazybastard.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <frowand.list@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/4] dt-bindings: reserved-memory: Support MTD/block device
Date:   Tue, 12 Apr 2022 15:53:00 +0200
Message-ID: <20220412135302.1682890-3-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220412135302.1682890-1-vincent.whitchurch@axis.com>
References: <20220412135302.1682890-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings to allow MTD/block devices to be used in reserved-memory
regions using the "phram" (MTD in PHysical RAM) driver.

This allows things like partitioning to be specified via the existing
devicetree bindings.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---

Notes:
    v3:
    - Reword description.
    
    v2:
    - Add note on what "phram" means.
    - Use /schemas/mtd/mtd.yaml instead of relative pathUse /schemas/mtd/mtd.yaml instead of relative path.

 .../bindings/reserved-memory/phram.yaml       | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/phram.yaml

diff --git a/Documentation/devicetree/bindings/reserved-memory/phram.yaml b/Documentation/devicetree/bindings/reserved-memory/phram.yaml
new file mode 100644
index 000000000000..6c4db28015f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/phram.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/phram.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MTD/block device in RAM
+
+description: |
+  Specifies that the reserved memory region can be used as an MTD or block
+  device.
+
+  The "phram" node is named after the "MTD in PHysical RAM" driver which
+  provides an implementation of this functionality in Linux.
+
+maintainers:
+  - Vincent Whitchurch <vincent.whitchurch@axis.com>
+
+allOf:
+  - $ref: "reserved-memory.yaml"
+  - $ref: "/schemas/mtd/mtd.yaml"
+
+properties:
+  compatible:
+    const: phram
+
+  reg:
+    description: region of memory that can be used as an MTD/block device
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

