Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1C6C4332F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Apr 2022 04:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348567AbiDSEwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Apr 2022 00:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348354AbiDSEva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 00:51:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB4E2FE6B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 21:48:49 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1ngfmt-0002ue-FM; Tue, 19 Apr 2022 06:48:27 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1ngfms-0047Rz-2W; Tue, 19 Apr 2022 06:48:26 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc:     David Jander <david@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>
Subject: [PATCH v2 15/17] ARM: dts: imx6dl-victgo.dts: Remove touchscreen x axis inversion
Date:   Tue, 19 Apr 2022 06:48:22 +0200
Message-Id: <20220419044824.981747-16-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419044824.981747-1-o.rempel@pengutronix.de>
References: <20220419044824.981747-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Jander <david@protonic.nl>

X axis is not inverted in hardware.

Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/imx6dl-victgo.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6dl-victgo.dts b/arch/arm/boot/dts/imx6dl-victgo.dts
index 4f6100b2ce2d..516ec915a911 100644
--- a/arch/arm/boot/dts/imx6dl-victgo.dts
+++ b/arch/arm/boot/dts/imx6dl-victgo.dts
@@ -94,7 +94,6 @@ touchscreen {
                               <&adc_ts 5>;
 		io-channel-names = "y", "z1", "z2", "x";
 		touchscreen-min-pressure = <64687>;
-		touchscreen-inverted-x;
 		touchscreen-inverted-y;
 		touchscreen-x-plate-ohms = <300>;
 		touchscreen-y-plate-ohms = <800>;
-- 
2.30.2

