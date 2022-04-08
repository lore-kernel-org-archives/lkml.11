Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22461C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Apr 2022 01:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbiDHBmC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Apr 2022 21:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbiDHBl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 21:41:59 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A570F2101
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 18:39:57 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 2E48A1F46A39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649381996;
        bh=Zoo0D97gEmqNrY989eMksqTtr9Q81mrxj7dB1t09D6s=;
        h=From:To:Cc:Subject:Date:From;
        b=SQ9QUQfCr2e2hvpXJL9p427drhnonB1hrAQ8NW3YHYwSh7XMHkrq68aZorlrf21qK
         rxNjA+g4ONZ9RezDcpv3/OYQjrUaiaBo0tlbsPaodSI0pBtpPdm0c1Y8JNg25LcGCM
         ocvAOI7iADHCPaxskD5eQYeZ12t3qdFf3IL4SHC8tItqZiP4fJyVaoUdoTvKwCFjRH
         ToDi6AZ2yynJchpugZDEsMe2PFFwramN38bqAYBmAhKLHqP73XvYN5dhhOI7eWrDCT
         5zhHtBpnbQ7QB55NIwNBTgjUNfbVLGYhetLLKjxnMm/NGfObTwaDWENbbgBENwLMlD
         CJpl9ajw90Gjg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2] drm/mediatek: dpi: Use mt8183 output formats for mt8192
Date:   Thu,  7 Apr 2022 21:39:50 -0400
Message-Id: <20220408013950.674477-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The configuration for mt8192 was incorrectly using the output formats
from mt8173. Since the output formats for mt8192 are instead the same
ones as for mt8183, which require two bus samples per pixel, the
pixelclock and DDR edge setting were misconfigured. This made external
displays unable to show the image.

Fix the issue by correcting the output format for mt8192 to be the same
as for mt8183, fixing the usage of external displays for mt8192.

Fixes: be63f6e8601f ("drm/mediatek: dpi: Add output bus formats to driver data")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v2:
- Added Fixes tag

 drivers/gpu/drm/mediatek/mtk_dpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 4554e2de1430..e61cd67b978f 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -819,8 +819,8 @@ static const struct mtk_dpi_conf mt8192_conf = {
 	.cal_factor = mt8183_calculate_factor,
 	.reg_h_fre_con = 0xe0,
 	.max_clock_khz = 150000,
-	.output_fmts = mt8173_output_fmts,
-	.num_output_fmts = ARRAY_SIZE(mt8173_output_fmts),
+	.output_fmts = mt8183_output_fmts,
+	.num_output_fmts = ARRAY_SIZE(mt8183_output_fmts),
 };
 
 static int mtk_dpi_probe(struct platform_device *pdev)
-- 
2.35.1

