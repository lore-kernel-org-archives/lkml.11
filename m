Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A0BC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jun 2022 01:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbiFWBI1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jun 2022 21:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiFWBIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 21:08:23 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864E82FE41;
        Wed, 22 Jun 2022 18:08:21 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VH95W38_1655946498;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VH95W38_1655946498)
          by smtp.aliyun-inc.com;
          Thu, 23 Jun 2022 09:08:18 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     balbi@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] usb: gadget: u_ether: Remove duplicated include in u_ether.c
Date:   Thu, 23 Jun 2022 09:08:08 +0800
Message-Id: <20220623010808.9816-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following includecheck warning:
./drivers/usb/gadget/function/u_ether.c: linux/etherdevice.h is included
more than once.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/usb/gadget/function/u_ether.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index f51694f29de9..7887def05dc2 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -17,7 +17,6 @@
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
 #include <linux/if_vlan.h>
-#include <linux/etherdevice.h>
 
 #include "u_ether.h"
 
-- 
2.20.1.7.g153144c

