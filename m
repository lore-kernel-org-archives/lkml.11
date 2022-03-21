Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D32C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 15:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348876AbiCUPzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 11:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348791AbiCUPzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:55:45 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856E0A94E5;
        Mon, 21 Mar 2022 08:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1647878060; x=1679414060;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oFvBuAI3AFTfTX4VEPERgc9VNdNmgIoULtzLNBNUTuU=;
  b=1ZkJkalU1dQ9o93F8UbyQgi9gXVoYyLvUNW++AkYvhwtUhKJXr10iiXH
   uEGapbaZC+w6L/Htj6tEBQcXY21h7zMR+Aj9gY9G/ViesVgh08UBnV5q8
   6nHN2Yp8/8pfMcO6ly+VV7o60mUNwMQsajM5jpkG1qeu7SmPaEe7lPqUo
   zin9z8CIxk3oAb9mXLhFeIIZAjjVw7R19KXm6cNgwmSYB1b4ygzVYORjH
   kIgfPfifntrysrykrADQm8mU1KMVSJ8D6v/T6K4C1xbu90M7YStBzYJZo
   Mef7aDMWr0cV1yIKXr8JekMDgjfbSlVsAEkn7ScaHwTO2iVIHCPAByo2l
   A==;
X-IronPort-AV: E=Sophos;i="5.90,199,1643698800"; 
   d="scan'208";a="89617579"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Mar 2022 08:54:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 21 Mar 2022 08:54:19 -0700
Received: from CHE-LT-I17769U.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 21 Mar 2022 08:54:14 -0700
From:   Arun Ramadoss <arun.ramadoss@microchip.com>
To:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Russell King <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, <UNGLinuxDriver@microchip.com>
Subject: [RFC Patch net-next 2/3] net: phy: lan937x: added PHY_POLL_CABLE_TEST flag
Date:   Mon, 21 Mar 2022 21:23:36 +0530
Message-ID: <20220321155337.16260-3-arun.ramadoss@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220321155337.16260-1-arun.ramadoss@microchip.com>
References: <20220321155337.16260-1-arun.ramadoss@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added the phy_poll_cable_test flag for the lan937x phy driver.
Tested using command -  ethtool --cable-test <dev>

Signed-off-by: Arun Ramadoss <arun.ramadoss@microchip.com>
---
 drivers/net/phy/microchip_t1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
index bb4514254adc..2742d71a469f 100644
--- a/drivers/net/phy/microchip_t1.c
+++ b/drivers/net/phy/microchip_t1.c
@@ -759,6 +759,7 @@ static struct phy_driver microchip_t1_phy_driver[] = {
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_LAN937X),
 		.name		= "Microchip LAN937x T1",
+		.flags          = PHY_POLL_CABLE_TEST,
 		.features	= PHY_BASIC_T1_FEATURES,
 		.config_init	= lan87xx_config_init,
 		.suspend	= genphy_suspend,
-- 
2.33.0

