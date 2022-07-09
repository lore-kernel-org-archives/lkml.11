Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA12CCA47C
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Jul 2022 14:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiGIOYx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Jul 2022 10:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiGIOYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 10:24:51 -0400
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr [80.12.242.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBB31261E
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 07:24:50 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id ABO2oJ7IeV0xUABO2oTBqZ; Sat, 09 Jul 2022 16:24:48 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 09 Jul 2022 16:24:48 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Kurt Kanzenbach <kurt@linutronix.de>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        netdev@vger.kernel.org
Subject: [PATCH] net: dsa: hellcreek: Use the bitmap API to allocate bitmaps
Date:   Sat,  9 Jul 2022 16:24:45 +0200
Message-Id: <8306e2ae69a5d8553691f5d10a86a4390daf594b.1657376651.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_bitmap_zalloc() instead of hand-writing them.

It is less verbose and it improves the semantic.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/dsa/hirschmann/hellcreek.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/hirschmann/hellcreek.c b/drivers/net/dsa/hirschmann/hellcreek.c
index ac1f3b3a7040..01f90994dedd 100644
--- a/drivers/net/dsa/hirschmann/hellcreek.c
+++ b/drivers/net/dsa/hirschmann/hellcreek.c
@@ -1894,11 +1894,8 @@ static int hellcreek_probe(struct platform_device *pdev)
 		if (!port->counter_values)
 			return -ENOMEM;
 
-		port->vlan_dev_bitmap =
-			devm_kcalloc(dev,
-				     BITS_TO_LONGS(VLAN_N_VID),
-				     sizeof(unsigned long),
-				     GFP_KERNEL);
+		port->vlan_dev_bitmap = devm_bitmap_zalloc(dev, VLAN_N_VID,
+							   GFP_KERNEL);
 		if (!port->vlan_dev_bitmap)
 			return -ENOMEM;
 
-- 
2.34.1

