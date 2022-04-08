Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7400C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Apr 2022 03:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbiDHDQF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Apr 2022 23:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbiDHDQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 23:16:00 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B77516218F;
        Thu,  7 Apr 2022 20:13:58 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KZNcQ5JmXzdZN3;
        Fri,  8 Apr 2022 11:13:26 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 8 Apr 2022 11:13:55 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 8 Apr
 2022 11:13:55 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <nbd@nbd.name>, <davem@davemloft.net>
Subject: [PATCH -next] net: ethernet: mtk_eth_soc: fix return value check in mtk_wed_add_hw()
Date:   Fri, 8 Apr 2022 11:22:46 +0800
Message-ID: <20220408032246.3089403-1-yangyingliang@huawei.com>
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

If syscon_regmap_lookup_by_phandle() fails, it never return NULL pointer,
change the check to IS_ERR().

Fixes: 804775dfc288 ("net: ethernet: mtk_eth_soc: add support for Wireless Ethernet Dispatch (WED)")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/net/ethernet/mediatek/mtk_wed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index f0eacf819cd9..5d510ac24f2a 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -813,7 +813,7 @@ void mtk_wed_add_hw(struct device_node *np, struct mtk_eth *eth,
 		return;
 
 	regs = syscon_regmap_lookup_by_phandle(np, NULL);
-	if (!regs)
+	if (IS_ERR(regs))
 		return;
 
 	rcu_assign_pointer(mtk_soc_wed_ops, &wed_ops);
-- 
2.25.1

