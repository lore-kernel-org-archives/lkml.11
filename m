Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68FFC433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 May 2022 04:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388992AbiEFE2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 May 2022 00:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380327AbiEFE1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 00:27:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DF760074
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 21:24:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1nmpVY-0001Xo-Pp; Fri, 06 May 2022 06:24:00 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1nmpVY-000ddL-9E; Fri, 06 May 2022 06:23:58 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1nmpVV-003s9F-Ur; Fri, 06 May 2022 06:23:57 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH net-next v4 5/7] net: phy: genphy_c45_pma_baset1_read_master_slave: read actual configuration
Date:   Fri,  6 May 2022 06:23:55 +0200
Message-Id: <20220506042357.923026-6-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220506042357.923026-1-o.rempel@pengutronix.de>
References: <20220506042357.923026-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since MDIO_PMA_PMD_BT1_CTRL register shows actual configuration (and
forced state configuration is equal to the state), we should show
this configuration for ethtool.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/phy-c45.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index d440b76a18b4..a0684c716a2e 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -560,15 +560,19 @@ int genphy_c45_pma_baset1_read_master_slave(struct phy_device *phydev)
 	int val;
 
 	phydev->master_slave_state = MASTER_SLAVE_STATE_UNKNOWN;
+	phydev->master_slave_get = MASTER_SLAVE_CFG_UNKNOWN;
 
 	val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_PMD_BT1_CTRL);
 	if (val < 0)
 		return val;
 
-	if (val & MDIO_PMA_PMD_BT1_CTRL_CFG_MST)
+	if (val & MDIO_PMA_PMD_BT1_CTRL_CFG_MST) {
+		phydev->master_slave_get = MASTER_SLAVE_CFG_MASTER_FORCE;
 		phydev->master_slave_state = MASTER_SLAVE_STATE_MASTER;
-	else
+	} else {
+		phydev->master_slave_get = MASTER_SLAVE_CFG_SLAVE_FORCE;
 		phydev->master_slave_state = MASTER_SLAVE_STATE_SLAVE;
+	}
 
 	return 0;
 }
-- 
2.30.2

