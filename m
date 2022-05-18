Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0367EC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 May 2022 10:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbiERKFz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 May 2022 06:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbiERKFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 06:05:19 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632E9703CE;
        Wed, 18 May 2022 03:05:18 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 541381F44E0E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652868317;
        bh=4U43Hk0oR+7PqSrme9R8NUK5uKhAJqw2cEX5plkCcas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oISrE18fc4v2OSj7weSR5GM4xjVru/lLSV6xAoSfBKZ5F6BfOIJuhtbEZ2K5P3phv
         YPkg54ufDLgpHUk+spVlQnoW0QNyQMmx3o5tfIhl7sPjLxuUMjirt+6DTD2vfj897L
         CjE/1xubPJ7W9f3tD4d9BknMRlYxde+xPH2bPhQLgCRFqpXIzAA39HOra8AyMGePfp
         6Hx6MKCgWuCaFwsnBBw7WviOisT1smTGVGrmjWOKjv1Cb71nnS/MkYrpmYbJxicHjv
         FzXp9VlkKFH53Sdv3qRCOMqCcmGvV8ycijBhi38tfiilDVwTRMltr7qPuXT9FAbMR8
         Rxi/DboN31xQQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     yong.wu@mediatek.com
Cc:     joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@linaro.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 7/7] dt-bindings: iommu: mediatek: Require mediatek,pericfg for mt8195-infra
Date:   Wed, 18 May 2022 12:05:03 +0200
Message-Id: <20220518100503.37279-8-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220518100503.37279-1-angelogioacchino.delregno@collabora.com>
References: <20220518100503.37279-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MT8195 SoC has IOMMU related registers in the pericfg_ao iospace:
require a phandle to that.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/iommu/mediatek,iommu.yaml      | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
index acc2d7e63a9f..d5e3272a54e8 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
@@ -187,6 +187,16 @@ allOf:
       required:
         - mediatek,infracfg
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt8195-iommu-infra
+
+    then:
+      required:
+        - mediatek,pericfg
+
   - if: # The IOMMUs don't have larbs.
       not:
         properties:
-- 
2.35.1

