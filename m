Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9964CC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 May 2022 14:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238432AbiEBOzU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 May 2022 10:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238288AbiEBOzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 10:55:16 -0400
X-Greylist: delayed 684 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 02 May 2022 07:51:43 PDT
Received: from mail-m17638.qiye.163.com (mail-m17638.qiye.163.com [59.111.176.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B089364CF;
        Mon,  2 May 2022 07:51:43 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPV6:2001:250:6801:5501:163d:f2ff:fecb:5632])
        by mail-m17638.qiye.163.com (Hmail) with ESMTPA id E4B941C071B;
        Mon,  2 May 2022 22:40:16 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH] arm64: dts: allwinner: define USB3 Ethernet on NanoPi R1S H5
Date:   Mon,  2 May 2022 22:40:09 +0800
Message-Id: <20220502144009.44575-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRpMTUtWHR5IHkkZSBodHk
        lDVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Oi46PBw5Kj0*TRU3NTcUEUwC
        FQgKCxhVSlVKTU5KTktJT0pMTktPVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlL
        S0pBSU5LQU1DS0pBTk5LSkFKTUgfQR1JHR1BHR4YGUFOTUhJWVdZCAFZQUlKQkM3Bg++
X-HM-Tid: 0a8085370501d993kuwse4b941c071b
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NanoPi R1S H5 has a Realtek RTL8153B USB 3.0 Ethernet chip
connected to the USB 2.0 port of the Allwinner H5 SoC.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts
index 55b369534a08..dd655a491549 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts
@@ -21,7 +21,8 @@ / {
 
 	aliases {
 		ethernet0 = &emac;
-		ethernet1 = &rtl8189etv;
+		ethernet1 = &rtl8153;
+		ethernet2 = &rtl8189etv;
 		serial0 = &uart0;
 	};
 
@@ -116,6 +117,11 @@ &cpu0 {
 
 &ehci1 {
 	status = "okay";
+
+	rtl8153: device@1 {
+		compatible = "usbbda,8153";
+		reg = <1>;
+	};
 };
 
 &ehci2 {
-- 
2.25.1

