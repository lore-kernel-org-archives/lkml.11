Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084B9C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 17:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242426AbiESRKd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 13:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242403AbiESRK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:10:29 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D21E9CF7A
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:10:27 -0700 (PDT)
Received: from hednb3.intra.ispras.ru (unknown [10.10.2.52])
        by mail.ispras.ru (Postfix) with ESMTPSA id 1E21240755F2;
        Thu, 19 May 2022 17:10:21 +0000 (UTC)
From:   Alexey Khoroshilov <khoroshilov@ispras.ru>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] ASoC: max98090: Remove unneeded check in max98090_put_enab_tlv()
Date:   Thu, 19 May 2022 20:10:12 +0300
Message-Id: <1652980212-21473-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable sel is of unsigned int type, so sel < 0 is not required.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Fixes: 2fbe467bcbfc ("ASoC: max98090: Reject invalid values in custom control put()")
---
 sound/soc/codecs/max98090.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 62b41ca050a2..c535a8496bf1 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -413,7 +413,7 @@ static int max98090_put_enab_tlv(struct snd_kcontrol *kcontrol,
 
 	val = (val >> mc->shift) & mask;
 
-	if (sel < 0 || sel > mc->max)
+	if (sel > mc->max)
 		return -EINVAL;
 
 	*select = sel;
-- 
2.7.4

