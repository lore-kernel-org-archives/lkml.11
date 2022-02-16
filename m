Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5B7C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Feb 2022 12:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbiBPMAt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Feb 2022 07:00:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbiBPMAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 07:00:47 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6401907C9;
        Wed, 16 Feb 2022 04:00:34 -0800 (PST)
X-UUID: 7af45a2399f04d868821f3d5c7fb0381-20220216
X-UUID: 7af45a2399f04d868821f3d5c7fb0381-20220216
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1191620437; Wed, 16 Feb 2022 20:00:30 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Feb 2022 20:00:29 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 16 Feb
 2022 20:00:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Feb 2022 20:00:28 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Min Guo <Min.Guo@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Hsin-Yi Wang" <hsinyi@google.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH] dt-bindings: usb: mtk-xhci: add compatible for mt8186
Date:   Wed, 16 Feb 2022 20:00:25 +0800
Message-ID: <20220216120025.29860-1-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for mt8186

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
---
 Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
index 11f7bacd4e2b..6d9c3bad1d10 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
@@ -30,6 +30,7 @@ properties:
           - mediatek,mt7629-xhci
           - mediatek,mt8173-xhci
           - mediatek,mt8183-xhci
+          - mediatek,mt8186-xhci
           - mediatek,mt8192-xhci
           - mediatek,mt8195-xhci
       - const: mediatek,mtk-xhci
-- 
2.18.0

