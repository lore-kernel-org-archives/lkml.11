Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386AAC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 20 May 2022 15:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350800AbiETPXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 May 2022 11:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350782AbiETPXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:23:48 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DBD13B8E7;
        Fri, 20 May 2022 08:23:45 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 99CAA4000B;
        Fri, 20 May 2022 15:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653060224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kQjkmQCgQIgQ279z8QJsaWMHPcPOT+vi5D3qiH12I0o=;
        b=nhRJdWuYDgDXBxPwBcDUoYGXfXwutp7Xlh19Hv5bSawYJGYNrPdQjiw6j9V21dCmJN5911
        povK4Rnnn/1iB4EromRqCbZ9Qm1EqUJz85FUu83Ath9GLefnMzAHh2G0ZlZQ/4QKLA207y
        9HuuFCKDIX93OcosIdFMQ1Be1ANnmW19v2tSS0uM/vm/sLT72kwhGFxxuEMWb81eF+Iyv5
        sdIAvMpfLxFPazk5m5bA1zXDchmV0DARrUk3hy4osZT1JgvvzTUQiLwPh9sVoEZyCzraEk
        Ci4xaNB8VqV5MMJ1G7vgdtrzf5YQEyrCOP39rxdPhpVoO8nf9/SvAIcook8OAg==
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
        Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 2/3] dt-bindings: usb: atmel: Add Microchip LAN9662 compatible string
Date:   Fri, 20 May 2022 17:23:34 +0200
Message-Id: <20220520152335.352537-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220520152335.352537-1-herve.codina@bootlin.com>
References: <20220520152335.352537-1-herve.codina@bootlin.com>
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
2.35.1

