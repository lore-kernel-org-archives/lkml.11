Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD8AC54EE9
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Sep 2022 06:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbiIBGl5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Sep 2022 02:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbiIBGly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 02:41:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0306D9FE;
        Thu,  1 Sep 2022 23:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662100913; x=1693636913;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cXQT/Je2kt0cVSQZEufYezV+FLuHgFiRg9o4FJ46qtM=;
  b=Pbr82TZXZCqsmgQ2hFAYIzkezKl9fucgvNlhL4K71INq7dVN4mnAOpZF
   8ahgyaHttKx918AZCvXAvtgy8GpHRUMNQ8cOGQk9vzqnj/ptyX7j9NkO2
   Va8/9K1hI6JHeZm9jnzfTidZryhENapvidYUiKC7yLzGCjn7glNKgHWcz
   myNpGHn172+LoNMQBXtCi1C1cMjYf4amZThYa376xoDuMj0jQhRiGPKrJ
   jgR7FzHwfp0GUPZgNwyb3riOXZ5p5t2qZp+bhvMu8GxOhVU7j/KASKix+
   ZUTpHl0/GpMVnpJtWRbdlzkYcnAr+qs8WpjdCYzbMpYBwI4z9lMQHxkcd
   A==;
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="175326229"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Sep 2022 23:41:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 1 Sep 2022 23:41:52 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 1 Sep 2022 23:41:50 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <UNGLinuxDriver@microchip.com>,
        "Horatiu Vultur" <horatiu.vultur@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/2] dt-bindings: lan9662-otpc: document Lan9662 OTPC
Date:   Fri, 2 Sep 2022 08:45:39 +0200
Message-ID: <20220902064540.484967-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220902064540.484967-1-horatiu.vultur@microchip.com>
References: <20220902064540.484967-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Lan9662 OTP controller.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 .../nvmem/microchip,lan9662-otpc.yaml         | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml b/Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml
new file mode 100644
index 000000000000..f97c6beb4766
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/microchip,lan9662-otpc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip LAN9662 OTP Controller (OTPC)
+
+maintainers:
+  - Horatiu Vultur <horatiu.vultur@microchip.com>
+
+description: |
+  OTP controller drives a NVMEM memory where system specific data
+  (e.g. hardware configuration settings, chip identifiers) or
+  user specific data could be stored.
+
+allOf:
+  - $ref: nvmem.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: microchip,lan9668-otpc
+          - const: microchip,lan9662-otpc
+      - enum:
+          - microchip,lan9662-otpc
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    otpc: otp@e0021000 {
+        compatible = "microchip,lan9662-otpc";
+        reg = <0xe0021000 0x300>;
+    };
+
+...
-- 
2.33.0

