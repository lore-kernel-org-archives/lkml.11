Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F0DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 May 2022 07:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344739AbiE0HD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 May 2022 03:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239176AbiE0HDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 03:03:54 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7926FA05
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 00:03:53 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L8bMt5d4tz1JCSZ;
        Fri, 27 May 2022 15:02:18 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (7.185.36.111) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 15:03:51 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 15:03:51 +0800
From:   keliu <liuke94@huawei.com>
To:     <giometti@enneenne.com>, <gregkh@linuxfoundation.org>,
        <liuke94@huawei.com>, <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] pps: clients: Directly use ida_alloc()/free()
Date:   Fri, 27 May 2022 07:25:20 +0000
Message-ID: <20220527072520.2374615-1-liuke94@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500018.china.huawei.com (7.185.36.111)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ida_alloc()/ida_free() instead of deprecated
ida_simple_get()/ida_simple_remove() .

Signed-off-by: keliu <liuke94@huawei.com>
---
 drivers/pps/clients/pps_parport.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pps/clients/pps_parport.c b/drivers/pps/clients/pps_parport.c
index 42f93d4c6ee3..af972cdc04b5 100644
--- a/drivers/pps/clients/pps_parport.c
+++ b/drivers/pps/clients/pps_parport.c
@@ -148,7 +148,7 @@ static void parport_attach(struct parport *port)
 		return;
 	}
 
-	index = ida_simple_get(&pps_client_index, 0, 0, GFP_KERNEL);
+	index = ida_alloc(&pps_client_index, GFP_KERNEL);
 	memset(&pps_client_cb, 0, sizeof(pps_client_cb));
 	pps_client_cb.private = device;
 	pps_client_cb.irq_func = parport_irq;
@@ -188,7 +188,7 @@ static void parport_attach(struct parport *port)
 err_unregister_dev:
 	parport_unregister_device(device->pardev);
 err_free:
-	ida_simple_remove(&pps_client_index, index);
+	ida_free(&pps_client_index, index);
 	kfree(device);
 }
 
@@ -208,7 +208,7 @@ static void parport_detach(struct parport *port)
 	pps_unregister_source(device->pps);
 	parport_release(pardev);
 	parport_unregister_device(pardev);
-	ida_simple_remove(&pps_client_index, device->index);
+	ida_free(&pps_client_index, device->index);
 	kfree(device);
 }
 
-- 
2.25.1

