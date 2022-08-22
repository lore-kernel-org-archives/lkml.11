Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8323DC28D13
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Aug 2022 11:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbiHVL5w (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Aug 2022 07:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbiHVL5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 07:57:50 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1051CB3F;
        Mon, 22 Aug 2022 04:57:48 -0700 (PDT)
X-QQ-mid: bizesmtp63t1661169441tiskbbm1
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 22 Aug 2022 19:57:20 +0800 (CST)
X-QQ-SSF: 01000000002000C0D000B00A0000000
X-QQ-FEAT: DRnj/z+SqaeRMdvzCF5hP1VCgxalyLxoT6tk51nbzQFtwFwK+Bbd25Y6AQxoz
        ofCOPGCc42PERnEORGG5s08+rMCeiLDfxl7T0VwKN2GSe0ltM5cKZW92nazVIu3h1Se5RI1
        mfsMBER1WmALZQlqaSgv+gwg8u2qpHMrz7wCSseLaoWDkuLUYV30ia/Sd1/Joe7Id4W5VVy
        70PQPcX8a22vcFF+veJ/Lof6GnMjpKmectKPVhRF7mKFxxrGfAAQKclGhjpiHUMOXa9U/4Y
        voTZYoZy+jftLpMFxqk6CTaquchekW+7ayc/F6rmmoc7UI4fonwtwPQQpqD2XUnsLN9lq0d
        ryMOr3lt7AlLKyUDsjkkVygHFb44EoLgtvR1cqjpZMmX+MGod3hfdBCdqcJww==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     balbi@kernel.org, daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr
Cc:     linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] gadget/udc: fix repeated words in comments
Date:   Mon, 22 Aug 2022 19:57:07 +0800
Message-Id: <20220822115707.11425-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'tell'.
 Delete the redundant word 'also'.
 Delete the redundant word 'with'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/usb/gadget/udc/at91_udc.c   | 2 +-
 drivers/usb/gadget/udc/core.c       | 2 +-
 drivers/usb/gadget/udc/pxa25x_udc.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

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
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index b5b42f7a299b..8dd8fbd44d65 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -900,7 +900,7 @@ EXPORT_SYMBOL_GPL(usb_gadget_unmap_request);
 
 /**
  * usb_gadget_giveback_request - give the request back to the gadget layer
- * @ep: the endpoint to be used with with the request
+ * @ep: the endpoint to be used with the request
  * @req: the request being given back
  *
  * This is called by device controller drivers in order to return the
diff --git a/drivers/usb/gadget/udc/pxa25x_udc.c b/drivers/usb/gadget/udc/pxa25x_udc.c
index c593fc383481..176e2b157021 100644
--- a/drivers/usb/gadget/udc/pxa25x_udc.c
+++ b/drivers/usb/gadget/udc/pxa25x_udc.c
@@ -1737,7 +1737,7 @@ static void handle_ep0 (struct pxa25x_udc *dev)
 				/* hardware automagic preventing STALL... */
 				if (dev->req_config) {
 					/* hardware sometimes neglects to tell
-					 * tell us about config change events,
+					 * us about config change events,
 					 * so later ones may fail...
 					 */
 					WARNING("config change %02x fail %d?\n",
-- 
2.36.1

