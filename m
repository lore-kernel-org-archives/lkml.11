Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3D7C4332F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 20:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243065AbiCBUT0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 15:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243047AbiCBUTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:19:24 -0500
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr [80.12.242.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7136D976
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 12:18:39 -0800 (PST)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id PVQinnfqASrXTPVQinhtrB; Wed, 02 Mar 2022 21:18:38 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 02 Mar 2022 21:18:38 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] Bluetooth: Don't assign twice the same value
Date:   Wed,  2 Mar 2022 21:18:35 +0100
Message-Id: <e2c2fe36c226529c99595370003d3cb1b7133c47.1646252285.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

data.pid is set twice with the same value. Remove one of these redundant
calls.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 net/bluetooth/l2cap_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index e817ff0607a0..0d460cb7f965 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1443,7 +1443,6 @@ static void l2cap_ecred_connect(struct l2cap_chan *chan)
 	data.pdu.scid[0]     = cpu_to_le16(chan->scid);
 
 	chan->ident = l2cap_get_ident(conn);
-	data.pid = chan->ops->get_peer_pid(chan);
 
 	data.count = 1;
 	data.chan = chan;
-- 
2.32.0

