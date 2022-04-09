Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038AEC4332F
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Apr 2022 11:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240568AbiDILYn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Apr 2022 07:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbiDILYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 07:24:30 -0400
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BA62D4BC8;
        Sat,  9 Apr 2022 04:22:23 -0700 (PDT)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout2.routing.net (Postfix) with ESMTP id 28E275FDEF;
        Sat,  9 Apr 2022 11:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1649503342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1HXXCd3EGrkCXHAxs1ufwjLKFz7n60SEUlQZm+lRm7Q=;
        b=S2XxkNXnry1vD06tavxy28oInfZtq9tvEfaBooAo6Jac+xrvdbEZ5y2FM4TJJCVBMk4x2v
        AYKEGNU1WOsgirPfjWcxrz4IXaSoD9Y/HlVaTMpoXHMltPIqroTuBvoEVn0ZpXYOBMGu8P
        SFIRRTsKPu3A+JKSpgP7bXrUF6tOL80=
Received: from localhost.localdomain (fttx-pool-217.61.154.105.bambit.de [217.61.154.105])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 7FBD436065D;
        Sat,  9 Apr 2022 11:22:21 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: rockchip: Add SATA support to BPI-R2-Pro
Date:   Sat,  9 Apr 2022 13:21:36 +0200
Message-Id: <20220409112136.164481-3-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220409112136.164481-1-linux@fw-web.de>
References: <20220409112136.164481-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 54a16b4f-c6eb-44a6-a462-bdcb58611f6f
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Enable the Combphy and Sata nodes in Bananapi R2 Pro Board.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
index 879557595a64..40cf2236c0b6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
@@ -119,6 +119,11 @@ &combphy1 {
 	status = "okay";
 };
 
+&combphy2 {
+	/* used for SATA */
+	status = "okay";
+};
+
 &gmac0 {
 	assigned-clocks = <&cru SCLK_GMAC0_RX_TX>, <&cru SCLK_GMAC0>;
 	assigned-clock-parents = <&cru SCLK_GMAC0_RGMII_SPEED>, <&cru CLK_MAC0_2TOP>;
@@ -484,6 +489,10 @@ &saradc {
 	status = "okay";
 };
 
+&sata2 {
+	status = "okay";
+};
+
 &sdhci {
 	bus-width = <8>;
 	max-frequency = <200000000>;
-- 
2.25.1

