Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC11C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 02:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbiESCGN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 May 2022 22:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiESCGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 22:06:11 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB97119FBD;
        Wed, 18 May 2022 19:06:07 -0700 (PDT)
Received: from kwepemi500014.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L3Y953SvwzhZCp;
        Thu, 19 May 2022 10:05:29 +0800 (CST)
Received: from huawei.com (10.67.174.157) by kwepemi500014.china.huawei.com
 (7.221.188.232) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 10:06:05 +0800
From:   Li Zhengyu <lizhengyu3@huawei.com>
To:     <dbaryshkov@gmail.com>
CC:     <stern@rowland.harvard.edu>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] usb: host: ohci-tmio: Fix unchecked return value for device_wakeup_enable
Date:   Thu, 19 May 2022 10:04:34 +0800
Message-ID: <20220519020434.31575-1-lizhengyu3@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.157]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500014.china.huawei.com (7.221.188.232)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of device_wakeup_enable() is unchecked, as the result
usb_remove_hcd() is unreachable even if device_wakeup_enable() is failed.

Fixes: 78c73414f4f6 ("USB: ohci: add support for tmio-ohci cell")

Signed-off-by: Li Zhengyu <lizhengyu3@huawei.com>
---
 drivers/usb/host/ohci-tmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ohci-tmio.c b/drivers/usb/host/ohci-tmio.c
index 49539b9f0e94..8148dc90c066 100644
--- a/drivers/usb/host/ohci-tmio.c
+++ b/drivers/usb/host/ohci-tmio.c
@@ -244,7 +244,7 @@ static int ohci_hcd_tmio_drv_probe(struct platform_device *dev)
 	if (ret)
 		goto err_add_hcd;
 
-	device_wakeup_enable(hcd->self.controller);
+	ret = device_wakeup_enable(hcd->self.controller);
 	if (ret == 0)
 		return ret;
 
-- 
2.17.1

