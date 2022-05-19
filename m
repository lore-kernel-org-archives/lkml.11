Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A857C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 12:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237975AbiESMlw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 08:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236881AbiESMlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 08:41:49 -0400
Received: from cmccmta3.chinamobile.com (cmccmta3.chinamobile.com [221.176.66.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7DEBEA777A
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 05:41:45 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[172.16.121.1])
        by rmmx-syy-dmz-app10-12010 (RichMail) with SMTP id 2eea62863b06e15-a810c;
        Thu, 19 May 2022 20:41:43 +0800 (CST)
X-RM-TRANSID: 2eea62863b06e15-a810c
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.108.79.99])
        by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee162863b03441-e1d79;
        Thu, 19 May 2022 20:41:43 +0800 (CST)
X-RM-TRANSID: 2ee162863b03441-e1d79
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     olivier.moysan@foss.st.com, arnaud.pouliquen@foss.st.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com
Cc:     alsa-devel@alsa-project.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] ASoC: stm32: sai: Use of_device_get_match_data() to simplify code
Date:   Thu, 19 May 2022 20:42:35 +0800
Message-Id: <20220519124235.21100-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Retrieve of match data, it's better and cleaner to use
'of_device_get_match_data' over 'of_match_device'.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/stm/stm32_sai_sub.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index dd636af81..d300605a2 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1500,7 +1500,6 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 static int stm32_sai_sub_probe(struct platform_device *pdev)
 {
 	struct stm32_sai_sub_data *sai;
-	const struct of_device_id *of_id;
 	const struct snd_dmaengine_pcm_config *conf = &stm32_sai_pcm_config;
 	int ret;
 
@@ -1508,10 +1507,9 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
 	if (!sai)
 		return -ENOMEM;
 
-	of_id = of_match_device(stm32_sai_sub_ids, &pdev->dev);
-	if (!of_id)
+	sai->id = (uintptr_t)of_device_get_match_data(&pdev->dev);
+	if (!sai->id)
 		return -EINVAL;
-	sai->id = (uintptr_t)of_id->data;
 
 	sai->pdev = pdev;
 	mutex_init(&sai->ctrl_lock);
-- 
2.20.1.windows.1



