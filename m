Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6515BC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jul 2022 19:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240039AbiGNTUC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jul 2022 15:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239940AbiGNTUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 15:20:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5572C647;
        Thu, 14 Jul 2022 12:19:59 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2EAD91F986;
        Thu, 14 Jul 2022 19:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657826398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4IXIt9i4IIWMBr8dsDU+TZSGcKwpUFNYiCeI9reK8Fo=;
        b=ogcuG11BaEb+JOU64/DLbpgROHc29PvOwMkMSFEH8hy5UIsK9BC4cqqutMZKAfXGQ2z4LP
        qSEsQv9CuNeUmZ7y5YwBVvGA4WuJJUKfCsz4zm+SBeD0aNTKYbw5XJp6IPBjrWawJMqKEX
        QIPycGOXqiz9VCZE45SgE0f1ikUqMys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657826398;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4IXIt9i4IIWMBr8dsDU+TZSGcKwpUFNYiCeI9reK8Fo=;
        b=gbsPuTgJhHTRxWIuoej/HugirZJCurSMj40g+kYnzuvVo+0NexrRxKqgASXl/wBCVR5oJF
        be/0CDRYgEv7enDQ==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id CE1032C142;
        Thu, 14 Jul 2022 19:19:57 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-sunxi@lists.linux.dev
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH resend 2/2] ARM: dts: sunxi: Enable optional SPI flash on Orange Pi Zero board
Date:   Thu, 14 Jul 2022 21:19:48 +0200
Message-Id: <62c4e6be12771f3120f67a328a51ac360dc468d2.1657826188.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <701967b0c418db333c66b48d225df60aa9d03ead.1657826188.git.msuchanek@suse.de>
References: <701967b0c418db333c66b48d225df60aa9d03ead.1657826188.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flash is present on all new boards and users went out of their way
to add it on the old ones.

Enabling it makes a more reasonable default.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
Link: https://lore.kernel.org/all/20200929083025.2089-1-msuchanek@suse.de/
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
index 3706216ffb40..4f782b1bdf27 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
@@ -163,8 +163,8 @@ &ohci1 {
 };
 
 &spi0 {
-	/* Disable SPI NOR by default: it optional on Orange Pi Zero boards */
-	status = "disabled";
+	/* Enable optional SPI NOR by default */
+	status = "okay";
 
 	flash@0 {
 		#address-cells = <1>;
-- 
2.35.3

