Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139B4C00140
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Aug 2022 15:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243582AbiHHPjy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Aug 2022 11:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236284AbiHHPjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:39:49 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F5915710
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 08:39:46 -0700 (PDT)
X-QQ-mid: bizesmtp89t1659973164t11sh6ez
Received: from harry-jrlc.. ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 08 Aug 2022 23:39:11 +0800 (CST)
X-QQ-SSF: 0100000000200030C000B00A0000020
X-QQ-FEAT: lj50s4tNr7rRMoZO4mwcZ0ApOv2PYNPr7KBJyfSChxYy0fopckj29jg1ItjKz
        p/ZS8Lv3whhw1XAl0Da36VgUk3CifBbQRAGymrJmOSVdWBiIQdj0Xa4J+mYZDBG7/Fior31
        VWYvhfOHt9ATBTvqj5R9H1lnxpiVmQFSS/pUm+ic/okW40WYTO+RBiHvPJ7hjto+5qmlqbl
        iF7s12LmhkXsKm9mtt/tbleP5JllqFpkd/D+kPZzCqy6cX8mr+zrZ5/DvPZdkR8u1Oyxptl
        2TQegBp4Q1NAoiWMTe0/4tZr/Z9Khf/zeiwSX+SowjKmgQIGd0mQtS5ujXyPYKwNRAo5w2/
        RJo3PTN8gDIrpjHys5t1zNbxQsRXFy2FEA9CmfloYvXzeoiKYZRB+DfWePbOEzUWgyaBa7n
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] ASoC: Variable type completion
Date:   Mon,  8 Aug 2022 23:39:10 +0800
Message-Id: <20220808153910.59545-1-gaoxin@cdjrlc.com>
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
 sound/soc/codecs/uda134x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index 037833c509f7..607897f1f357 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -450,7 +450,7 @@ static int uda134x_soc_probe(struct snd_soc_component *component)
 	struct uda134x_priv *uda134x = snd_soc_component_get_drvdata(component);
 	struct uda134x_platform_data *pd = uda134x->pd;
 	const struct snd_soc_dapm_widget *widgets;
-	unsigned num_widgets;
+	unsigned int num_widgets;
 	int ret;
 
 	printk(KERN_INFO "UDA134X SoC Audio Codec\n");
-- 
2.30.2

