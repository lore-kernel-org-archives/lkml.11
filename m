Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51043C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 03:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239211AbiCBDIS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Mar 2022 22:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239199AbiCBDIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 22:08:14 -0500
X-Greylist: delayed 1010 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Mar 2022 19:07:31 PST
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E4B1173
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 19:07:30 -0800 (PST)
Received: from twspam01.aspeedtech.com (localhost [127.0.0.2] (may be forged))
        by twspam01.aspeedtech.com with ESMTP id 2222fLt8029337
        for <linux-kernel@vger.kernel.org>; Wed, 2 Mar 2022 10:41:21 +0800 (GMT-8)
        (envelope-from tommy_huang@aspeedtech.com)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 2222eJrJ029208;
        Wed, 2 Mar 2022 10:40:19 +0800 (GMT-8)
        (envelope-from tommy_huang@aspeedtech.com)
Received: from tommy0527-VirtualBox.aspeedtech.com (192.168.2.141) by
 TWMBX02.aspeed.com (192.168.0.24) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 2 Mar 2022 10:49:40 +0800
From:   Tommy Haung <tommy_huang@aspeedtech.com>
To:     <joel@jms.id.au>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <robh+dt@kernel.org>, <andrew@aj.id.au>,
        <linux-aspeed@lists.ozlabs.org>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [PATCH v6 2/5] ARM: dts: aspeed: ast2600-evb: Enable GFX device
Date:   Wed, 2 Mar 2022 10:49:27 +0800
Message-ID: <20220302024930.18758-3-tommy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220302024930.18758-1-tommy_huang@aspeedtech.com>
References: <20220302024930.18758-1-tommy_huang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.2.141]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 2222eJrJ029208
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joel Stanley <joel@jms.id.au>

Enable the GFX device with a framebuffer memory region.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Tommy Haung <tommy_huang@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-ast2600-evb.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
index b7eb552640cb..e223dad2abd0 100644
--- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
@@ -23,6 +23,19 @@
 		reg = <0x80000000 0x80000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		gfx_memory: framebuffer {
+			size = <0x01000000>;
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+	};
+
 	vcc_sdhci0: regulator-vcc-sdhci0 {
 		compatible = "regulator-fixed";
 		regulator-name = "SDHCI0 Vcc";
@@ -300,3 +313,8 @@
 	vqmmc-supply = <&vccq_sdhci1>;
 	clk-phase-sd-hs = <7>, <200>;
 };
+
+&gfx {
+	status = "okay";
+	memory-region = <&gfx_memory>;
+};
-- 
2.17.1

