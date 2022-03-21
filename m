Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A95DC4332F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 09:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346177AbiCUKAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 06:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346152AbiCUKAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 06:00:12 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3F337BF8;
        Mon, 21 Mar 2022 02:58:40 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 22L9jvj1079097;
        Mon, 21 Mar 2022 17:45:57 +0800 (GMT-8)
        (envelope-from dylan_hung@aspeedtech.com)
Received: from DylanHung-PC.aspeed.com (192.168.2.216) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 21 Mar
 2022 17:56:23 +0800
From:   Dylan Hung <dylan_hung@aspeedtech.com>
To:     <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <p.zabel@pengutronix.de>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [PATCH v2 0/3]  Add reset deassertion for Aspeed MDIO
Date:   Mon, 21 Mar 2022 17:56:45 +0800
Message-ID: <20220321095648.4760-1-dylan_hung@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.216]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 22L9jvj1079097
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing reset deassertion for Aspeed MDIO. There are 4 MDIOs embedded
in Aspeed AST2600 and share one reset control bit SCU50[3].

Dylan Hung (3):
  dt-bindings: net: add reset property for aspeed, ast2600-mdio binding
  net: mdio: add reset control for Aspeed MDIO
  ARM: dts: aspeed: add reset properties into MDIO nodes

 .../bindings/net/aspeed,ast2600-mdio.yaml         |  4 ++++
 arch/arm/boot/dts/aspeed-g6.dtsi                  |  4 ++++
 drivers/net/mdio/mdio-aspeed.c                    | 15 ++++++++++++++-
 3 files changed, 22 insertions(+), 1 deletion(-)

-- 
2.25.1

