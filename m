Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC265C00144
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Aug 2022 08:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiHAIxE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Aug 2022 04:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiHAIxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:53:00 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4842F67B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 01:52:58 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LxBgc4VbNzGpJY;
        Mon,  1 Aug 2022 16:51:40 +0800 (CST)
Received: from dggpemm500016.china.huawei.com (7.185.36.25) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 1 Aug 2022 16:52:56 +0800
Received: from huawei.com (10.67.174.33) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 1 Aug
 2022 16:52:55 +0800
From:   "GONG, Ruiqi" <gongruiqi1@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <wangweiyang2@huawei.com>,
        <gongruiqi1@huawei.com>
Subject: [PATCH] tty: moxa: Refine error handling in moxa_pci_probe
Date:   Mon, 1 Aug 2022 16:53:56 +0800
Message-ID: <20220801085356.1716756-1-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.33]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pci_disable_device() into the error handling, and therefore make the
function not jump to err if pci_enable_device() failed.

Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
---
 drivers/tty/moxa.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index f3c72ab1476c..4432a39331d3 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -1239,7 +1239,7 @@ static int moxa_pci_probe(struct pci_dev *pdev,
 	retval = pci_enable_device(pdev);
 	if (retval) {
 		dev_err(&pdev->dev, "can't enable pci device\n");
-		goto err;
+		return retval;
 	}
 
 	for (i = 0; i < MAX_BOARDS; i++)
@@ -1300,6 +1300,7 @@ static int moxa_pci_probe(struct pci_dev *pdev,
 err_reg:
 	pci_release_region(pdev, 2);
 err:
+	pci_disable_device(pdev);
 	return retval;
 }
 
-- 
2.25.1

