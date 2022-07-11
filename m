Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D72DC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jul 2022 02:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiGKCzF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Jul 2022 22:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGKCzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 22:55:03 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DD3183B2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 19:55:01 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0ECD11A03BC;
        Mon, 11 Jul 2022 04:55:00 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CB1D41A03B1;
        Mon, 11 Jul 2022 04:54:59 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 4CF26180226C;
        Mon, 11 Jul 2022 10:54:58 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_utils: Drop usage of __clk_get_name()
Date:   Mon, 11 Jul 2022 10:39:50 +0800
Message-Id: <1657507190-14546-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid build errors when CONFIG_COMMON_CLK is not set/enabled.

ERROR: modpost: "__clk_get_name" [sound/soc/fsl/snd-soc-fsl-utils.ko] undefined!

Fixes: 7bad8125549c ("ASoC: fsl_utils: Add function to handle PLL clock source")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_utils.c b/sound/soc/fsl/fsl_utils.c
index 3e969c7bc1c5..d0fc430f7033 100644
--- a/sound/soc/fsl/fsl_utils.c
+++ b/sound/soc/fsl/fsl_utils.c
@@ -147,7 +147,7 @@ void fsl_asoc_reparent_pll_clocks(struct device *dev, struct clk *clk,
 	if (reparent) {
 		ret = clk_set_parent(p, npll);
 		if (ret < 0)
-			dev_warn(dev, "failed to set parent %s: %d\n", __clk_get_name(npll), ret);
+			dev_warn(dev, "failed to set parent:%d\n", ret);
 	}
 }
 EXPORT_SYMBOL(fsl_asoc_reparent_pll_clocks);
-- 
2.34.1

