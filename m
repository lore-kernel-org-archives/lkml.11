Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BA8C433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 May 2022 13:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347690AbiEQNWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 09:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347671AbiEQNVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:21:22 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96665424B8;
        Tue, 17 May 2022 06:21:20 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id BEE6B1F433FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652793679;
        bh=wExmkwG26MlgAOyGVtuHJ9fB7p/HupGT2oLsUu37GPQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aZBoDF7S6WLjXzn71iCMIL/V+Lycg10Qf7ZK8Ug7yKiDvZZ5tyETWVCdqn6xklQJ+
         CXOSXUk3mZsGhMY/unAz9RgNyzAo7PIM3EB699GyOr0TaimNnoA48fYU8x0SZbt+6B
         gx2mLb0fQbQJ+mw4kkyzJXv8r5DNPar9Folgy/+CyM4SQe4rRQdpgNSja0B96wxFqh
         Gry+R2j5QUj5dMUIbszjkpPGKH037OQv8IGSdhWH/HvRcTBikY0/vPlmY5GeaQHmCb
         NOwxzv7phBvnhQJhpX64+n6enj3E1Gnzq9uTZyi0BJg8kb05E2Rw2r/tq5ItHHRkXo
         veS3kWTfmVYDg==
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
Subject: [PATCH 8/8] dt-bindings: iommu: mediatek: Require mediatek,pericfg for mt8195-infra
Date:   Tue, 17 May 2022 15:21:07 +0200
Message-Id: <20220517132107.195932-9-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517132107.195932-1-angelogioacchino.delregno@collabora.com>
References: <20220517132107.195932-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MT8195 SoC has IOMMU related registers in the pericfg_ao iospace:
require a phandle to that.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

Note for Rob: as of now, there's no iommu node in upstream mt8195 devicetrees yet.

 .../devicetree/bindings/iommu/mediatek,iommu.yaml      | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
index 17d78b17027a..2441c2e8e55d 100644
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

