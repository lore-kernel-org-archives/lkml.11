Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64113C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 18 May 2022 09:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbiERJhX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 May 2022 05:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234487AbiERJg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:36:59 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780B3B41E7;
        Wed, 18 May 2022 02:36:41 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 9F62B1F44CD6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652866600;
        bh=3zGUrHnz1dbJuRpvdm88S9uEAq5/aWCIicZit1vC+BA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LaCL5F1tfcIElDLgjDjcgsw7cNvWuPXJkqbuuvQkfd8nnzshg8wU1T83zZky1NNPL
         tu3GzqDQBn0D0Wbs3FjzSI7/kLq7M8fdIz2VRhIKDsT7ddZ2kQkqUj8a3xlY88T/xP
         pgLzQoT4ZRXMeIlbFZt4nx6YgQxOC28LdD9O1jOOzEIGuN+l3ZD1ADq9dB91ik6PSl
         O04u0/w9uK+TwbfZieze3jhWx5xGmThBlDsDAT2UJ53R4n4Xk3h7HEFcVkXq/+wNFP
         O6L1ueQkSaHYswULIRQX2L7UoM5d+oXYnwDoYWOBAPSPy5M6Hw3zFiDZAsVS4102Hb
         FTwnhYEkdzD9w==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, sboyd@kernel.org,
        chun-jie.chen@mediatek.com, rex-bc.chen@mediatek.com,
        wenst@chromium.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski@linaro.org
Subject: [PATCH v2 2/2] dt-bindings: arm: mtk-clocks: Set #clock-cells as required property
Date:   Wed, 18 May 2022 11:36:31 +0200
Message-Id: <20220518093631.25491-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220518093631.25491-1-angelogioacchino.delregno@collabora.com>
References: <20220518093631.25491-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a clock-controller binding, so it needs #clock-cells, or
it would be of no use: add that to the list of required properties.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/arm/mediatek/mediatek,mt8186-clock.yaml  | 1 +
 .../bindings/arm/mediatek/mediatek,mt8186-sys-clock.yaml         | 1 +
 .../devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml  | 1 +
 .../bindings/arm/mediatek/mediatek,mt8192-sys-clock.yaml         | 1 +
 .../devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml  | 1 +
 .../bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml         | 1 +
 6 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-clock.yaml
index 371eace6780b..70d7b393140e 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-clock.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-clock.yaml
@@ -44,6 +44,7 @@ properties:
 required:
   - compatible
   - reg
+  - '#clock-cells'
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-sys-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-sys-clock.yaml
index 0886e2e335bb..48ebd2112789 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-sys-clock.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-sys-clock.yaml
@@ -42,6 +42,7 @@ properties:
 required:
   - compatible
   - reg
+  - '#clock-cells'
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
index bb410b178f33..b61d7635dfdd 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
@@ -46,6 +46,7 @@ properties:
 required:
   - compatible
   - reg
+  - '#clock-cells'
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-sys-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-sys-clock.yaml
index 27f79175c678..580450e94c02 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-sys-clock.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-sys-clock.yaml
@@ -35,6 +35,7 @@ properties:
 required:
   - compatible
   - reg
+  - '#clock-cells'
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
index 0189aa0e34d4..aabd9f0df2de 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
@@ -60,6 +60,7 @@ properties:
 required:
   - compatible
   - reg
+  - '#clock-cells'
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml
index 95b6bdf99936..e2ba37830d4e 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml
@@ -43,6 +43,7 @@ properties:
 required:
   - compatible
   - reg
+  - '#clock-cells'
 
 additionalProperties: false
 
-- 
2.35.1

