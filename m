Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D0DC64991
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Sep 2022 17:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbiIARAZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Sep 2022 13:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbiIARAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:00:23 -0400
Received: from smtprelay08.ispgateway.de (smtprelay08.ispgateway.de [134.119.228.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF553D5A4;
        Thu,  1 Sep 2022 10:00:19 -0700 (PDT)
Received: from [92.206.161.29] (helo=note-book.lan)
        by smtprelay08.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <git@apitzsch.eu>)
        id 1oTnYA-0006Tp-Ji; Thu, 01 Sep 2022 19:00:18 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>
To:     Aaron Ma <aaron.ma@canonical.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>
Subject: [PATCH net-next] r8152: Add MAC passthrough support for Lenovo Travel Hub
Date:   Thu,  1 Sep 2022 19:00:13 +0200
Message-Id: <20220901170013.7975-1-git@apitzsch.eu>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Lenovo USB-C Travel Hub supports MAC passthrough.

Signed-off-by: André Apitzsch <git@apitzsch.eu>
---
 drivers/net/usb/r8152.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index dca6f71c4bfe..a51d8ded60f3 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -770,6 +770,7 @@ enum rtl8152_flags {
 	RX_EPROTO,
 };
 
+#define DEVICE_ID_LENOVO_USB_C_TRAVEL_HUB		0x721e
 #define DEVICE_ID_THINKPAD_ONELINK_PLUS_DOCK		0x3054
 #define DEVICE_ID_THINKPAD_THUNDERBOLT3_DOCK_GEN2	0x3082
 #define DEVICE_ID_THINKPAD_USB_C_DONGLE			0x720c
@@ -9586,6 +9587,7 @@ static bool rtl8152_supports_lenovo_macpassthru(struct usb_device *udev)
 
 	if (vendor_id == VENDOR_ID_LENOVO) {
 		switch (product_id) {
+		case DEVICE_ID_LENOVO_USB_C_TRAVEL_HUB:
 		case DEVICE_ID_THINKPAD_ONELINK_PLUS_DOCK:
 		case DEVICE_ID_THINKPAD_THUNDERBOLT3_DOCK_GEN2:
 		case DEVICE_ID_THINKPAD_USB_C_DOCK_GEN2:
-- 
2.37.3

