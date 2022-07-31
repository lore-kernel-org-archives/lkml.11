Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DCEC00140
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Jul 2022 09:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236581AbiGaJzk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Jul 2022 05:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236629AbiGaJzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 05:55:37 -0400
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579189580
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 02:55:32 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id I5fVoqW8d3uMYI5fVoOVxQ; Sun, 31 Jul 2022 11:55:31 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 31 Jul 2022 11:55:31 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Lee Jones <lee@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>,
        Milo Kim <Milo.Kim@ti.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/2] mfd: lp8788: Fix an error handling path in lp8788_probe()
Date:   Sun, 31 Jul 2022 11:55:27 +0200
Message-Id: <18398722da9df9490722d853e4797350189ae79b.1659261275.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Should an error occurs in mfd_add_devices(), some resources need to be
released, as already done in the .remove() function.

Add an error handling path and a lp8788_irq_exit() call to undo a previous
lp8788_irq_init().

Fixes: eea6b7cc53aa ("mfd: Add lp8788 mfd driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/mfd/lp8788.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/lp8788.c b/drivers/mfd/lp8788.c
index c223d2c6a363..998e8cc408a0 100644
--- a/drivers/mfd/lp8788.c
+++ b/drivers/mfd/lp8788.c
@@ -195,8 +195,16 @@ static int lp8788_probe(struct i2c_client *cl, const struct i2c_device_id *id)
 	if (ret)
 		return ret;
 
-	return mfd_add_devices(lp->dev, -1, lp8788_devs,
-			       ARRAY_SIZE(lp8788_devs), NULL, 0, NULL);
+	ret = mfd_add_devices(lp->dev, -1, lp8788_devs,
+			      ARRAY_SIZE(lp8788_devs), NULL, 0, NULL);
+	if (ret)
+		goto err_exit_irq;
+
+	return 0;
+
+err_exit_irq:
+	lp8788_irq_exit(lp);
+	return ret;
 }
 
 static int lp8788_remove(struct i2c_client *cl)
-- 
2.34.1

