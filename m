Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC19EC19F2B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Aug 2022 22:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238577AbiHCW3R (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Aug 2022 18:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238883AbiHCW3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 18:29:13 -0400
Received: from mx01.ayax.eu (mx01.ayax.eu [188.137.98.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B455C372
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 15:29:12 -0700 (PDT)
Received: from [192.168.192.146] (port=42920 helo=nx64de-df6d00)
        by mx01.ayax.eu with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gszymaszek@short.pl>)
        id 1oJMrP-0008TF-9L; Thu, 04 Aug 2022 00:29:03 +0200
Date:   Thu, 4 Aug 2022 00:29:01 +0200
From:   Grzegorz Szymaszek <gszymaszek@short.pl>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Grzegorz Szymaszek <gszymaszek@short.pl>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 2/3] staging: r8188eu: make use of the DRV_NAME macro
Message-ID: <c1f348be8de5c767e72171590c6e405f6fb2bb59.1659565180.git.gszymaszek@short.pl>
Mail-Followup-To: Grzegorz Szymaszek <gszymaszek@short.pl>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
References: <6c83e05e5dbccff5630ccfed9e40bf84c889b647.1659565180.git.gszymaszek@short.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c83e05e5dbccff5630ccfed9e40bf84c889b647.1659565180.git.gszymaszek@short.pl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DRV_NAME macro is defined with the name of the r8188eu driver, but
it seems it wasn't actually used anywhere. Replace a hardcoded constant
string of the same value in the driver's struct rtw_usb_drv, field
.usbdrv.name. The affected file already includes include/drv_types.h,
where the macro is declared.

Signed-off-by: Grzegorz Szymaszek <gszymaszek@short.pl>
---
 drivers/staging/r8188eu/os_dep/usb_intf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 68869c5daeff..256b9045488e 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -54,7 +54,7 @@ struct rtw_usb_drv {
 };
 
 static struct rtw_usb_drv rtl8188e_usb_drv = {
-	.usbdrv.name = "r8188eu",
+	.usbdrv.name = DRV_NAME,
 	.usbdrv.probe = rtw_drv_init,
 	.usbdrv.disconnect = rtw_dev_remove,
 	.usbdrv.id_table = rtw_usb_id_tbl,
-- 
2.35.1
