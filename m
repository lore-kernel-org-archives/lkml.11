Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE18C35296
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 16:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238137AbiCIQun (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 11:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239586AbiCIQdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:33:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D581AD956;
        Wed,  9 Mar 2022 08:28:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42CADB82212;
        Wed,  9 Mar 2022 16:27:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0257EC340F5;
        Wed,  9 Mar 2022 16:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646843248;
        bh=kfxM39evKeZ0QqD/rr54pHLg7pCY1s/mZnHlo1A++H8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s1/1muW/guoYlmTZk0koyWfJIMg1hjRTuBTu7n4IMAraJs+zOoNiTpa8Lc60Guhw6
         g3n44cWucxEaRaTT7+1LpbKimmqWGun8I9m1fUP5iMt/Wu/2fBoBiL/6Sl2xzpaH0S
         muMSicAJ3hGteSwNMpH+f6nd+6d5BCHBlnFhSsJEcuZ70Ovbz0xGSw/XqRrOhra5vB
         cXwjSOUhuOVqn3mEPYqVh6OMqwEgzEYGlmyxyYyn9aT1bgDziWvk8YaBLSn8QzkU81
         aCpwZtgHCoiteurFyhc8HvUK1JBzuDeqmg79jcA9Re+7TgM/GfSP8vDUo2vtT6smcy
         zZTiR6KyuHnPg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 02/11] ARM: dts: rockchip: fix a typo on rk3288 crypto-controller
Date:   Wed,  9 Mar 2022 11:27:07 -0500
Message-Id: <20220309162716.137399-2-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220309162716.137399-1-sashal@kernel.org>
References: <20220309162716.137399-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corentin Labbe <clabbe@baylibre.com>

[ Upstream commit 3916c3619599a3970d3e6f98fb430b7c46266ada ]

crypto-controller had a typo, fix it.
In the same time, rename it to just crypto

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Link: https://lore.kernel.org/r/20220209120355.1985707-1-clabbe@baylibre.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/rk3288.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 7b727d738b69..4702aa980ef8 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -918,7 +918,7 @@ i2s: i2s@ff890000 {
 		status = "disabled";
 	};
 
-	crypto: cypto-controller@ff8a0000 {
+	crypto: crypto@ff8a0000 {
 		compatible = "rockchip,rk3288-crypto";
 		reg = <0xff8a0000 0x4000>;
 		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.34.1

