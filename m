Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47ED0C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 13:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346098AbiF1NPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jun 2022 09:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344517AbiF1NP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:15:29 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ECF31236;
        Tue, 28 Jun 2022 06:15:27 -0700 (PDT)
Received: from kwepemi500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LXQ5V2PZCzkWg9;
        Tue, 28 Jun 2022 21:13:34 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500023.china.huawei.com
 (7.221.188.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 28 Jun
 2022 21:15:23 +0800
From:   Peng Wu <wupeng58@huawei.com>
To:     <clement.leger@bootlin.com>, <andrew@lunn.ch>,
        <vivien.didelot@gmail.com>, <f.fainelli@gmail.com>,
        <olteanv@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>
CC:     <linux-renesas-soc@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <liwei391@huawei.com>,
        <wupeng58@huawei.com>
Subject: [PATCH] net: dsa: rzn1-a5psw: fix a NULL vs IS_ERR() check in a5psw_probe()
Date:   Tue, 28 Jun 2022 13:09:20 +0000
Message-ID: <20220628130920.49493-1-wupeng58@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500023.china.huawei.com (7.221.188.76)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_platform_ioremap_resource() function never returns NULL.
It returns error pointers.

Signed-off-by: Peng Wu <wupeng58@huawei.com>
Reported-by: Hulk Robot <hulkci@huawei.com>
---
 drivers/net/dsa/rzn1_a5psw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/rzn1_a5psw.c b/drivers/net/dsa/rzn1_a5psw.c
index 3e910da98ae2..5b14e2ba9b79 100644
--- a/drivers/net/dsa/rzn1_a5psw.c
+++ b/drivers/net/dsa/rzn1_a5psw.c
@@ -946,8 +946,8 @@ static int a5psw_probe(struct platform_device *pdev)
 	mutex_init(&a5psw->lk_lock);
 	spin_lock_init(&a5psw->reg_lock);
 	a5psw->base = devm_platform_ioremap_resource(pdev, 0);
-	if (!a5psw->base)
-		return -EINVAL;
+	if (IS_ERR(a5psw->base))
+		return PTR_ERR(a5psw->base);
 
 	ret = a5psw_pcs_get(a5psw);
 	if (ret)
-- 
2.17.1

