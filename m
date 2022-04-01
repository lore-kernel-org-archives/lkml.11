Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9038BC433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Apr 2022 21:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353122AbiDAWAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Apr 2022 18:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236765AbiDAWAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 18:00:50 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4A41C1EF2;
        Fri,  1 Apr 2022 14:58:58 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 8221A22175;
        Fri,  1 Apr 2022 23:58:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1648850337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wKZJGtGgAkr14SlSkx42047+K1FvfMSoIAkdgAKKm3Y=;
        b=pZBoYRuZy785zUJD8ax4ptSx/TdH0UQImquUFJ73NCr5IaNX64fdw9kE9uN7ExFpfo1TlQ
        Ejq+4mcGGEREx/4d2b3OvqjOmJUU67/lixG7vfnMAhdBVay5OYjHCq0qp5CnzSmAFOx/Na
        gwjdK6nWZGz9W+28QLdR0SwfdODiWLc=
From:   Michael Walle <michael@walle.cc>
To:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: [PATCH RFC net-next v2 0/3] net: phy: mscc-miim: add MDIO bus frequency support
Date:   Fri,  1 Apr 2022 23:58:31 +0200
Message-Id: <20220401215834.3757692-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce MDIO bus frequency support. This way the board can have a
faster (or maybe slower) bus frequency than the hardware default.

changes since v1:
 - fail probe if clock-frequency is set, but not clock is given
 - rename clk_freq to bus_freq
 - add maxItems to interrupts property
 - put compatible and reg first in the example

Michael Walle (3):
  dt-bindings: net: convert mscc-miim to YAML format
  dt-bindings: net: mscc-miim: add clock and clock-frequency
  net: phy: mscc-miim: add support to set MDIO bus frequency

 .../devicetree/bindings/net/mscc,miim.yaml    | 61 +++++++++++++++++++
 .../devicetree/bindings/net/mscc-miim.txt     | 26 --------
 drivers/net/mdio/mdio-mscc-miim.c             | 58 +++++++++++++++++-
 3 files changed, 117 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/mscc,miim.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/mscc-miim.txt

-- 
2.30.2

