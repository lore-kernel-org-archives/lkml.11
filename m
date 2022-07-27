Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7725EC19F28
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jul 2022 03:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240129AbiG0DLx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jul 2022 23:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbiG0DLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 23:11:50 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96291CE3E;
        Tue, 26 Jul 2022 20:11:49 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LszJq0HFyzkXkj;
        Wed, 27 Jul 2022 11:09:15 +0800 (CST)
Received: from dggpeml500005.china.huawei.com (7.185.36.59) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 11:11:47 +0800
Received: from huawei.com (10.247.19.50) by dggpeml500005.china.huawei.com
 (7.185.36.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Jul
 2022 11:11:47 +0800
From:   Chen Xingdi <chenxingdi@huawei.com>
To:     <mathias.nyman@intel.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <chunkeey@googlemail.com>,
        <chenxingdi@huawei.com>
Subject: [PATCH v2 -next] usb: renesas-xhci: Do not print any log while fw verif success
Date:   Wed, 27 Jul 2022 11:11:46 +0800
Message-ID: <20220727031146.19345-1-chenxingdi@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220726060509.20748-1-chenxingdi@huawei.com>
References: <20220726060509.20748-1-chenxingdi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.247.19.50]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500005.china.huawei.com (7.185.36.59)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When drivers are working properly, they should be quiet.

Signed-off-by: Chen Xingdi <chenxingdi@huawei.com>
---
v2:
- delete the log instead of change the log level to info.
 drivers/usb/host/xhci-pci-renesas.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/usb/host/xhci-pci-renesas.c b/drivers/usb/host/xhci-pci-renesas.c
index 52599d96634f..93f8b355bc70 100644
--- a/drivers/usb/host/xhci-pci-renesas.c
+++ b/drivers/usb/host/xhci-pci-renesas.c
@@ -120,7 +120,6 @@ static int renesas_fw_verify(const void *fw_data,
 			     size_t length)
 {
 	u16 fw_version_pointer;
-	u16 fw_version;
 
 	/*
 	 * The Firmware's Data Format is describe in
@@ -150,9 +149,6 @@ static int renesas_fw_verify(const void *fw_data,
 		return -EINVAL;
 	}
 
-	fw_version = get_unaligned_le16(fw_data + fw_version_pointer);
-	pr_err("got firmware version: %02x.", fw_version);
-
 	return 0;
 }
 
-- 
2.17.1

