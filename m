Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12646C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 May 2022 04:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385055AbiEFE2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 May 2022 00:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388949AbiEFE1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 00:27:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C859606C4
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 21:24:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1nmpVY-0001Xt-Pt; Fri, 06 May 2022 06:24:00 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1nmpVY-000dda-Sm; Fri, 06 May 2022 06:23:59 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1nmpVV-003s8W-RF; Fri, 06 May 2022 06:23:57 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH net-next v4 0/7] add ti dp83td510 support
Date:   Fri,  6 May 2022 06:23:50 +0200
Message-Id: <20220506042357.923026-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes v4:
- dp83td510: remove unused variables
- s/base1/baset1
- s/genphy_c45_baset1_read_master_slave/genphy_c45_pma_baset1_read_master_slave

changes v3:
- export reusable code snippets and make use of it in the dp83td510
  driver

changes v2:
- rewrite the driver reduce usage of common code and to reduce amount of
  quirks.
- add genphy_c45_baset1_an_config_aneg fix

Oleksij Rempel (7):
  net: phy: genphy_c45_baset1_an_config_aneg: do no set unknown
    configuration
  net: phy: introduce genphy_c45_pma_baset1_setup_master_slave()
  net: phy: genphy_c45_pma_baset1_setup_master_slave: do no set unknown
    configuration
  net: phy: introduce genphy_c45_pma_baset1_read_master_slave()
  net: phy: genphy_c45_pma_baset1_read_master_slave: read actual
    configuration
  net: phy: export genphy_c45_baset1_read_status()
  net: phy: dp83td510: Add support for the DP83TD510 Ethernet PHY

 drivers/net/phy/Kconfig     |   6 ++
 drivers/net/phy/Makefile    |   1 +
 drivers/net/phy/dp83td510.c | 209 ++++++++++++++++++++++++++++++++++++
 drivers/net/phy/phy-c45.c   |  94 +++++++++++-----
 include/linux/phy.h         |   3 +
 5 files changed, 286 insertions(+), 27 deletions(-)
 create mode 100644 drivers/net/phy/dp83td510.c

-- 
2.30.2

