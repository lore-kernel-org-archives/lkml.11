Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D745C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Mar 2022 20:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240535AbiCRUPE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Mar 2022 16:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbiCRUO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 16:14:57 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DD7FDE0F;
        Fri, 18 Mar 2022 13:13:37 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D862A22239;
        Fri, 18 Mar 2022 21:13:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1647634414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VsJJ80Geau/+THBkr2FUrEd5OjhGMk+B2AZvmiGFJ0I=;
        b=MF8VwurIrcsDYrJonpoOIhUMGuzcAs8nT101nVQPT6YI5VdZhgvFMcMneTlOe+URWZIGv0
        s3z9P3NQmZzCn2Tz8VAmBdy8ROnZ3J6wahWRUdlL5IICPtTmENWSNCRLU/WLZjmXzHEOiy
        86SpMqQ7m4qDqZ7aGUYpyDonGUhnra4=
From:   Michael Walle <michael@walle.cc>
To:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH net-next v3 0/3] net: mscc-miim: add integrated PHY reset support
Date:   Fri, 18 Mar 2022 21:13:21 +0100
Message-Id: <20220318201324.1647416-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MDIO driver has support to release the integrated PHYs from reset.
This was implemented for the SparX-5 for now. Now add support for the
LAN966x, too.

changes since v2:
 - fix typo in commit message
 - use microchip,lan966x instead of mscc,lan966x
 - rename mask variable to {phy_,}reset_bits
 - check return code from device_get_match_data() right after
   the call instead of checking it where it is used

changes since v1:
 - fix typo in the subject in patch 3/3

Michael Walle (3):
  dt-bindings: net: mscc-miim: add lan966x compatible
  net: mdio: mscc-miim: replace magic numbers for the bus reset
  net: mdio: mscc-miim: add lan966x internal phy reset support

 .../devicetree/bindings/net/mscc-miim.txt     |  2 +-
 drivers/net/mdio/mdio-mscc-miim.c             | 67 ++++++++++++++-----
 2 files changed, 50 insertions(+), 19 deletions(-)

-- 
2.30.2

