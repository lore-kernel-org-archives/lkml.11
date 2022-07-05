Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F3BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 13:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiGENoY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 09:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbiGENny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:43:54 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223361B7A1;
        Tue,  5 Jul 2022 06:07:55 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LcjZx0cSBz1L8ky;
        Tue,  5 Jul 2022 21:05:29 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 5 Jul 2022 21:07:53 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 5 Jul
 2022 21:07:52 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     <f.fainelli@gmail.com>, <davem@davemloft.net>
Subject: [PATCH -next] net: dsa: b53: remove unnecessary spi_set_drvdata()
Date:   Tue, 5 Jul 2022 21:17:33 +0800
Message-ID: <20220705131733.351962-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary spi_set_drvdata() in b53_spi_remove(), the
driver_data will be set to NULL in device_unbind_cleanup() after
calling ->remove().

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/net/dsa/b53/b53_spi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_spi.c b/drivers/net/dsa/b53/b53_spi.c
index 0e54b2a0c211..308f15d3832e 100644
--- a/drivers/net/dsa/b53/b53_spi.c
+++ b/drivers/net/dsa/b53/b53_spi.c
@@ -320,8 +320,6 @@ static void b53_spi_remove(struct spi_device *spi)
 
 	if (dev)
 		b53_switch_remove(dev);
-
-	spi_set_drvdata(spi, NULL);
 }
 
 static void b53_spi_shutdown(struct spi_device *spi)
-- 
2.25.1

