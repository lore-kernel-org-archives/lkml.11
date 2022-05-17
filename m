Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595B7C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 May 2022 10:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbiEQKsK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 06:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344637AbiEQKrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:47:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EB93586D
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 03:47:21 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id E3F191F444DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652784439;
        bh=MLqxd/IjlSeY2GDsSI1KlnI1vGQP5dVUftmAib5K04o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QNyvb2phZdrqGVaUoRJthJA+Fd9C7Ly74QIkKfzMXxASauqpTJ4QTm5kwjgJnu3ij
         LcqlxwNywXh5ATm06mX7cohq2ynIwmB+RkjNcddVkzm6bmwBRtuc7mglidsrCnOiyD
         LsuQyX2D7R5UOmdwfJ9zxiBqwkuEnx959DBbj5U1Yau38amyREgA7g9FL2K0ux0Xu0
         FokhM/PTd6xDXyE99kbslssb5yGcXXhhyzSrsaMWK3tIJu1hopoc4kZw5s5+nGKk0X
         5ypqhgNY8vd3/gjd+l89KfeuYH/dCo0tmiKegB/IxC2zDG7cx9+w4s5MlXzB8vtWY/
         dSNzmZqti4i+Q==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        zhiyong.tao@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v4 5/5] soc: mediatek: pwrap: Compress of_device_id entries to one line
Date:   Tue, 17 May 2022 12:47:12 +0200
Message-Id: <20220517104712.24579-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517104712.24579-1-angelogioacchino.delregno@collabora.com>
References: <20220517104712.24579-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compress each entry of the of_device_id tables in this driver to one
line instead of three, as they fit just fine in a single line.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 91 ++++++++--------------------
 1 file changed, 25 insertions(+), 66 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 14f31a9fc792..d8cb0f833645 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -1960,33 +1960,18 @@ static const struct pwrap_slv_type pmic_mt6397 = {
 };
 
 static const struct of_device_id of_slave_match_tbl[] = {
-	{
-		.compatible = "mediatek,mt6323",
-		.data = &pmic_mt6323,
-	}, {
-		.compatible = "mediatek,mt6351",
-		.data = &pmic_mt6351,
-	}, {
-		.compatible = "mediatek,mt6357",
-		.data = &pmic_mt6357,
-	}, {
-		.compatible = "mediatek,mt6358",
-		.data = &pmic_mt6358,
-	}, {
-		.compatible = "mediatek,mt6359",
-		.data = &pmic_mt6359,
-	}, {
-		/* The MT6380 PMIC only implements a regulator, so we bind it
-		 * directly instead of using a MFD.
-		 */
-		.compatible = "mediatek,mt6380-regulator",
-		.data = &pmic_mt6380,
-	}, {
-		.compatible = "mediatek,mt6397",
-		.data = &pmic_mt6397,
-	}, {
-		/* sentinel */
-	}
+	{ .compatible = "mediatek,mt6323", .data = &pmic_mt6323 },
+	{ .compatible = "mediatek,mt6351", .data = &pmic_mt6351 },
+	{ .compatible = "mediatek,mt6357", .data = &pmic_mt6357 },
+	{ .compatible = "mediatek,mt6358", .data = &pmic_mt6358 },
+	{ .compatible = "mediatek,mt6359", .data = &pmic_mt6359 },
+
+	/* The MT6380 PMIC only implements a regulator, so we bind it
+	 * directly instead of using a MFD.
+	 */
+	{ .compatible = "mediatek,mt6380-regulator", .data = &pmic_mt6380 },
+	{ .compatible = "mediatek,mt6397", .data = &pmic_mt6397 },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_slave_match_tbl);
 
@@ -2145,45 +2130,19 @@ static struct pmic_wrapper_type pwrap_mt8186 = {
 };
 
 static const struct of_device_id of_pwrap_match_tbl[] = {
-	{
-		.compatible = "mediatek,mt2701-pwrap",
-		.data = &pwrap_mt2701,
-	}, {
-		.compatible = "mediatek,mt6765-pwrap",
-		.data = &pwrap_mt6765,
-	}, {
-		.compatible = "mediatek,mt6779-pwrap",
-		.data = &pwrap_mt6779,
-	}, {
-		.compatible = "mediatek,mt6797-pwrap",
-		.data = &pwrap_mt6797,
-	}, {
-		.compatible = "mediatek,mt6873-pwrap",
-		.data = &pwrap_mt6873,
-	}, {
-		.compatible = "mediatek,mt7622-pwrap",
-		.data = &pwrap_mt7622,
-	}, {
-		.compatible = "mediatek,mt8135-pwrap",
-		.data = &pwrap_mt8135,
-	}, {
-		.compatible = "mediatek,mt8173-pwrap",
-		.data = &pwrap_mt8173,
-	}, {
-		.compatible = "mediatek,mt8183-pwrap",
-		.data = &pwrap_mt8183,
-	}, {
-		.compatible = "mediatek,mt8186-pwrap",
-		.data = &pwrap_mt8186,
-	}, {
-		.compatible = "mediatek,mt8195-pwrap",
-		.data = &pwrap_mt8195,
-	}, {
-		.compatible = "mediatek,mt8516-pwrap",
-		.data = &pwrap_mt8516,
-	}, {
-		/* sentinel */
-	}
+	{ .compatible = "mediatek,mt2701-pwrap", .data = &pwrap_mt2701 },
+	{ .compatible = "mediatek,mt6765-pwrap", .data = &pwrap_mt6765 },
+	{ .compatible = "mediatek,mt6779-pwrap", .data = &pwrap_mt6779 },
+	{ .compatible = "mediatek,mt6797-pwrap", .data = &pwrap_mt6797 },
+	{ .compatible = "mediatek,mt6873-pwrap", .data = &pwrap_mt6873 },
+	{ .compatible = "mediatek,mt7622-pwrap", .data = &pwrap_mt7622 },
+	{ .compatible = "mediatek,mt8135-pwrap", .data = &pwrap_mt8135 },
+	{ .compatible = "mediatek,mt8173-pwrap", .data = &pwrap_mt8173 },
+	{ .compatible = "mediatek,mt8183-pwrap", .data = &pwrap_mt8183 },
+	{ .compatible = "mediatek,mt8186-pwrap", .data = &pwrap_mt8186 },
+	{ .compatible = "mediatek,mt8195-pwrap", .data = &pwrap_mt8195 },
+	{ .compatible = "mediatek,mt8516-pwrap", .data = &pwrap_mt8516 },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_pwrap_match_tbl);
 
-- 
2.35.1

