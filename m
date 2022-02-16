Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2B1C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Feb 2022 02:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343611AbiBPCLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 21:11:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiBPCLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 21:11:33 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04620FBA71
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 18:11:21 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0V4b3tCJ_1644977477;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V4b3tCJ_1644977477)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Feb 2022 10:11:18 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     perex@perex.cz
Cc:     tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org,
        quic_srivasam@quicinc.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] ASoC: codec: wcd938x: Fix NULL but dereferenced coccicheck error
Date:   Wed, 16 Feb 2022 10:11:16 +0800
Message-Id: <20220216021116.94384-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the following coccicheck warning:
./sound/soc/codecs/wcd938x.c:4210:21-24: ERROR: component is NULL but
dereferenced.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: 013cc2aea0f6 ("ASoC: codec: wcd938x: Add switch control for selecting CTIA/OMTP Headset")
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 sound/soc/codecs/wcd938x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 2663fe0bf64f..c46c4bfd84f2 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -4207,7 +4207,7 @@ static bool wcd938x_swap_gnd_mic(struct snd_soc_component *component, bool activ
 	struct wcd938x_priv *wcd938x;
 
 	if (!component) {
-		dev_err(component->dev, "%s component is NULL\n", __func__);
+		pr_err("The snd_soc_component is NULL\n");
 		return false;
 	}
 
-- 
2.20.1.7.g153144c

