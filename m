Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1CDC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 02:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1456052AbiDFCPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 22:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351645AbiDEUP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 16:15:29 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0607AF9FB0;
        Tue,  5 Apr 2022 12:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=0ZFTEBC50mhc9NZ1AdGDIcklV5epX+TBR7wn/4sHSsA=; b=nCz0PcqeDtwxrNP6xu+aPkukmo
        WkXu6B3ykehXx8wDlYxkTJRrvrEwA7/YDoO+fgDdjKGEhvE9ky5PzFxifDcSpHZmfk/CIJzmNzzzX
        bvIyLGhUNDbBw+hFz13GGpIUyY6gSHCOi3YLa/QXliE3aHtPxq8s0flQJ+fxqH2nsv3c=;
Received: from p200300daa70ef200456864e8b8d10029.dip0.t-ipconnect.de ([2003:da:a70e:f200:4568:64e8:b8d1:29] helo=Maecks.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nbpJS-00035V-6F; Tue, 05 Apr 2022 21:58:02 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     netdev@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/14] dt-bindings: arm: mediatek: document the pcie mirror node on MT7622
Date:   Tue,  5 Apr 2022 21:57:46 +0200
Message-Id: <20220405195755.10817-6-nbd@nbd.name>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405195755.10817-1-nbd@nbd.name>
References: <20220405195755.10817-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

This patch adds the pcie mirror document bindings for MT7622 SoC.
The feature is used for intercepting PCIe MMIO access for the WED core
Add related info in mediatek-net bindings.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../mediatek/mediatek,mt7622-pcie-mirror.yaml | 42 +++++++++++++++++++
 .../devicetree/bindings/net/mediatek-net.txt  |  2 +
 2 files changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-pcie-mirror.yaml

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-pcie-mirror.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-pcie-mirror.yaml
new file mode 100644
index 000000000000..9fbeb626ab23
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-pcie-mirror.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,mt7622-pcie-mirror.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: MediaTek PCIE Mirror Controller for MT7622
+
+maintainers:
+  - Lorenzo Bianconi <lorenzo@kernel.org>
+  - Felix Fietkau <nbd@nbd.name>
+
+description:
+  The mediatek PCIE mirror provides a configuration interface for PCIE
+  controller on MT7622 soc.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mediatek,mt7622-pcie-mirror
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+      pcie_mirror: pcie-mirror@10000400 {
+        compatible = "mediatek,mt7622-pcie-mirror", "syscon";
+        reg = <0 0x10000400 0 0x10>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/net/mediatek-net.txt b/Documentation/devicetree/bindings/net/mediatek-net.txt
index 1c8dc44bbb52..f18d70189375 100644
--- a/Documentation/devicetree/bindings/net/mediatek-net.txt
+++ b/Documentation/devicetree/bindings/net/mediatek-net.txt
@@ -48,6 +48,8 @@ Optional properties:
 	various clocks and reset to the system.
 - mediatek,wed: a list of phandles to wireless ethernet dispatch nodes for
 	MT7622 SoC.
+- mediatek,pcie-mirror: phandle to the mediatek pcie-mirror controller for
+	MT7622 SoC.
 
 * Ethernet MAC node
 
-- 
2.35.1

