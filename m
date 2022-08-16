Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D63C32772
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Aug 2022 17:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbiHPRzb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Aug 2022 13:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236826AbiHPRzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 13:55:09 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A6383BD7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 10:55:05 -0700 (PDT)
X-QQ-mid: bizesmtp89t1660672485t22m9r2k
Received: from harry-jrlc.. ( [182.148.12.144])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 17 Aug 2022 01:54:35 +0800 (CST)
X-QQ-SSF: 0100000000200060D000B00A0000020
X-QQ-FEAT: WRZea3rwxQm38bQtddIlQQzQMDVWPimn6PrcR59epaiQk0+6UIUD596bEHmjy
        ihl3I06UN9FxtDhlOy0SWIBUsOo0PNFUMNuZHuQw65SAGg+qpTKQp6ubvtZdpgBQvlHvqBh
        NGVIP31euZHvYV5C9f9stb5nTJ0TReJmwnlu8IDrRpN1Ono8o/TrbAapEV7wKJ0xlO74E9n
        dsYMXMsW7NliJi6zdYzDKx4iottjrN4GzHaeA52uN4hxTpbQTGdjEHSchRvgFZdapDvH+dr
        m05XcZtYIYX6K8YvnQPNzgBESus+kJUrJqAEuYiOw7PbqwGLmz/Ddj4PuO025+x6rzvDKcm
        S7ZxA88hcs1fr6Hljo/9mLWN+947Vf1cnE9WRLis/ogwwD6DHtLVpBxZr4qVg==
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     perex@perex.cz, tiwai@suse.com, peter.ujfalusi@gmail.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] ASoC: Variable type completion
Date:   Wed, 17 Aug 2022 01:54:34 +0800
Message-Id: <20220816175434.8263-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'unsigned int' is better than 'unsigned'.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 sound/soc/ti/davinci-evm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/ti/davinci-evm.c b/sound/soc/ti/davinci-evm.c
index 68d69e32681a..392bf17564bf 100644
--- a/sound/soc/ti/davinci-evm.c
+++ b/sound/soc/ti/davinci-evm.c
@@ -23,7 +23,7 @@
 
 struct snd_soc_card_drvdata_davinci {
 	struct clk *mclk;
-	unsigned sysclk;
+	unsigned int sysclk;
 };
 
 static int evm_startup(struct snd_pcm_substream *substream)
@@ -57,7 +57,7 @@ static int evm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
 	struct snd_soc_card *soc_card = rtd->card;
 	int ret = 0;
-	unsigned sysclk = ((struct snd_soc_card_drvdata_davinci *)
+	unsigned int sysclk = ((struct snd_soc_card_drvdata_davinci *)
 			   snd_soc_card_get_drvdata(soc_card))->sysclk;
 
 	/* set the codec system clock */
-- 
2.30.2

