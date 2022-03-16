Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEB3C4332F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Mar 2022 06:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353760AbiCPGDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Mar 2022 02:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353727AbiCPGDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 02:03:11 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26614606C5;
        Tue, 15 Mar 2022 23:01:57 -0700 (PDT)
X-UUID: 89fbff96aaf04f49b71891b93f7038b2-20220316
X-UUID: 89fbff96aaf04f49b71891b93f7038b2-20220316
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1299534393; Wed, 16 Mar 2022 14:01:47 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Mar 2022 14:01:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Mar 2022 14:01:46 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <aaronyu@google.com>, <angelogioacchino.delregno@collabora.com>,
        <yc.hung@mediatek.com>
Subject: [PATCH v2 5/5] ASoC: dt-bindings: mediatek: mt8195: support mt8195-mt6359-max98390-rt5682
Date:   Wed, 16 Mar 2022 14:01:39 +0800
Message-ID: <20220316060139.6211-6-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220316060139.6211-1-trevor.wu@mediatek.com>
References: <20220316060139.6211-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds compatible string "mediatek,mt8195-mt6359-max98390-rt5682"
to support mt8195 board with mt6359, max98390 and rt5682.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 Documentation/devicetree/bindings/sound/mt8195-mt6359.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/mt8195-mt6359.yaml b/Documentation/devicetree/bindings/sound/mt8195-mt6359.yaml
index 74227fba91c7..6222ef2cf7e4 100644
--- a/Documentation/devicetree/bindings/sound/mt8195-mt6359.yaml
+++ b/Documentation/devicetree/bindings/sound/mt8195-mt6359.yaml
@@ -17,6 +17,7 @@ properties:
     enum:
       - mediatek,mt8195_mt6359_rt1019_rt5682
       - mediatek,mt8195_mt6359_rt1011_rt5682
+      - mediatek,mt8195_mt6359_max98390_rt5682
 
   model:
     $ref: /schemas/types.yaml#/definitions/string
-- 
2.18.0

