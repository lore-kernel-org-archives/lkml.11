Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88D4C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Apr 2022 09:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344774AbiDAJsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Apr 2022 05:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344742AbiDAJrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 05:47:45 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6450026B5BF;
        Fri,  1 Apr 2022 02:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1648806355; x=1680342355;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ix84LapGlJhLR1dcJ3nwj0Z8S4KPIohgPEkaTYvfGXc=;
  b=qt0QVp3xug1moWEg0N6ilehx8tfw9OrGeIjp83GoxFL0SApjyFEPSxPj
   bAB3l8O/MnqSgEpP3mqMi34rYt2m9F7k2ERmaQU1thSc4p2wcxAHtKTVW
   AWytezsGMnlE7hSyxY2jkc2q4jeUdXlmM9lKZk4wUsIsSdRBjIuEd3gbq
   7rdMYZhYXoCvAeCfCG/eMB1er05UHqOmdf8I7mhJCf4nPsTU6n8YUOX7p
   vcShwMgYoaKgGiItzdA8EqaGwTSfURYJF4v47yiTlYE4s9nL7MCZPBxqI
   RD4YRgll7aiCTUURpi3MqEV2yHj01xvhe3P50OcSIwkn6+Cu1bNk5Gx5a
   A==;
X-IronPort-AV: E=Sophos;i="5.90,226,1643698800"; 
   d="scan'208";a="167969759"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Apr 2022 02:45:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 1 Apr 2022 02:45:54 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 1 Apr 2022 02:45:51 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <Divya.Koppera@microchip.com>, <davem@davemloft.net>,
        <kuba@kernel.org>, <richardcochran@gmail.com>,
        <UNGLinuxDriver@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net 3/3] net: phy: micrel: Remove DT option lan8814,ignore-ts
Date:   Fri, 1 Apr 2022 11:48:05 +0200
Message-ID: <20220401094805.3343464-4-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220401094805.3343464-1-horatiu.vultur@microchip.com>
References: <20220401094805.3343464-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the PHY and the MAC are capable of doing timestamping, the PHY has
priority. Therefore the DT option lan8814,ignore-ts was added such that
the PHY will not expose a PHC so then the timestamping was done in the
MAC. This is not the correct approach of doing it, therefore remove
this.

Fixes: ece19502834d84 ("net: phy: micrel: 1588 support for LAN8814 phy")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/micrel.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 886ea99b3906..fc53b71dc872 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -2629,8 +2629,7 @@ static int lan8814_probe(struct phy_device *phydev)
 	phydev->priv = priv;
 
 	if (!IS_ENABLED(CONFIG_PTP_1588_CLOCK) ||
-	    !IS_ENABLED(CONFIG_NETWORK_PHY_TIMESTAMPING) ||
-	    of_property_read_bool(np, "lan8814,ignore-ts"))
+	    !IS_ENABLED(CONFIG_NETWORK_PHY_TIMESTAMPING))
 		return 0;
 
 	/* Strap-in value for PHY address, below register read gives starting
-- 
2.33.0

