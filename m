Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86B2C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 18:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344001AbiCWSgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 14:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240154AbiCWSgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 14:36:04 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D48E62A20;
        Wed, 23 Mar 2022 11:34:34 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C34FF223F7;
        Wed, 23 Mar 2022 19:34:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1648060470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ss8GFR5rljClvU8CctXDwTGOGTKBTAeyK5+ukBPrIgk=;
        b=DVHyGE/jkdERvSTtUFF1a1JtXRfnREW6qcbLacNXBm2wWJYptvlN7brbpdEVGevGST6exd
        XwI2IGK3xrPrGhNTLHA6y3W1BM16j7iq3nBeoaNNVJQh4jnrc5CVd9nrS8ErZCRia0OU4Z
        UPhhrCckKrsqctgEVLw5FvYtQaKWJ3Q=
From:   Michael Walle <michael@walle.cc>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Xu Liang <lxu@maxlinear.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH RFC net-next 5/5] net: phylink: handle the new is_c45_over_c22 property
Date:   Wed, 23 Mar 2022 19:34:19 +0100
Message-Id: <20220323183419.2278676-6-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220323183419.2278676-1-michael@walle.cc>
References: <20220323183419.2278676-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Phylink treats C45 PHYs in a special way and assumes they can switch
their SerDes lanes between modes. This check is done by looking at the
is_c45 property. But there are PHYs, namely the GPY215, which are C45
PHYs but behind a C22 bus. Thus while the PHY is a C45 one, the is_c45
property is not set because it uses indirect MMD access via the C22
registers. Therefore, add the is_c45_over_c22  property to the check,
which indicates this sort of PHY handling.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/net/phy/phylink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 06943889d747..633cccfbd5f4 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1369,7 +1369,7 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 	 * speeds. We really need to know which interface modes the PHY and
 	 * MAC supports to properly work out which linkmodes can be supported.
 	 */
-	if (phy->is_c45 &&
+	if ((phy->is_c45 || phy->is_c45_over_c22) &&
 	    interface != PHY_INTERFACE_MODE_RXAUI &&
 	    interface != PHY_INTERFACE_MODE_XAUI &&
 	    interface != PHY_INTERFACE_MODE_USXGMII)
-- 
2.30.2

