Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622B6C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jun 2022 09:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbiFHJnv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jun 2022 05:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbiFHJnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:43:12 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DAA1BD8DE;
        Wed,  8 Jun 2022 02:10:11 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B929A2000D;
        Wed,  8 Jun 2022 09:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654679409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VSNv+KHVL/pW3nUafAWMe5ggPpaZsURODRBWv7Q61Ac=;
        b=Kp1uO3yaY0KVRJvnD7BVKqli+YBb1czfyAptteTz9zRp4hDzTpBTZo7UxskXSA7GM2Cik2
        rRspRUPSLRcArB6F/p2Y8GrMQ/XYdoRZw//RdDLQbVfyWNYk+h3dbE9hH+4wmRkB9xWuN5
        gu4fMU/ZqjuF4lkfzo6DLYrYWVsaSoCw6Sy7d2f//tswrRltE9Av2waoxU61+TV1SsC4OA
        ltDtwk51kHAT3O9map2hDehGOScv0usVv3hrWv69X10VycKhhy1qlaFWtI3NE5OnIVYzwU
        2tc+JrSsAc63fOzxMLOaA6b6MxhqDm2b4pBlJxa37GsYKewr89T4CupYPGc96w==
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>
Subject: [PATCH] ARM: dts: r9a06g032-rzn1d400-db: enable rtc0
Date:   Wed,  8 Jun 2022 11:08:50 +0200
Message-Id: <20220608090850.92735-1-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RZ/N1D-DB board does have a battery to power the RTC. Enable the
RTC device on this board.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts b/arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts
index 3f8f3ce87e12..c736d398325a 100644
--- a/arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts
+++ b/arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts
@@ -31,3 +31,7 @@ &wdt0 {
 	timeout-sec = <60>;
 	status = "okay";
 };
+
+&rtc0 {
+	status = "okay";
+};
-- 
2.36.1

