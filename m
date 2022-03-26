Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79062C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Mar 2022 00:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiCZAFC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 20:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiCZAEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 20:04:39 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093D0F47;
        Fri, 25 Mar 2022 17:03:00 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 11A1F22247;
        Sat, 26 Mar 2022 01:02:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1648252978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Sra84DTjE201brWQ8eofT4DMokoDMBWu7l5euKhvgwg=;
        b=IF4R6S91gD5IAM8wjUjG2NmHqv6sF16OxPyhxkdCwRdTsHewb3N9sRm4OsrLqu9RYrDFyG
        u+Jto63+MEOtA25hyCWhpgC1zFcBe2ZO2l6bFPXP+DZ9Yw/rNzEbSYmFEmsppLhaDlFVf5
        dEbei53s7npmWGXc/5iXIjuwqWdEZAc=
From:   Michael Walle <michael@walle.cc>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: [PATCH net] net: lan966x: fix kernel oops on ioctl when I/F is down
Date:   Sat, 26 Mar 2022 01:02:51 +0100
Message-Id: <20220326000251.2687897-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A SIOCGMIIPHY ioctl will cause a kernel oops when the interface is down.
Fix it by checking the state and if it's no running, return an error.

Fixes: 735fec995b21 ("net: lan966x: Implement SIOCSHWTSTAMP and SIOCGHWTSTAMP")
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index ec42e526f6fb..0adf49d19142 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -399,6 +399,9 @@ static int lan966x_port_ioctl(struct net_device *dev, struct ifreq *ifr,
 {
 	struct lan966x_port *port = netdev_priv(dev);
 
+	if (!netif_running(dev))
+		return -EINVAL;
+
 	if (!phy_has_hwtstamp(dev->phydev) && port->lan966x->ptp) {
 		switch (cmd) {
 		case SIOCSHWTSTAMP:
-- 
2.30.2

