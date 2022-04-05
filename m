Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9DBC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 00:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1838970AbiDFA5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 20:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457516AbiDEQDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:03:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CACCD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:58:30 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1nblZT-0004nd-AF; Tue, 05 Apr 2022 17:58:19 +0200
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <afa@pengutronix.de>)
        id 1nblZR-0038Jb-G8; Tue, 05 Apr 2022 17:58:17 +0200
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Viorel Suman <viorel.suman@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     kernel@pengutronix.de, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_sai: fix 1:1 bclk:mclk ratio support
Date:   Tue,  5 Apr 2022 17:57:31 +0200
Message-Id: <20220405155731.745413-1-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactoring in commit a50b7926d015 ("ASoC: fsl_sai: implement 1:1
bclk:mclk ratio support") led to the bypass never happening
as (ratio = 1) was caught in the existing if (ratio & 1) continue;
check. The correct check sequence instead is:

 - skip all ratios lower than one and higher than 512
 - skip all odd ratios except for 1:1
 - skip 1:1 ratio if and only if !support_1_1_ratio

And for all others, calculate the appropriate divider. Adjust the
code to facilitate this.

Fixes: a50b7926d015 ("ASoC: fsl_sai: implement 1:1 bclk:mclk ratio support")
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 sound/soc/fsl/fsl_sai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index a992d51568cc..50c377f16097 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -372,7 +372,7 @@ static int fsl_sai_set_bclk(struct snd_soc_dai *dai, bool tx, u32 freq)
 			continue;
 		if (ratio == 1 && !support_1_1_ratio)
 			continue;
-		else if (ratio & 1)
+		if ((ratio & 1) && ratio > 1)
 			continue;
 
 		diff = abs((long)clk_rate - ratio * freq);
-- 
2.30.2

