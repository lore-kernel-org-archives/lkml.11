Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D8AECAAD2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Aug 2022 15:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbiH0Pdt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Aug 2022 11:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbiH0Pdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 11:33:47 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C2F57240;
        Sat, 27 Aug 2022 08:33:44 -0700 (PDT)
X-QQ-mid: bizesmtp73t1661614400txkl1ykv
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 27 Aug 2022 23:33:14 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: 5mtg6EGDOv68Ts38tfpKEmESutiBsyd4V6NWxAv4Ot7c+82wyq8RfC8uV6GwF
        fFwISSsMfD02XndSGck0PsJjsO3ARf0bFyWFkY+DUjaKR0QGl1A16J/6OI+9+08PPXrZQ+a
        d7ysB5dnOuo71JfQYAozezPScViKlTusyl/t0oIlTWLS+ZwPYsbpUJzCyjJv0/Ia1icoI2l
        tLJVk1n9cMiOjzamhNp+Rzeo3k6QgoTv+3fUwtVrjJt71tjw19KRFrcUXnyZbrVMl93O9oz
        pEzMVAumJAj+hKn4PWUI3HQ4amOKoOO/pHqgccviis45faSs1hZ8Q/opoNBiLyW3ZJJjmUO
        1cs3FWMmAqi9aYJf7KXoqBaWQH/4Y2jBhUUH0u9p5gAbGJkvus/ckZj8U0b4w==
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] usb: gadget: at91_udc: Fix comments typo
Date:   Sat, 27 Aug 2022 11:33:13 -0400
Message-Id: <20220827153313.5754-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the rebundant word "also" in comments.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/usb/gadget/udc/at91_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/at91_udc.c b/drivers/usb/gadget/udc/at91_udc.c
index 728987280373..c80d0902bb30 100644
--- a/drivers/usb/gadget/udc/at91_udc.c
+++ b/drivers/usb/gadget/udc/at91_udc.c
@@ -994,7 +994,7 @@ static const struct usb_gadget_ops at91_udc_ops = {
 	.udc_stop		= at91_stop,
 
 	/*
-	 * VBUS-powered devices may also also want to support bigger
+	 * VBUS-powered devices may also want to support bigger
 	 * power budgets after an appropriate SET_CONFIGURATION.
 	 */
 	/* .vbus_power		= at91_vbus_power, */
-- 
2.35.1

