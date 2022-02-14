Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08327C4332F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 20:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiBNUxw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 15:53:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiBNUxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 15:53:31 -0500
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1BEBB05
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 12:53:10 -0800 (PST)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id JgihnBT5U41cbJgihn7hOL; Mon, 14 Feb 2022 20:09:08 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 14 Feb 2022 20:09:08 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] net: hso: Use GFP_KERNEL instead of GFP_ATOMIC when possible
Date:   Mon, 14 Feb 2022 20:09:06 +0100
Message-Id: <93e4c78983de9a20b1f9009d79116591f20fd1c2.1644865733.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hso_create_device() is only called from function that already use
GFP_KERNEL. And all the callers are called from the probe function.

So there is no need here to explicitly require a GFP_ATOMIC when
allocating memory.

Use GFP_KERNEL instead.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/usb/hso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/hso.c b/drivers/net/usb/hso.c
index f97813a4e8d1..f8221a7acf62 100644
--- a/drivers/net/usb/hso.c
+++ b/drivers/net/usb/hso.c
@@ -2319,7 +2319,7 @@ static struct hso_device *hso_create_device(struct usb_interface *intf,
 {
 	struct hso_device *hso_dev;
 
-	hso_dev = kzalloc(sizeof(*hso_dev), GFP_ATOMIC);
+	hso_dev = kzalloc(sizeof(*hso_dev), GFP_KERNEL);
 	if (!hso_dev)
 		return NULL;
 
-- 
2.32.0

