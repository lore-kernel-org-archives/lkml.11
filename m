Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A429DC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 10:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiBUKdb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 05:33:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354962AbiBUKdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 05:33:10 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346AB369E5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 01:53:30 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1nM5Nb-0007AX-9t; Mon, 21 Feb 2022 10:53:15 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1nM5NZ-00FUej-MK; Mon, 21 Feb 2022 10:53:13 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v1 5/8] ARM: dts: imx6qdl-vicut1/vicutgo: The sgtl5000 uses i2s not ac97
Date:   Mon, 21 Feb 2022 10:53:09 +0100
Message-Id: <20220221095312.3692669-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220221095312.3692669-1-o.rempel@pengutronix.de>
References: <20220221095312.3692669-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin van der Gracht <robin@protonic.nl>

According to Documentation/devicetree/bindings/sound/fsl,ssi.txt
'fsl,mode' should be specified for AC97 mode only.

The 'fsl,ssi' documentation doesn't say anything about specifying
'sound-dai-cells' so we'll remove that as well.

Signed-off-by: Robin van der Gracht <robin@protonic.nl>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/imx6dl-victgo.dts   | 2 --
 arch/arm/boot/dts/imx6qdl-vicut1.dtsi | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-victgo.dts b/arch/arm/boot/dts/imx6dl-victgo.dts
index d542ddad4e32..20c7f80e5ec9 100644
--- a/arch/arm/boot/dts/imx6dl-victgo.dts
+++ b/arch/arm/boot/dts/imx6dl-victgo.dts
@@ -591,8 +591,6 @@ &pwm3 {
 };
 
 &ssi1 {
-	#sound-dai-cells = <0>;
-	fsl,mode = "ac97-slave";
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
index ec39008c0950..97ef8264947a 100644
--- a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
@@ -466,8 +466,6 @@ &pwm3 {
 };
 
 &ssi1 {
-	#sound-dai-cells = <0>;
-	fsl,mode = "ac97-slave";
 	status = "okay";
 };
 
-- 
2.30.2

