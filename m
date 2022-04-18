Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7D2C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Apr 2022 14:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344156AbiDRObI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Apr 2022 10:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344435AbiDRO10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 10:27:26 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C6A3D4A7;
        Mon, 18 Apr 2022 06:22:27 -0700 (PDT)
X-UUID: 478f1e42afa8418a9f84e047eeeeb5d5-20220418
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:a5365a37-5858-402c-9d48-828d53eb06b3,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:-20
X-CID-META: VersionHash:faefae9,CLOUDID:4c9c41ef-06b0-4305-bfbf-554bfc9d151a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 478f1e42afa8418a9f84e047eeeeb5d5-20220418
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1602028884; Mon, 18 Apr 2022 21:22:23 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 18 Apr 2022 21:22:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 18 Apr 2022 21:22:22 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <matthias.bgg@gmail.com>, <p.zabel@pengutronix.de>,
        <angelogioacchino.delregno@collabora.com>,
        <chun-jie.chen@mediatek.com>, <wenst@chromium.org>,
        <yong.liang@mediatek.com>, <runyang.chen@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <allen-kh.cheng@mediatek.com>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH 0/7] Cleanup MediaTek clk reset drivers
Date:   Mon, 18 Apr 2022 21:21:47 +0800
Message-ID: <20220418132154.7401-1-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this series, we cleanup MediaTek clock reset drivers in clk/mediatek
folder. MediaTek clock reset driver is used to provide reset control
of modules controlled in clk, like infra_ao.

Rex-BC Chen (7):
  clk: mediatek: reset: Correct the logic of setting register
  clk: mediatek: reset: Rename reset function
  clk: mediatek: reset: Merge and revise reset register function
  clk: mediatek: reset: Add reset.h
  clk: mediatek: reset: Revise structure to control reset register
  clk: mediatek: reset: Add support for unregister reset controller
  clk: mediatek: reset: Add reset support for simple probe/remove

 drivers/clk/mediatek/clk-mt2701-eth.c |  15 ++-
 drivers/clk/mediatek/clk-mt2701-g3d.c |  15 ++-
 drivers/clk/mediatek/clk-mt2701-hif.c |  11 +-
 drivers/clk/mediatek/clk-mt2701.c     |  23 +++-
 drivers/clk/mediatek/clk-mt2712.c     |  31 ++++--
 drivers/clk/mediatek/clk-mt7622-eth.c |  15 ++-
 drivers/clk/mediatek/clk-mt7622-hif.c |  31 ++++--
 drivers/clk/mediatek/clk-mt7622.c     |  23 +++-
 drivers/clk/mediatek/clk-mt7629-eth.c |  15 ++-
 drivers/clk/mediatek/clk-mt7629-hif.c |  31 ++++--
 drivers/clk/mediatek/clk-mt8135.c     |  27 ++++-
 drivers/clk/mediatek/clk-mt8173.c     |  27 ++++-
 drivers/clk/mediatek/clk-mt8183.c     |  11 +-
 drivers/clk/mediatek/clk-mtk.c        |   6 +
 drivers/clk/mediatek/clk-mtk.h        |   8 +-
 drivers/clk/mediatek/reset.c          | 153 ++++++++++++++------------
 drivers/clk/mediatek/reset.h          |  32 ++++++
 17 files changed, 331 insertions(+), 143 deletions(-)
 create mode 100644 drivers/clk/mediatek/reset.h

-- 
2.18.0

