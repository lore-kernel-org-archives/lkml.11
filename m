Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFA3C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 May 2022 09:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352040AbiELJcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 May 2022 05:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352095AbiELJcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:32:31 -0400
Received: from localhost.localdomain (unknown [219.141.250.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEE462133;
        Thu, 12 May 2022 02:32:30 -0700 (PDT)
Received: from localhost.localdomain (localhost [127.0.0.1])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTPS id 24C9WC58006609
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 17:32:13 +0800
Received: (from root@localhost)
        by localhost.localdomain (8.15.2/8.15.2/Submit) id 24C9WA7q006607;
        Thu, 12 May 2022 17:32:10 +0800
Date:   Thu, 12 May 2022 17:32:10 +0800
From:   Zhou jie <zhoujie@nfschina.com>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers:Modify the return value to void
Message-ID: <20220512093210.GA6602@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers:Modify the return value to void

Signed-off-by: Zhou jie <zhoujie@nfschina.com>
---
 drivers/usb/serial/mos7720.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
index 1e12b5f30dcc..e944c32505da 100644
--- a/drivers/usb/serial/mos7720.c
+++ b/drivers/usb/serial/mos7720.c
@@ -239,13 +239,12 @@ static int read_mos_reg(struct usb_serial *serial, unsigned int serial_portnum,
 
 #ifdef CONFIG_USB_SERIAL_MOS7715_PARPORT
 
-static inline int mos7715_change_mode(struct mos7715_parport *mos_parport,
+static void mos7715_change_mode(struct mos7715_parport *mos_parport,
 				      enum mos7715_pp_modes mode)
 {
 	mos_parport->shadowECR = mode;
 	write_mos_reg(mos_parport->serial, dummy, MOS7720_ECR,
 		      mos_parport->shadowECR);
-	return 0;
 }
 
 static void destroy_mos_parport(struct kref *kref)
-- 
2.18.2

