Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A15CC43334
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jun 2022 10:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355921AbiFVKyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jun 2022 06:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355279AbiFVKxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:53:41 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A9D3BA69;
        Wed, 22 Jun 2022 03:53:39 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25MArIS0035558;
        Wed, 22 Jun 2022 05:53:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1655895198;
        bh=zt9NxPj7rP19gJeRkq7nMIQHQLbolwtS/UXEfZYjJIo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gK+g+HNoVcYVOevXf9DVfopp38Ex2MqB1I8hK+7maa0CUEvT59zzJYyDu7jwaJocd
         pJhinHQyy1SqrC7OREOawCA33/BAnY+MWSADyDhHDsmaWInjB+2ZsVKsfhQlMVwXRf
         Ex+U/+m3FTsuFQa2omzk4QSopH5aPxk2QT2aPjIg=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25MArI97080666
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Jun 2022 05:53:18 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 22
 Jun 2022 05:53:18 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 22 Jun 2022 05:53:18 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25MArHDh089940;
        Wed, 22 Jun 2022 05:53:17 -0500
From:   Rahul T R <r-ravikumar@ti.com>
To:     <linux-phy@lists.infradead.org>, <kishon@ti.com>,
        <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <laurent.pinchart@ideasonboard.com>
CC:     <p.yadav@ti.com>, <tomi.valkeinen@ideasonboard.com>,
        <linux-kernel@vger.kernel.org>, <jpawar@cadence.com>,
        <sjakhade@cadence.com>, <mparab@cadence.com>,
        <devicetree@vger.kernel.org>, <vigneshr@ti.com>,
        <lee.jones@linaro.org>, Rahul T R <r-ravikumar@ti.com>
Subject: [PATCH v3 1/3] phy: dt-bindings: cdns,dphy: Add compatible for dphy on j721e
Date:   Wed, 22 Jun 2022 16:23:09 +0530
Message-ID: <20220622105311.21415-2-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622105311.21415-1-r-ravikumar@ti.com>
References: <20220622105311.21415-1-r-ravikumar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible to support dphy tx on j721e

Signed-off-by: Rahul T R <r-ravikumar@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 Documentation/devicetree/bindings/phy/cdns,dphy.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
index c50629bd1b51..f0e9ca8427bb 100644
--- a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
+++ b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
@@ -11,8 +11,9 @@ maintainers:
 
 properties:
   compatible:
-    items:
-      - const: cdns,dphy
+    enum:
+      - cdns,dphy
+      - ti,j721e-dphy
 
   reg:
     maxItems: 1
-- 
2.36.1

