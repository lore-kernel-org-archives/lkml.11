Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDABEC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Jul 2022 02:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiGDCFQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Jul 2022 22:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiGDCFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 22:05:09 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBC255A3
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 19:05:08 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 74DFB202CC0;
        Mon,  4 Jul 2022 04:05:07 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2C1AF202CBA;
        Mon,  4 Jul 2022 04:05:07 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E98A9180222D;
        Mon,  4 Jul 2022 10:05:05 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ASoC: fsl_asrc_dma: Add legacy_dai_naming flag
Date:   Mon,  4 Jul 2022 09:50:17 +0800
Message-Id: <1656899417-4775-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1656899417-4775-1-git-send-email-shengjiu.wang@nxp.com>
References: <1656899417-4775-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Need to add legacy_dai_naming flag otherwise there
will be issue when registerring component, that cause
the probe failure.

Fixes: 1e63fcc74ace ("ASoC: fsl: Migrate to new style legacy DAI naming flag")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_asrc_dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
index 33eabb96340e..12ddf2320f2d 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -455,5 +455,6 @@ struct snd_soc_component_driver fsl_asrc_component = {
 	.close		= fsl_asrc_dma_shutdown,
 	.pointer	= fsl_asrc_dma_pcm_pointer,
 	.pcm_construct	= fsl_asrc_dma_pcm_new,
+	.legacy_dai_naming = 1,
 };
 EXPORT_SYMBOL_GPL(fsl_asrc_component);
-- 
2.17.1

