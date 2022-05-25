Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F5BC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 May 2022 07:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243843AbiEYHLd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 May 2022 03:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244288AbiEYHLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 03:11:23 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67184388F;
        Wed, 25 May 2022 00:10:56 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 1854C100010;
        Wed, 25 May 2022 07:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653462655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bY9k2hKqsyHlaoLqP64+/s43+QLgOGGKL1kqn0fNDuQ=;
        b=WuV++LFzjWYUUnqMJX+uHOZhwZ6GkA/HQ7hNeFKIl8/qJGhdq30uurwdYlbIJvHkCQbOiL
        1jDoHMhkbBZ2stM6wlpqrAYGb3fAjFo2+xVqtH/khIRToFaNBodkFjsz2ns7Sdgj6UJ9dB
        h2KnmlSGtUWKqkUl4M5IkBx9FFPSEp+uFWGUK+lZ1Dnxp1IhwRsQWqLiNey6Cf/fsWjyqC
        1lXllMfo1vG76jmi7hDZ6ysfTquNMJRHkbqM2gPWXGgy9oZ0FAWK0xiTodNL5nFcRFoq0T
        g7yjLoZs9lOesTIG1GiNElPM5TzAzmHwFguTHRkfSztq/zgI1ZpxGfKjYeIG4Q==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/3] dt-bindings: usb: atmel: Add Microchip LAN9662 compatible string
Date:   Wed, 25 May 2022 09:10:35 +0200
Message-Id: <20220525071036.223396-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525071036.223396-1-herve.codina@bootlin.com>
References: <20220525071036.223396-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB device controller available in the Microchip LAN9662 SOC
is the same IP as the one present in the SAMA5D3 SOC.

Add the LAN9662 compatible string and set the SAMA5D3 compatible
string as a fallback for the LAN9662.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/usb/atmel-usb.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/atmel-usb.txt b/Documentation/devicetree/bindings/usb/atmel-usb.txt
index f512f0290728..12183ef47ee4 100644
--- a/Documentation/devicetree/bindings/usb/atmel-usb.txt
+++ b/Documentation/devicetree/bindings/usb/atmel-usb.txt
@@ -87,6 +87,9 @@ Required properties:
 	       "atmel,at91sam9g45-udc"
 	       "atmel,sama5d3-udc"
 	       "microchip,sam9x60-udc"
+	       "microchip,lan9662-udc"
+	       For "microchip,lan9662-udc" the fallback "atmel,sama5d3-udc"
+	       is required.
  - reg: Address and length of the register set for the device
  - interrupts: Should contain usba interrupt
  - clocks: Should reference the peripheral and host clocks
-- 
2.35.3

