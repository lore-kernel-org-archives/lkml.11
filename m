Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF69DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 09:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242421AbiF1Ju1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jun 2022 05:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241460AbiF1JuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:50:25 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F0AB82
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:50:23 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LXKXP60h0zdZqY;
        Tue, 28 Jun 2022 17:48:05 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 28 Jun
 2022 17:50:20 +0800
From:   Xu Qiang <xuqiang36@huawei.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>, <elic@nvidia.com>,
        <si-wei.liu@oracle.com>, <parav@nvidia.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <xuqiang36@huawei.com>,
        <rui.xiang@huawei.com>
Subject: [PATCH -next] vdpa/mlx5: Use eth_zero_addr() to assign zero address
Date:   Tue, 28 Jun 2022 09:44:18 +0000
Message-ID: <20220628094418.27973-1-xuqiang36@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using eth_zero_addr() to assign zero address insetad of
memset().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Xu Qiang <xuqiang36@huawei.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index e85c1d71f4ed..f738c78ef446 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1457,8 +1457,8 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
 
 	*ucast = rule;
 
-	memset(dmac_c, 0, ETH_ALEN);
-	memset(dmac_v, 0, ETH_ALEN);
+	eth_zero_addr(dmac_c);
+	eth_zero_addr(dmac_v);
 	dmac_c[0] = 1;
 	dmac_v[0] = 1;
 	rule = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, &dest, 1);
-- 
2.17.1

