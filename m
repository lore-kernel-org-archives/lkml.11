Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864B2C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 09:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbiCVJWP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 05:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbiCVJWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 05:22:13 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6F85D5CA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 02:20:46 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 024181F42543
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647940845;
        bh=RGXVtcqwObkEQ+VQOAEz9wVt9MEokAHE3MUZMVVtBvc=;
        h=From:To:Cc:Subject:Date:From;
        b=UzOwni4fe5KpVwbEvF0d/tDv9CWET0DGk7i0Y2J0bOi0gSgpOvoiaVUVDA1ZXEDKu
         CY5vufRptkjeDYrWaG4mUc6dBYcuWHulOFodk6OxZCkuN/Zlz7u9PhbolfPtBbhEqt
         N4TOjRzW+IMTkriCer9Qh6CE74x2PMxAPZKdWXlUPE7CmVo2UQSUR7ILhEnMhyTiZb
         PvdKO6vCCPqwt59DdAp3CocDdkKEOBM+avVgUoUoKwcrQkx4aHwABOweg9/3/b88Ed
         fyIwo+izlElu82xou8Sd9RqcUNcA+17/YTC+sdIVpB4Tv0ikETL7VK9Ud/twe1OYk+
         XO6/v3b2ZNtnw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, rex-bc.chen@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] soc: mediatek: mmsys: Add sw0_rst_offset for MT8192
Date:   Tue, 22 Mar 2022 10:20:40 +0100
Message-Id: <20220322092040.12010-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8192 has the same sw0 reset offset as MT8183: add the parameter
to be able to use mmsys as a reset controller for managing at
least the DSI reset line.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-mmsys.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index 4fc4c2c9ea20..f69521fabcce 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -70,6 +70,7 @@ static const struct mtk_mmsys_driver_data mt8192_mmsys_driver_data = {
 	.clk_driver = "clk-mt8192-mm",
 	.routes = mmsys_mt8192_routing_table,
 	.num_routes = ARRAY_SIZE(mmsys_mt8192_routing_table),
+	.sw0_rst_offset = MT8183_MMSYS_SW0_RST_B,
 };
 
 static const struct mtk_mmsys_driver_data mt8365_mmsys_driver_data = {
-- 
2.35.1

