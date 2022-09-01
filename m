Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D3FECAAD1
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Sep 2022 13:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbiIANhh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Sep 2022 09:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbiIANg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:36:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03F855B9;
        Thu,  1 Sep 2022 06:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662039302; x=1693575302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jmjzFPLTzirPRRdjytSXcGvB/NkyTEAOoOOffWQqE6s=;
  b=dnAiDCdz2SLKWPz3/aspuclRAYTgzygiEqDgcDIqP+HfQg6UxY540rZb
   yMrgjEw7yGNnOImCdAvdXuSue6qY6etsC9OWJSgMy5HBtIoCYdfg/PDz6
   LifPbqtveTI/Sngwik+suJg9u1ShENOboWfuM/N3znG3hH7YpNmv5uuSj
   yuPcukxfbSUpk3jyVogAdtG9ssoz+eVRAoMn4cWRai7yLIfAJWUTojQoN
   9KmCX+3P7EcOaf4h5GuHp0kt79QDRC+RJ5Uyp/+tLRVtczwSli/ApBIYs
   I93dQet7skGaLXjZgqIoClD8w67Pba6y0qtXUDHGKnGFS8OmED5O0PYUm
   w==;
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="175197577"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Sep 2022 06:34:52 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 1 Sep 2022 06:34:48 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Thu, 1 Sep 2022 06:34:45 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Shravan Chippa <shravan.chippa@microchip.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cyril Jean <Cyril.Jean@microchip.com>,
        Lewis Hanly <lewis.hanly@microchip.com>,
        Vattipalli Praveen <praveen.kumar@microchip.com>,
        Wolfgang Grandegger <wg@aries-embedded.de>,
        Hugh Breslin <hugh.breslin@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/9] dt-bindings: riscv: microchip: document icicle reference design
Date:   Thu, 1 Sep 2022 14:33:56 +0100
Message-ID: <20220901133403.3392291-2-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220901133403.3392291-1-conor.dooley@microchip.com>
References: <20220901133403.3392291-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The icicle kit reference design's v2022.09 release,made some changes
to the memory map - including adding the ability to read the fabric
clock controllers via the system controller bus & making the PCI
controller work with upstream Linux.

While the PCI was not working in the v2022.03 design, so nothing is
broken there in terms of backwards compatibility, the fabric clocks
used in the v2022.03 design were chosen by the individual run of the
synthesis tool. In the v2022.09 reference design, the clocks are fixed
to use the "north west" fabric Clock Conditioning Circuitry.

Make use of a new compatible to denote that this is not backwards
compatible.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/riscv/microchip.yaml   | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/riscv/microchip.yaml b/Documentation/devicetree/bindings/riscv/microchip.yaml
index 1aa7336a9672..485981fbfb4b 100644
--- a/Documentation/devicetree/bindings/riscv/microchip.yaml
+++ b/Documentation/devicetree/bindings/riscv/microchip.yaml
@@ -17,12 +17,18 @@ properties:
   $nodename:
     const: '/'
   compatible:
-    items:
-      - enum:
-          - microchip,mpfs-icicle-kit
-          - microchip,mpfs-icicle-reference-rtlv2203
-          - sundance,polarberry
-      - const: microchip,mpfs
+    oneOf:
+      - items:
+          - enum:
+              - microchip,mpfs-icicle-reference-rtlv2203
+              - microchip,mpfs-icicle-reference-rtlv2209
+          - const: microchip,mpfs-icicle-kit
+          - const: microchip,mpfs
+
+      - items:
+          - enum:
+              - sundance,polarberry
+          - const: microchip,mpfs
 
 additionalProperties: true
 
-- 
2.36.1

