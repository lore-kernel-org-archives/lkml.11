Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A7EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Apr 2022 03:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242688AbiDKEBK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 00:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiDKEBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 00:01:08 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1277A2FFEC;
        Sun, 10 Apr 2022 20:58:50 -0700 (PDT)
X-UUID: 8557a3c71ad94995b451f8c39d3f439b-20220411
X-UUID: 8557a3c71ad94995b451f8c39d3f439b-20220411
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1549471564; Mon, 11 Apr 2022 11:58:45 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 11 Apr 2022 11:58:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Apr 2022 11:58:44 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>, <matthias.bgg@gmail.com>
CC:     <p.zabel@pengutronix.de>, <airlied@linux.ie>,
        <yongqiang.niu@mediatek.com>, <jason-jh.lin@mediatek.com>,
        <nancy.lin@mediatek.com>, <allen-kh.cheng@mediatek.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH V2 0/3] Update MediaTek disp_aal dt-binding
Date:   Mon, 11 Apr 2022 11:58:40 +0800
Message-ID: <20220411035843.19847-1-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2:
1. Change to a proper subject.
2. Update dt-binding for MT8195.

The disp_aal dt-binding needs to be updated for MT8183, MT8192 and MT8195.
1. Update dt-binding and dts for MT8183.
2. Update dt-binding for MT8192 and MT8195.

This series is based on this series:
"add display support for MediaTek SoC MT8186":
Message id: 20220406030009.2357-1-rex-bc.chen@mediatek.com

Rex-BC Chen (3):
  dt-bindings: display: mediatek: Update disp_aal binding for MT8183
  arm64: dts: mt8183: Update disp_aal node compatible
  dt-bindings: display: mediatek: Update disp_aal binding for MT8192 and MT8195

 .../bindings/display/mediatek/mediatek,aal.yaml        | 10 +++++-----
 arch/arm64/boot/dts/mediatek/mt8183.dtsi               |  3 +--
 2 files changed, 6 insertions(+), 7 deletions(-)

-- 
2.18.0

