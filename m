Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1C6C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Apr 2022 06:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240892AbiDCGMZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Apr 2022 02:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbiDCGMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 02:12:22 -0400
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C690832ED5
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 23:10:28 -0700 (PDT)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id atRRnoSgJN7CcatRSnMr9N; Sun, 03 Apr 2022 08:10:27 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 03 Apr 2022 08:10:27 +0200
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: codecs: Fix an error handling path in va_macro_probe()
Date:   Sun,  3 Apr 2022 08:10:24 +0200
Message-Id: <6d08311472e272fdc1a184f019ec98ade6e9dc46.1648966195.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After a successful lpass_macro_pds_init() call, lpass_macro_pds_exit() must
be called.

Add the missing call in the error handling path of the probe function and
use it.

Fixes: 9e3d83c52844 ("ASoC: codecs: Add power domains support in digital macro codecs")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/codecs/lpass-va-macro.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
index f3cb596058e0..d18b56e60433 100644
--- a/sound/soc/codecs/lpass-va-macro.c
+++ b/sound/soc/codecs/lpass-va-macro.c
@@ -1434,8 +1434,10 @@ static int va_macro_probe(struct platform_device *pdev)
 		va->dmic_clk_div = VA_MACRO_CLK_DIV_2;
 	} else {
 		ret = va_macro_validate_dmic_sample_rate(sample_rate, va);
-		if (!ret)
-			return -EINVAL;
+		if (!ret) {
+			ret = -EINVAL;
+			goto err;
+		}
 	}
 
 	base = devm_platform_ioremap_resource(pdev, 0);
@@ -1492,6 +1494,8 @@ static int va_macro_probe(struct platform_device *pdev)
 err_dcodec:
 	clk_disable_unprepare(va->macro);
 err:
+	lpass_macro_pds_exit(va->pds);
+
 	return ret;
 }
 
-- 
2.32.0

