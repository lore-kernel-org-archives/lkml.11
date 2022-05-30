Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AD0C4332F
	for <linux-kernel@archiver.kernel.org>; Mon, 30 May 2022 10:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbiE3KKq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 May 2022 06:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbiE3KKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 06:10:42 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1AA7B9DE;
        Mon, 30 May 2022 03:10:41 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 24UAAc0u128823;
        Mon, 30 May 2022 05:10:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1653905438;
        bh=Qpm0FKthwmQtjSvS+kIqbypJKOk4wC6/RTYGVI6aExs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=RjnYL4o95v3S0YZ9z++HHJ6N/x8Z3904SZTlSVWKPE//RJAp5NINkNbz77C/0RN62
         6Z2qZi41PwTXcbEUIoEshQRCL9QoCf5QBhx5LQKyqIQ5n39Py5XdBp0hJKc6jvLCuB
         T/vKuvHq4sSTZnil6Zpg63T19HNYSifBJDB+RHTQ=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 24UAAcL6056926
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 May 2022 05:10:38 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 30
 May 2022 05:10:37 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 30 May 2022 05:10:37 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 24UAAaZo027696;
        Mon, 30 May 2022 05:10:37 -0500
From:   Rahul T R <r-ravikumar@ti.com>
To:     <robh+dt@kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <kishon@ti.com>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <lee.jones@linaro.org>, <rogerq@kernel.org>,
        <devicetree@vger.kernel.org>, <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <s-anna@ti.com>,
        Rahul T R <r-ravikumar@ti.com>
Subject: [PATCH v4 1/3] dt-bindings: mfd: ti,j721e-system-controller: Add clock property
Date:   Mon, 30 May 2022 15:40:29 +0530
Message-ID: <20220530101031.11357-2-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220530101031.11357-1-r-ravikumar@ti.com>
References: <20220530101031.11357-1-r-ravikumar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a pattern property for clock-controller, also update the example
with a clock-controller node

Signed-off-by: Rahul T R <r-ravikumar@ti.com>
---
 .../bindings/mfd/ti,j721e-system-controller.yaml     | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
index fa86691ebf16..73cffc45e056 100644
--- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
@@ -48,6 +48,12 @@ patternProperties:
     description:
       This is the SERDES lane control mux.
 
+  "^clock-controller@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/clock/ti,am654-ehrpwm-tbclk.yaml#
+    description:
+      Clock provider for TI EHRPWM nodes.
+
 required:
   - compatible
   - reg
@@ -79,5 +85,11 @@ examples:
                 <0x40c0 0x3>, <0x40c4 0x3>, <0x40c8 0x3>, <0x40cc 0x3>;
                 /* SERDES4 lane0/1/2/3 select */
         };
+
+        clock-controller@4140 {
+            compatible = "ti,am654-ehrpwm-tbclk", "syscon";
+            reg = <0x4140 0x18>;
+            #clock-cells = <1>;
+        };
     };
 ...
-- 
2.17.1

