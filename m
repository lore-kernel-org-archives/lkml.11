Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE15CCA47F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 13:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbiGENtX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 09:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbiGENsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:48:47 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF80820BF0;
        Tue,  5 Jul 2022 06:19:59 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 1F7FC22248;
        Tue,  5 Jul 2022 15:19:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1657027198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d5x801p6sG2uKyVUwKP2eKz1C2UwPgcQQGtQfJ09AyI=;
        b=QgdokTNmJUacparO9BWuFl7pCzSzRClcu/SalHSXhb/rhnhuuzQdjU5p4jubxbNA0g4Dje
        iElAaac1iJmworsIYoOm7a+OeVyontmvafRFpHiC80Zr4w7eKSP8fm6P+JrhocKxIDLLKe
        fCm9HX1xBTKu1hJf+R8zmst8Y3I7tFo=
From:   Michael Walle <michael@walle.cc>
To:     Cristian Birsan <cristian.birsan@microchip.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: [PATCH 2/2] usb: gadget: udc: atmel: convert to platform driver
Date:   Tue,  5 Jul 2022 15:19:51 +0200
Message-Id: <20220705131951.1388968-2-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220705131951.1388968-1-michael@walle.cc>
References: <20220705131951.1388968-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver won't probe on a LAN9668 because the pinctrl driver isn't
ready yet. Probe deferral is not supported because the init section
is already discarded. With fw_devlink enabled, the probe won't even
be called. Convert the driver to a proper platform driver.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 48355e0cee76..53ca38c4b3ec 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -2060,7 +2060,7 @@ static const struct usba_udc_errata at91sam9g45_errata = {
 	.pulse_bias = at91sam9g45_pulse_bias,
 };
 
-static const struct usba_ep_config ep_config_sam9[] __initconst = {
+static const struct usba_ep_config ep_config_sam9[] = {
 	{ .nr_banks = 1 },				/* ep 0 */
 	{ .nr_banks = 2, .can_dma = 1, .can_isoc = 1 },	/* ep 1 */
 	{ .nr_banks = 2, .can_dma = 1, .can_isoc = 1 },	/* ep 2 */
@@ -2070,7 +2070,7 @@ static const struct usba_ep_config ep_config_sam9[] __initconst = {
 	{ .nr_banks = 3, .can_dma = 1, .can_isoc = 1 },	/* ep 6 */
 };
 
-static const struct usba_ep_config ep_config_sama5[] __initconst = {
+static const struct usba_ep_config ep_config_sama5[] = {
 	{ .nr_banks = 1 },				/* ep 0 */
 	{ .nr_banks = 3, .can_dma = 1, .can_isoc = 1 },	/* ep 1 */
 	{ .nr_banks = 3, .can_dma = 1, .can_isoc = 1 },	/* ep 2 */
@@ -2449,6 +2449,7 @@ static int usba_udc_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(usba_udc_pm_ops, usba_udc_suspend, usba_udc_resume);
 
 static struct platform_driver udc_driver = {
+	.probe		= usba_udc_probe,
 	.remove		= usba_udc_remove,
 	.driver		= {
 		.name		= "atmel_usba_udc",
@@ -2456,8 +2457,7 @@ static struct platform_driver udc_driver = {
 		.of_match_table	= atmel_udc_dt_ids,
 	},
 };
-
-module_platform_driver_probe(udc_driver, usba_udc_probe);
+module_platform_driver(udc_driver);
 
 MODULE_DESCRIPTION("Atmel USBA UDC driver");
 MODULE_AUTHOR("Haavard Skinnemoen (Atmel)");
-- 
2.30.2

