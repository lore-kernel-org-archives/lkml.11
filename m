Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040B0C00140
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Aug 2022 02:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbiHKCzm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Aug 2022 22:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbiHKCzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 22:55:39 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F4057221;
        Wed, 10 Aug 2022 19:55:37 -0700 (PDT)
Received: from localhost.localdomain ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 27B2sjkh021700-27B2sjkk021700
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 11 Aug 2022 10:54:50 +0800
From:   Dongliang Mu <dzm91@hust.edu.cn>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] USB: trancevibrator: remove redundant space
Date:   Thu, 11 Aug 2022 10:53:41 +0800
Message-Id: <20220811025346.113199-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dongliang Mu <mudongliangabcd@gmail.com>

remove a redundant space after usb_get_intfdata

Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 drivers/usb/misc/trancevibrator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/misc/trancevibrator.c b/drivers/usb/misc/trancevibrator.c
index 26baba3ab7d7..55cb63652eda 100644
--- a/drivers/usb/misc/trancevibrator.c
+++ b/drivers/usb/misc/trancevibrator.c
@@ -106,7 +106,7 @@ static void tv_disconnect(struct usb_interface *interface)
 {
 	struct trancevibrator *dev;
 
-	dev = usb_get_intfdata (interface);
+	dev = usb_get_intfdata(interface);
 	usb_set_intfdata(interface, NULL);
 	usb_put_dev(dev->udev);
 	kfree(dev);
-- 
2.35.1

