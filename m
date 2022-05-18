Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A727C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 May 2022 02:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbiERCp2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 22:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbiERCpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 22:45:22 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5408E2D1E9;
        Tue, 17 May 2022 19:45:20 -0700 (PDT)
Received: from kwepemi500014.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L2y3x2ft8z1JCDy;
        Wed, 18 May 2022 10:43:57 +0800 (CST)
Received: from huawei.com (10.67.174.157) by kwepemi500014.china.huawei.com
 (7.221.188.232) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 10:45:17 +0800
From:   Li Zhengyu <lizhengyu3@huawei.com>
To:     <dbaryshkov@gmail.com>
CC:     <stern@rowland.harvard.edu>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] usb: host: ohci-tmio: Remove redundant if statement
Date:   Wed, 18 May 2022 10:43:47 +0800
Message-ID: <20220518024347.213402-1-lizhengyu3@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.157]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500014.china.huawei.com (7.221.188.232)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(ret == 0) is true when (ret) is false, so remove it.
Also remove unreachable code.

Signed-off-by: Li Zhengyu <lizhengyu3@huawei.com>
---
 drivers/usb/host/ohci-tmio.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/usb/host/ohci-tmio.c b/drivers/usb/host/ohci-tmio.c
index 49539b9f0e94..6bcb0cb53f7c 100644
--- a/drivers/usb/host/ohci-tmio.c
+++ b/drivers/usb/host/ohci-tmio.c
@@ -243,12 +243,8 @@ static int ohci_hcd_tmio_drv_probe(struct platform_device *dev)
 	ret = usb_add_hcd(hcd, irq, 0);
 	if (ret)
 		goto err_add_hcd;
-
 	device_wakeup_enable(hcd->self.controller);
-	if (ret == 0)
-		return ret;
-
-	usb_remove_hcd(hcd);
+	return ret;
 
 err_add_hcd:
 	tmio_stop_hc(dev);
-- 
2.17.1

