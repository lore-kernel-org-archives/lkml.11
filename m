Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B702EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 May 2022 06:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240452AbiEPGuo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 May 2022 02:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239940AbiEPGuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:50:25 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A881DF62
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:50:22 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 24G6ZVWd064016;
        Mon, 16 May 2022 14:35:31 +0800 (GMT-8)
        (envelope-from ryan_chen@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.9) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 16 May
 2022 14:49:04 +0800
From:   ryan_chen <ryan_chen@aspeedtech.com>
To:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [PATCH v3 1/3] dt-bindings: i2c-ast2600: Add bindings for AST2600 i2C global register controller
Date:   Mon, 16 May 2022 14:48:58 +0800
Message-ID: <20220516064900.30517-2-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220516064900.30517-1-ryan_chen@aspeedtech.com>
References: <20220516064900.30517-1-ryan_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.10.9]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 24G6ZVWd064016
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AST2600 I2C global register controller, add bindings document
to support driver of i2c global register set

Signed-off-by: ryan_chen <ryan_chen@aspeedtech.com>
---
 .../i2c/aspeed,i2c-ast2600-global.ymal        | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600-global.ymal

diff --git a/Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600-global.ymal b/Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600-global.ymal
new file mode 100644
index 000000000000..d92a0878d03b
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600-global.ymal
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/aspeed,i2c-ast2600-global.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AST2600 I2C Global Register on the AST26XX SoCs Device Tree Bindings
+
+maintainers:
+  - Ryan Chen <ryan_chen@aspeedtech.com>
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2600-i2c-global
+
+  reg:
+    minItems: 1
+    items:
+      - description: address offset and range of bus
+      - description: address offset and range of bus buffer
+
+  resets:
+    maxItems: 1
+
+required:
+  - reg
+  - compatible
+  - resets
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/ast2600-clock.h>
+
+    i2c_gr: i2c-global-regs@0 {
+      compatible = "aspeed,ast2600-i2c-global", "syscon";
+      reg = <0x0 0x20>;
+      resets = <&syscon ASPEED_RESET_I2C>;
+    };
-- 
2.17.1

