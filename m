Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2604DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 10:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236646AbiBOKn3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 05:43:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235867AbiBOKn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 05:43:28 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08EBAFF5A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 02:43:18 -0800 (PST)
Received: from hednb3.intra.ispras.ru (unknown [10.10.2.52])
        by mail.ispras.ru (Postfix) with ESMTPSA id A62904076B21;
        Tue, 15 Feb 2022 10:43:16 +0000 (UTC)
From:   Alexey Khoroshilov <khoroshilov@ispras.ru>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] net: dsa: lantiq_gswip: fix use after free in gswip_remove()
Date:   Tue, 15 Feb 2022 13:42:48 +0300
Message-Id: <1644921768-26477-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_node_put(priv->ds->slave_mii_bus->dev.of_node) should be
done before mdiobus_free(priv->ds->slave_mii_bus).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Fixes: 0d120dfb5d67 ("net: dsa: lantiq_gswip: don't use devres for mdiobus")
---
 drivers/net/dsa/lantiq_gswip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index 320ee7fe91a8..8a7a8093a156 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -2176,8 +2176,8 @@ static int gswip_remove(struct platform_device *pdev)
 
 	if (priv->ds->slave_mii_bus) {
 		mdiobus_unregister(priv->ds->slave_mii_bus);
-		mdiobus_free(priv->ds->slave_mii_bus);
 		of_node_put(priv->ds->slave_mii_bus->dev.of_node);
+		mdiobus_free(priv->ds->slave_mii_bus);
 	}
 
 	for (i = 0; i < priv->num_gphy_fw; i++)
-- 
2.7.4

