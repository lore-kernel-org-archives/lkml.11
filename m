Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D358C433FE
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Mar 2022 00:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbiCMAXL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Mar 2022 19:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiCMAXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 19:23:09 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676F59BBAD;
        Sat, 12 Mar 2022 16:22:03 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 637FD22239;
        Sun, 13 Mar 2022 01:22:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1647130921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2ph4yF3KEwLWG0WPaDgu99RPUqOfIWeLLZBhJtHo6qQ=;
        b=q5OzNjMosgHS/8qDsIRVbSpyCTQAUwfZZ2YYV+HIsWXoMamus3qIGqc+xc9Bma60UM/YCi
        ZxfNCbOPi6xz+PDJB1MfrEEsEWNXKBcATLdygaarLv6PbNzPKTRgsEFOKlrxw4JiUSbU80
        1P0SA4a6k1Rk/5gvQedyRGVlU7HX+HY=
From:   Michael Walle <michael@walle.cc>
To:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: [PATCH net-next 0/3] net: mscc-miim: add integrated PHY reset support
Date:   Sun, 13 Mar 2022 01:21:50 +0100
Message-Id: <20220313002153.11280-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MDIO driver has support to release the integrated PHYs from reset.
This was implemented for the SparX-5 for now. Now add support for the
LAN966x, too.

Michael Walle (3):
  dt-bindings: net: mscc-miim: add lan966x compatible
  net: mdio: mscc-miim: replace magic numbers for the bus reset
  net: mdio: mscc-miim: add lan966x internal phy reset support

 .../devicetree/bindings/net/mscc-miim.txt     |  2 +-
 drivers/net/mdio/mdio-mscc-miim.c             | 59 +++++++++++++------
 2 files changed, 42 insertions(+), 19 deletions(-)

-- 
2.30.2

