Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2DCC2BB41
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Aug 2022 15:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbiHPPrB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Aug 2022 11:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236661AbiHPPqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 11:46:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD02427CD9;
        Tue, 16 Aug 2022 08:43:16 -0700 (PDT)
Received: from pan.home (unknown [IPv6:2a00:23c6:c311:3401:2a3e:aaf0:13ac:d113])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E511E660038B;
        Tue, 16 Aug 2022 16:43:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660664595;
        bh=0dgg90zH4JPBZCXvnk5DFfAukl2F5WqFY501mB/uZ3Y=;
        h=From:To:Cc:Subject:Date:From;
        b=PfIZBDTji2l/wa4Vf0RAVVl9bXd1rALBls2CMj7n1g6JnP8i1vjC3fDPWFLYjKX0s
         mcgoiXR7Wut74rJP6RS51Wda05A6x1JBPuEL0mqtSbYBOiAzUmSCWcsYhu9OSinnkd
         PXPc/PYkQf/AuWR0qPvc0/7cLzhZAh955ims65JXfMdEJiNnCfaEPUUprENppPLD5K
         +BKjpHwJDkJ1NTcCHN9stPeoAtcXHDekiEDXtWbkddVxAh+lJIsOWwfFaRx1E+sF08
         dLtN1kB4Y7gb8YtLtBJwnOz2x11uf/fcTLtRPY9KifCk2HqNd8admUbx2CePJceXDB
         FQiEm14xLPLqQ==
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
Cc:     kernel@collabora.com, Martyn Welch <martyn.welch@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] dt-bindings: arm: fsl: Add MSC SM2S-IMX8PLUS SoM and SM2-MB-EP1 Carrier
Date:   Tue, 16 Aug 2022 16:43:04 +0100
Message-Id: <20220816154306.755788-1-martyn.welch@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT compatible strings for a combination of the 14N0600E variant of
the Avnet (MSC branded) SM2S-IMX8PLUS SoM on it's own and in combination
with the SM2-MB-EP1 carrier board.

Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changes in v2:
  - New addition

Changes in v3:
  - Switch to avnet vendor
  - Shortened descriptive comment

Changes in v4:
  - No changes

Changes in v5:
  - No changes

Changes in v6:
  - No changes

 Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 7431579ab0e8..81d90dc83385 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -936,6 +936,13 @@ properties:
               - toradex,verdin-imx8mp-wifi  # Verdin iMX8M Plus Wi-Fi / BT Modules
           - const: fsl,imx8mp
 
+      - description: Avnet (MSC Branded) Boards with SM2S i.MX8M Plus Modules
+        items:
+          - const: avnet,sm2s-imx8mp-14N0600E-ep1 # SM2S-IMX8PLUS-14N0600E on SM2-MB-EP1 Carrier Board
+          - const: avnet,sm2s-imx8mp-14N0600E     # 14N0600E variant of SM2S-IMX8PLUS SoM
+          - const: avnet,sm2s-imx8mp              # SM2S-IMX8PLUS SoM
+          - const: fsl,imx8mp
+
       - description: Engicam i.Core MX8M Plus SoM based boards
         items:
           - enum:
-- 
2.35.1

