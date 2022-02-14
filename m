Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5623C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 09:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243054AbiBNJ2f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 04:28:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242991AbiBNJ22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:28:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B9460D85;
        Mon, 14 Feb 2022 01:28:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F3B160DFD;
        Mon, 14 Feb 2022 09:28:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F045EC340E9;
        Mon, 14 Feb 2022 09:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644830899;
        bh=PxAmF0SKGpeqELjz1UDvowOi6GjdGdS2hFerTKhDzi8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WbX5AZm1S0qj/5g9m+uuRMAj/AQ/qFkMoXbttXm8FPIpw+fVNw4P8UbYusbnLVoLO
         6pQ/KQubJg4A3EpwaF2EOGGxfRf/9HbOe9brGciURFGTT+eGG35y2wQkdKMrsJjfcS
         Aw0u5D3VQKSciGT14GTOnR7B2LRIxs1jemjAvwKc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 16/34] ARM: dts: imx6qdl-udoo: Properly describe the SD card detect
Date:   Mon, 14 Feb 2022 10:25:42 +0100
Message-Id: <20220214092446.470999405@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220214092445.946718557@linuxfoundation.org>
References: <20220214092445.946718557@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

[ Upstream commit 993d66140f8d1c1853a3b58b77b43b681eb64dee ]

GPIO7_IO00 is used as SD card detect.

Properly describe this in the devicetree.

Fixes: 40cdaa542cf0 ("ARM: dts: imx6q-udoo: Add initial board support")
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx6qdl-udoo.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-udoo.dtsi b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
index fc4ae2e423bd7..b0fdcae66ead3 100644
--- a/arch/arm/boot/dts/imx6qdl-udoo.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
@@ -9,6 +9,8 @@
  *
  */
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	aliases {
 		backlight = &backlight;
@@ -201,6 +203,7 @@ MX6QDL_PAD_SD3_DAT0__SD3_DATA0		0x17059
 				MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x17059
 				MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x17059
 				MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x17059
+				MX6QDL_PAD_SD3_DAT5__GPIO7_IO00		0x1b0b0
 			>;
 		};
 
@@ -267,7 +270,7 @@ &usbh1 {
 &usdhc3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc3>;
-	non-removable;
+	cd-gpios = <&gpio7 0 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
-- 
2.34.1



