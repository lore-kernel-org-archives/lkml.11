Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BC7C433FE
	for <linux-kernel@archiver.kernel.org>; Fri, 20 May 2022 02:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344666AbiETCAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 22:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344647AbiETCAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 22:00:33 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087FAEC334
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 19:00:26 -0700 (PDT)
X-UUID: 73926dfc9e754399b636968c2a995a38-20220520
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:b0a79d0d-62c9-4fa0-a64c-f1e191d76526,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:3a46dee2-edbf-4bd4-8a34-dfc5f7bb086d,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: 73926dfc9e754399b636968c2a995a38-20220520
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <xinlei.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 332516485; Fri, 20 May 2022 10:00:10 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 20 May 2022 10:00:09 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 20 May 2022 10:00:08 +0800
From:   <xinlei.lee@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <matthias.bgg@gmail.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <rex-bc.chen@mediatek.com>, <jitao.shi@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>
Subject: [PATCH v7,0/4] Cooperate with DSI RX devices to modify dsi funcs and delay mipi high to cooperate with panel sequence
Date:   Fri, 20 May 2022 10:00:03 +0800
Message-ID: <1653012007-11854-1-git-send-email-xinlei.lee@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xinlei Lee <xinlei.lee@mediatek.com>

In upstream-v5.8, dsi_enable will operate panel_enable, but this
modification has been moved in v5.9. In order to ensure the timing of
dsi_power_on/off and the timing of pulling up/down the MIPI signal,
the modification of v5.9 is synchronized in this series of patches.

Change since v6:
1. Change comment back linux version to kernel 5.10.

Change since v5:
1. Merged [v5,1/5] drm/mediatek: Adjust the timing of mipi signal from
LP00 to LP11 to [v5,4/5] drm/mediatek: keep dsi as LP00 before dcs cmds
transfer, because in (v5,1/5) to adjust the dsi func sequence in order
to move to lane_ready func together in (v5, 4/5).

Changes since v4:
1. Dsi func modified to atomic operation.
2. Added fix tag.
3. Removed lane_ready print statement.

Changes since v3:
1. Rebase kernel-5.18-rc1.
2. Added dsi_enable protection.
3. Encapsulates the dsi_lane_ready function.

Changes since v2:
1. Rebase linux-next.

Changes since v1:
1. Dsi sequence marked with patch adjustment.
2. Fixes: mtk_dsi: Use the drm_panel_bridge.

Jitao Shi (2):
  drm/mediatek: Separate poweron/poweroff from enable/disable and define
    new funcs
  drm/mediatek: keep dsi as LP00 before dcs cmds transfer

Xinlei Lee (2):
  drm/mediatek: Modify dsi funcs to atomic operations
  drm/mediatek: Add pull-down MIPI operation in mtk_dsi_poweroff
    function

 drivers/gpu/drm/mediatek/mtk_dsi.c | 93 ++++++++++++++++++++----------
 1 file changed, 63 insertions(+), 30 deletions(-)

-- 
2.18.0

