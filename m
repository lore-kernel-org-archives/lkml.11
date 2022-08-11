Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B3BC25B0C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Aug 2022 07:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbiHKHEH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Aug 2022 03:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbiHKHEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:04:06 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 798E18E448;
        Thu, 11 Aug 2022 00:04:03 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 4341C1E80D32;
        Thu, 11 Aug 2022 15:02:01 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id stnoK7Bp2iSF; Thu, 11 Aug 2022 15:01:58 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zhoujie@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 736A81E80CE3;
        Thu, 11 Aug 2022 15:01:58 +0800 (CST)
From:   Zhou jie <zhoujie@nfschina.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@nfschina.com, Zhou jie <zhoujie@nfschina.com>
Subject: [PATCH] usb/serial:Modify the return value to void
Date:   Thu, 11 Aug 2022 15:03:58 +0800
Message-Id: <20220811070358.5472-1-zhoujie@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the return value to void,The return value is not used elsewhere.

Signed-off-by: Zhou jie <zhoujie@nfschina.com>
---
 drivers/usb/serial/mos7720.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
index 1e12b5f30dcc..ddb3a2d0f819 100644
--- a/drivers/usb/serial/mos7720.c
+++ b/drivers/usb/serial/mos7720.c
@@ -239,13 +239,12 @@ static int read_mos_reg(struct usb_serial *serial, unsigned int serial_portnum,
 
 #ifdef CONFIG_USB_SERIAL_MOS7715_PARPORT
 
-static inline int mos7715_change_mode(struct mos7715_parport *mos_parport,
+static inline void mos7715_change_mode(struct mos7715_parport *mos_parport,
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

