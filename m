Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3373DC19F2D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Aug 2022 20:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242345AbiHIU27 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Aug 2022 16:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbiHIU24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:28:56 -0400
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA4315A06
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 13:28:54 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id LVqKodyw4sL0zLVqKoORai; Tue, 09 Aug 2022 22:28:52 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 09 Aug 2022 22:28:52 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2] usb: common: usb-conn-gpio: Simplify some error message
Date:   Tue,  9 Aug 2022 22:28:42 +0200
Message-Id: <7505a9dfa1e097070c492d6f6f84afa2a490b040.1659763173.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_err_probe() already prints the error code in a human readable way, so
there is no need to duplicate it as a numerical value at the end of the
message.

Fixes: ddaf0d6dc467 ("usb: common: usb-conn-gpio: use dev_err_probe() to print log")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Change in v2:
  * keep the message on the same line of dev_err_probe() because the line is
    still < 100 char   [Chunfeng Yun <chunfeng.yun@mediatek.com>]
---
 drivers/usb/common/usb-conn-gpio.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
index b39c9f1c375d..44c5127175b7 100644
--- a/drivers/usb/common/usb-conn-gpio.c
+++ b/drivers/usb/common/usb-conn-gpio.c
@@ -208,10 +208,8 @@ static int usb_conn_probe(struct platform_device *pdev)
 	if (PTR_ERR(info->vbus) == -ENODEV)
 		info->vbus = NULL;
 
-	if (IS_ERR(info->vbus)) {
-		ret = PTR_ERR(info->vbus);
-		return dev_err_probe(dev, ret, "failed to get vbus :%d\n", ret);
-	}
+	if (IS_ERR(info->vbus))
+		return dev_err_probe(dev, PTR_ERR(info->vbus), "failed to get vbus\n");
 
 	info->role_sw = usb_role_switch_get(dev);
 	if (IS_ERR(info->role_sw))
-- 
2.34.1

