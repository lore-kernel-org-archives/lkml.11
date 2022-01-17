Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B356CC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jan 2022 23:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243754AbiAQXHl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jan 2022 18:07:41 -0500
Received: from mail.hugovil.com ([162.243.120.170]:47662 "EHLO
        mail.hugovil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiAQXHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 18:07:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date
        :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=Du9v/Z5FVhfV95sAcpZJzpdwfPesAOEi6fhcH58virk=; b=M
        LSNCsLBwO5G1XoMdlUll2Zhj+UPL336TK2xTw7fxedeNkXTCU27eE+MlfqhBFvU5IwY4Dx4z44SiS
        c43xRKVnGjXTv4FRFJyiRVi4BVyIViUhYgWYSUrGo8BRJAfXLDycnvzcz4fC6V/nw/mnfZ0pEvzf2
        f91AEvNOIvdzvSnk=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:54816 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1n9b5x-0005oE-TK; Mon, 17 Jan 2022 18:07:26 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     hugo@hugovil.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 17 Jan 2022 18:06:39 -0500
Message-Id: <20220117230639.1257549-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: [PATCH] arm64: dts: imx8mp-evk: add PCA6416 interrupt controller mode
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Add interrupt controller mode for the pca6416 on i.MX8MP EVK board's.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 66437b659f3a..00e1e1342162 100755
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -526,6 +526,12 @@ pca6416: gpio@20 {
 		reg = <0x20>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pca6416_int>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
 	};
 
 	codec: wm8960@1a {
@@ -1209,6 +1215,12 @@ pinctrl_csi_mclk: csi_mclk_grp {
 			MX8MP_IOMUXC_GPIO1_IO15__CCM_CLKO2	0x59
 		>;
 	};
+
+	pinctrl_pca6416_int: pca6416_int_grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12	0x146 /* Input pull-up. */
+		>;
+	};
 };
 
 &vpu_g1 {
-- 
2.30.2

