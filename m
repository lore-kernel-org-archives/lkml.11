Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC65FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jul 2022 06:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiGZGFd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jul 2022 02:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiGZGFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 02:05:31 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30412614E;
        Mon, 25 Jul 2022 23:05:29 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LsRBy4WlNz1M8M4;
        Tue, 26 Jul 2022 14:02:18 +0800 (CST)
Received: from dggpeml500005.china.huawei.com (7.185.36.59) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 14:05:10 +0800
Received: from huawei.com (10.247.19.50) by dggpeml500005.china.huawei.com
 (7.185.36.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Jul
 2022 14:05:09 +0800
From:   Chen Xingdi <chenxingdi@huawei.com>
To:     <mathias.nyman@intel.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <chunkeey@googlemail.com>,
        <chenxingdi@huawei.com>
Subject: [PATCH -next] usb: renesas-xhci: Use pr_info while fw verify success
Date:   Tue, 26 Jul 2022 14:05:09 +0800
Message-ID: <20220726060509.20748-1-chenxingdi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.247.19.50]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500005.china.huawei.com (7.185.36.59)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While fw verify success, it is confused to print an error
log which is actually not an error, so use pr_info to print
firmware version instead of pr_err.

Signed-off-by: Chen Xingdi <chenxingdi@huawei.com>
---
 drivers/usb/host/xhci-pci-renesas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-pci-renesas.c b/drivers/usb/host/xhci-pci-renesas.c
index 52599d96634f..1eb1d863d545 100644
--- a/drivers/usb/host/xhci-pci-renesas.c
+++ b/drivers/usb/host/xhci-pci-renesas.c
@@ -151,7 +151,7 @@ static int renesas_fw_verify(const void *fw_data,
 	}
 
 	fw_version = get_unaligned_le16(fw_data + fw_version_pointer);
-	pr_err("got firmware version: %02x.", fw_version);
+	pr_info("got firmware version: %02x.", fw_version);
 
 	return 0;
 }
-- 
2.17.1

