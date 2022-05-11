Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F179FC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 May 2022 02:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240764AbiEKC2C (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 May 2022 22:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239947AbiEKC16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 22:27:58 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453C03056D;
        Tue, 10 May 2022 19:27:55 -0700 (PDT)
Received: from kwepemi500004.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KydzP1RpqzGpYV;
        Wed, 11 May 2022 10:25:05 +0800 (CST)
Received: from kwepemm600012.china.huawei.com (7.193.23.74) by
 kwepemi500004.china.huawei.com (7.221.188.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 11 May 2022 10:27:53 +0800
Received: from ubuntu1804.huawei.com (10.67.175.29) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 11 May 2022 10:27:53 +0800
From:   Guan Jing <guanjing6@huawei.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Guan Jing <guanjing6@huawei.com>
Subject: [PATCH -next v2] usb: dwc3: include extcon.h to fix compile error
Date:   Wed, 11 May 2022 10:26:22 +0800
Message-ID: <20220511022622.168486-1-guanjing6@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.29]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600012.china.huawei.com (7.193.23.74)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If dwc3 is not include extcon.h, the dwc3 driver
will fail to link:

drivers/usb/dwc3/core.o: In function `dwc3_probe':
core.c:(.text+0x1095): undefined reference to `extcon_get_edev_by_phandle'
core.c:(.text+0x10bd): undefined reference to `extcon_get_extcon_dev'

Add miss #include <linux/extcon.h> to fix this error.

Fixes: 0f0101719138 ("usb: dwc3: Don't switch OTG -> peripheral if extcon is present")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Guan Jing <guanjing6@huawei.com>
---
 drivers/usb/dwc3/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 950e238c65bf..e619a3ef6c46 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -28,6 +28,7 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/reset.h>
 #include <linux/bitfield.h>
+#include <linux/extcon.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
-- 
2.17.1

