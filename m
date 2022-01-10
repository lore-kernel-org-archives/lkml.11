Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C0FC4332F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jan 2022 21:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344985AbiAJVcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jan 2022 16:32:50 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:62983 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244307AbiAJVcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 16:32:48 -0500
Received: from pop-os.home ([90.11.185.88])
        by smtp.orange.fr with ESMTPA
        id 72HTnAgehniux72HTnshQN; Mon, 10 Jan 2022 22:32:46 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 10 Jan 2022 22:32:46 +0100
X-ME-IP: 90.11.185.88
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Marek Lindner <mareklindner@neomailbox.ch>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Antonio Quartulli <a@unstable.cc>,
        Sven Eckelmann <sven@narfation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org
Subject: [PATCH] batman-adv: Remove redundant 'flush_workqueue()' calls
Date:   Mon, 10 Jan 2022 22:32:27 +0100
Message-Id: <2c2454cd728f427cada2c24cdb1ef2609dec5efc.1641850318.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'destroy_workqueue()' already drains the queue before destroying it, so
there is no need to flush it explicitly.

Remove the redundant 'flush_workqueue()' calls.

This was generated with coccinelle:

@@
expression E;
@@
- 	flush_workqueue(E);
	destroy_workqueue(E);

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 net/batman-adv/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 5207cd8d6ad8..8f1b724d0412 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -132,7 +132,6 @@ static void __exit batadv_exit(void)
 	rtnl_link_unregister(&batadv_link_ops);
 	unregister_netdevice_notifier(&batadv_hard_if_notifier);
 
-	flush_workqueue(batadv_event_workqueue);
 	destroy_workqueue(batadv_event_workqueue);
 	batadv_event_workqueue = NULL;
 
-- 
2.32.0

