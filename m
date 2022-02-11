Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F89C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Feb 2022 14:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350815AbiBKOan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Feb 2022 09:30:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244392AbiBKOak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:30:40 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AFFC7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 06:30:35 -0800 (PST)
X-UUID: 8edd6da05a0c43f89da27ca9a5e56cb2-20220211
X-UUID: 8edd6da05a0c43f89da27ca9a5e56cb2-20220211
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <xinlei.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1675523189; Fri, 11 Feb 2022 22:30:29 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 11 Feb 2022 22:30:28 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 11 Feb
 2022 22:30:26 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Fri, 11 Feb 2022 22:30:22 +0800
From:   <xinlei.lee@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <matthias.bgg@gmail.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <rex-bc.chen@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        xinlei lee <xinlei.lee@mediatek.com>
Subject: [0/3] Cooperate with DSI RX devices to modify dsi funcs and delay mipi high to cooperate with panel sequence
Date:   Fri, 11 Feb 2022 22:30:14 +0800
Message-ID: <1644589818-13066-1-git-send-email-xinlei.lee@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xinlei lee <xinlei.lee@mediatek.com>

In order to match the changes of DSI RX devices (for example, anx7625), 
the poweron/poweroff of dsi is extracted from enable/disable and 
defined as new funcs (pre_enable/post_disable).

The delayed MIPI signal is pulled high from LP00 to LP11, 
in order to match the power-on sequence of the panel.

Jitao Shi (3):
  drm/mediatek: dsi fine tune the dsi poweron flow
  drm/mediatek: dsi bridge implement pre_enable and post_disable
  drm/mediatek: keep dsi as LP00 before dcs cmds transfer

 drivers/gpu/drm/mediatek/mtk_dsi.c | 73 +++++++++++++++++++++++++-------------
 1 file changed, 49 insertions(+), 24 deletions(-)

-- 
2.6.4

