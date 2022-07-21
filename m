Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338A0C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jul 2022 09:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbiGUJCa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jul 2022 05:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiGUJC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:02:29 -0400
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC4542AC8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:02:28 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id ES4doiupgxFTAES4eoDEeb; Thu, 21 Jul 2022 11:02:26 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 21 Jul 2022 11:02:26 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: qcom: q6dsp: Fix an off-by-one in q6adm_alloc_copp()
Date:   Thu, 21 Jul 2022 11:02:22 +0200
Message-Id: <0fca3271649736053eb9649d87e1ca01b056be40.1658394124.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_first_zero_bit() returns MAX_COPPS_PER_PORT at max here.
So 'idx' should be tested with ">=" or the test can't match.

Fixes: 7b20b2be51e1 ("ASoC: qdsp6: q6adm: Add q6adm driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/qcom/qdsp6/q6adm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6adm.c b/sound/soc/qcom/qdsp6/q6adm.c
index 01f383888b62..1530e98df165 100644
--- a/sound/soc/qcom/qdsp6/q6adm.c
+++ b/sound/soc/qcom/qdsp6/q6adm.c
@@ -217,7 +217,7 @@ static struct q6copp *q6adm_alloc_copp(struct q6adm *adm, int port_idx)
 	idx = find_first_zero_bit(&adm->copp_bitmap[port_idx],
 				  MAX_COPPS_PER_PORT);
 
-	if (idx > MAX_COPPS_PER_PORT)
+	if (idx >= MAX_COPPS_PER_PORT)
 		return ERR_PTR(-EBUSY);
 
 	c = kzalloc(sizeof(*c), GFP_ATOMIC);
-- 
2.34.1

