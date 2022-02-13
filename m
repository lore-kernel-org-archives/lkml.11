Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EA3C4332F
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Feb 2022 07:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbiBMHw7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Feb 2022 02:52:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbiBMHw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 02:52:57 -0500
Received: from smtp.smtpout.orange.fr (smtp07.smtpout.orange.fr [80.12.242.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE785E74F
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 23:52:52 -0800 (PST)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id J9ggnUnHkSDrIJ9ggnIPy2; Sun, 13 Feb 2022 08:52:51 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 13 Feb 2022 08:52:51 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] tda9950: Slightly simplify tda9950_devm_glue_init()
Date:   Sun, 13 Feb 2022 08:52:49 +0100
Message-Id: <8e8ce53c113547beb314d332cfdedbf05a2d7506.1644738725.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_add_action_or_reset() instead of hand writing it.
This is more straightforward and saves a few lines of code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/i2c/tda9950.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda9950.c b/drivers/gpu/drm/i2c/tda9950.c
index 5b03fdd1eaa4..526774594510 100644
--- a/drivers/gpu/drm/i2c/tda9950.c
+++ b/drivers/gpu/drm/i2c/tda9950.c
@@ -361,9 +361,7 @@ static int tda9950_devm_glue_init(struct device *dev, struct tda9950_glue *glue)
 			return ret;
 	}
 
-	ret = devm_add_action(dev, tda9950_devm_glue_exit, glue);
-	if (ret)
-		tda9950_devm_glue_exit(glue);
+	ret = devm_add_action_or_reset(dev, tda9950_devm_glue_exit, glue);
 
 	return ret;
 }
-- 
2.32.0

