Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5B5C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 May 2022 13:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347638AbiEQNWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 09:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347647AbiEQNVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:21:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BA338DA7;
        Tue, 17 May 2022 06:21:14 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id C94481F433FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652793673;
        bh=PV/c5CsQfIEeeK1hM+QeRKiJih/2FjYi3kjZiefnius=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FbaJmAgGCe4rbB7Isi1Deq0+sZu4HnAwVsOVzYvgyjc0lzSa+1eAGbdlEzNtP/cU0
         ajJjmmbxhCPuTdRzhI4o6sX/Dji+385KB8uRFWgxlqGGyeWyEHN36wxJdr7dX2FEVY
         9H9Gdh54JH9NRpRookRdVCLcE7cjDzGm3YUQGo7C3o4rJDQfaBMgcFKN9P0zEbLViT
         RwCSEf44skMDOYcWkthTAxfc1Tg9MLX9CguAwgHdp0Cw4dfZHSiAqY+aT7ekvz4g/M
         FgPb6F4oW9fZSN4A07DWbZM4Z0sYPU3d+wF54oPBbRM/nIELyQRPVysFBHOUv+JnWY
         je++8ZeN7B16w==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     yong.wu@mediatek.com
Cc:     joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 1/8] dt-bindings: iommu: mediatek: Add mediatek,infracfg phandle
Date:   Tue, 17 May 2022 15:21:00 +0200
Message-Id: <20220517132107.195932-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517132107.195932-1-angelogioacchino.delregno@collabora.com>
References: <20220517132107.195932-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add property "mediatek,infracfg" to let the mtk_iommu driver retrieve
a phandle to the infracfg syscon instead of performing a per-soc
compatible lookup.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
index 2ae3bbad7f1a..78c72c22740b 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
@@ -101,6 +101,10 @@ properties:
     items:
       - const: bclk
 
+  mediatek,infracfg:
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+    description: The phandle to the mediatek infracfg syscon
+
   mediatek,larbs:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     minItems: 1
-- 
2.35.1

