Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C77C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 May 2022 23:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345255AbiEYXNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 May 2022 19:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbiEYXNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 19:13:00 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1351CA5ABE;
        Wed, 25 May 2022 16:12:57 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2C8DF22247;
        Thu, 26 May 2022 01:12:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1653520370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PgHgErv4cia5Q5pV59X+EoYsMXAGMf+sFfFpeHS3CJo=;
        b=mQPzRGsnwoimzjnIY+beZew7XlmRS2VzkaTHBxydn78Y/INKEmQ/9IMbBm6YqlSdzd12dq
        Rn2XffyW/ibR0ktlaTMQDeBA/nuhuhdgRjns8sli9bSUOYVX0VOuSDF5YlQFJSyBIWYwMD
        AEbzHCIOVfOP1TwJ6y3xRvUx3paFZuw=
From:   Michael Walle <michael@walle.cc>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        UNGLinuxDriver@microchip.com, Michael Walle <michael@walle.cc>
Subject: [PATCH net] net: lan966x: check devm_of_phy_get() for -EDEFER_PROBE
Date:   Thu, 26 May 2022 01:12:39 +0200
Message-Id: <20220525231239.1307298-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment, if devm_of_phy_get() returns an error the serdes
simply isn't set. While it is bad to ignore an error in general, there
is a particular bug that network isn't working if the serdes driver is
compiled as a module. In that case, devm_of_phy_get() returns
-EDEFER_PROBE and the error is silently ignored.

The serdes is optional, it is not there if the port is using RGMII, in
which case devm_of_phy_get() returns -ENODEV. Rearrange the error
handling so that -ENODEV will be handled but other error codes will
abort the probing.

Fixes: d28d6d2e37d1 ("net: lan966x: add port module support")
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 6ad68b422129..5784c4161e5e 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -1120,8 +1120,13 @@ static int lan966x_probe(struct platform_device *pdev)
 		lan966x->ports[p]->fwnode = fwnode_handle_get(portnp);
 
 		serdes = devm_of_phy_get(lan966x->dev, to_of_node(portnp), NULL);
-		if (!IS_ERR(serdes))
-			lan966x->ports[p]->serdes = serdes;
+		if (PTR_ERR(serdes) == -ENODEV)
+			serdes = NULL;
+		if (IS_ERR(serdes)) {
+			err = PTR_ERR(serdes);
+			goto cleanup_ports;
+		}
+		lan966x->ports[p]->serdes = serdes;
 
 		lan966x_port_init(lan966x->ports[p]);
 	}
-- 
2.30.2

