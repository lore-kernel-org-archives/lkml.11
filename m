Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0B3C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Feb 2022 06:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242160AbiBTGh3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Feb 2022 01:37:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234353AbiBTGh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 01:37:26 -0500
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr [80.12.242.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA1B4160B
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 22:37:04 -0800 (PST)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id Lfq8nvjhNuCn2Lfq9nuQtp; Sun, 20 Feb 2022 07:37:02 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 20 Feb 2022 07:37:02 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
        Sean Tranchetti <stranche@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        netdev@vger.kernel.org
Subject: [PATCH] net: qualcomm: rmnet: Use skb_put_zero() to simplify code
Date:   Sun, 20 Feb 2022 07:36:59 +0100
Message-Id: <8abfe32db956f335d65638dfafdd3577ab6baf0e.1645338968.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use skb_put_zero() instead of hand-writing it. This saves a few lines of
code and is more readable.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
index 3676976c875b..ba194698cc14 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
@@ -298,7 +298,6 @@ struct rmnet_map_header *rmnet_map_add_map_header(struct sk_buff *skb,
 {
 	struct rmnet_map_header *map_header;
 	u32 padding, map_datalen;
-	u8 *padbytes;
 
 	map_datalen = skb->len - hdrlen;
 	map_header = (struct rmnet_map_header *)
@@ -323,8 +322,7 @@ struct rmnet_map_header *rmnet_map_add_map_header(struct sk_buff *skb,
 	if (skb_tailroom(skb) < padding)
 		return NULL;
 
-	padbytes = (u8 *)skb_put(skb, padding);
-	memset(padbytes, 0, padding);
+	skb_put_zero(skb, padding);
 
 done:
 	map_header->pkt_len = htons(map_datalen + padding);
-- 
2.32.0

