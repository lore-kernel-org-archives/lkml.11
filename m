Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495E0C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Apr 2022 19:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348162AbiDOTGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Apr 2022 15:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348111AbiDOTGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 15:06:40 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C093EDAFC5;
        Fri, 15 Apr 2022 12:04:09 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23FJ44wX080264;
        Fri, 15 Apr 2022 14:04:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650049444;
        bh=C5ye0sTPwrGt9AzJ49t329sHvHK/9k3F3lSRK3plqxc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=tsWZOulOq6nf71ZMzM5U5eURAFyrxD5QjO/iG71cCUl2Qq/C5MMlHDuUIvQBr3lcr
         MhNii9zI1PFboiQWk4xNVViQ3XGCd0jsqWCdTP3IPzxOPAgrDhitwCINTyh1pOooDH
         oByPX96s753gAnEGMqRErOVMax3z90A+eeEdvyrU=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23FJ44c7041754
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Apr 2022 14:04:04 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 15
 Apr 2022 14:04:04 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 15 Apr 2022 14:04:04 -0500
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23FJ3mfc067536;
        Fri, 15 Apr 2022 14:03:58 -0500
From:   Georgi Vlaev <g-vlaev@ti.com>
To:     <ssantosh@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        Georgi Vlaev <g-vlaev@ti.com>
Subject: [PATCH v2 1/2] dt-bindings: clock: ehrpwm: Add AM62 specific compatible
Date:   Fri, 15 Apr 2022 22:03:42 +0300
Message-ID: <20220415190343.6284-2-g-vlaev@ti.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220415190343.6284-1-g-vlaev@ti.com>
References: <20220415190343.6284-1-g-vlaev@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce AM62 specific compatible for EPWM time-base
sub-module clock. The time-base clock setup is identical
to AM64. The only difference is AM62 provides 3 time-base
clocks instead of the 9 found in AM64.

Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
Tested-by: Vignesh Raghavendra <vigneshr@ti.com>
Reviewed-by: Nishanth Menon <nm@ti.com>
---
 .../devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml b/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml
index 9b537bc876b5..66765116aff5 100644
--- a/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml
+++ b/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml
@@ -15,6 +15,7 @@ properties:
       - enum:
           - ti,am654-ehrpwm-tbclk
           - ti,am64-epwm-tbclk
+          - ti,am62-epwm-tbclk
       - const: syscon
 
   "#clock-cells":
-- 
2.30.2

