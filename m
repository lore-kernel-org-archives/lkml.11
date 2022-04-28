Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047D7C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Apr 2022 06:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243541AbiD1GRH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Apr 2022 02:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238534AbiD1GRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:17:05 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0694521243;
        Wed, 27 Apr 2022 23:13:46 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kplfs3XgzzhYnb;
        Thu, 28 Apr 2022 14:13:25 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 14:13:45 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 14:13:44 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
CC:     <nbd@nbd.name>, <john@phrozen.org>, <kuba@kernel.org>,
        <davem@davemloft.net>
Subject: [PATCH] net: ethernet: mediatek: add missing of_node_put() in mtk_sgmii_init()
Date:   Thu, 28 Apr 2022 14:25:43 +0800
Message-ID: <20220428062543.64883-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node pointer returned by of_parse_phandle() with refcount incremented,
so add of_node_put() after using it in mtk_sgmii_init().

Fixes: 9ffee4a8276c ("net: ethernet: mediatek: Extend SGMII related functions")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/net/ethernet/mediatek/mtk_sgmii.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mediatek/mtk_sgmii.c b/drivers/net/ethernet/mediatek/mtk_sgmii.c
index 32d83421226a..5897940a418b 100644
--- a/drivers/net/ethernet/mediatek/mtk_sgmii.c
+++ b/drivers/net/ethernet/mediatek/mtk_sgmii.c
@@ -26,6 +26,7 @@ int mtk_sgmii_init(struct mtk_sgmii *ss, struct device_node *r, u32 ana_rgc3)
 			break;
 
 		ss->regmap[i] = syscon_node_to_regmap(np);
+		of_node_put(np);
 		if (IS_ERR(ss->regmap[i]))
 			return PTR_ERR(ss->regmap[i]);
 	}
-- 
2.25.1

