Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E8EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 02:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242853AbiDLCJZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 22:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238348AbiDLCJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 22:09:20 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B9C338AB;
        Mon, 11 Apr 2022 19:07:04 -0700 (PDT)
Received: from kwepemi500004.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Kcps13qKFzBs9n;
        Tue, 12 Apr 2022 10:02:45 +0800 (CST)
Received: from kwepemm600016.china.huawei.com (7.193.23.20) by
 kwepemi500004.china.huawei.com (7.221.188.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 10:07:02 +0800
Received: from localhost.localdomain (10.67.165.24) by
 kwepemm600016.china.huawei.com (7.193.23.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 10:07:01 +0800
From:   Guangbin Huang <huangguangbin2@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <mkubecek@suse.cz>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lipeng321@huawei.com>, <huangguangbin2@huawei.com>,
        <chenhao288@hisilicon.com>, <wangjie125@huawei.com>
Subject: [PATCH net-next v2 2/3] net: ethtool: move checks before rtnl_lock() in ethnl_set_rings
Date:   Tue, 12 Apr 2022 10:01:20 +0800
Message-ID: <20220412020121.14140-3-huangguangbin2@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220412020121.14140-1-huangguangbin2@huawei.com>
References: <20220412020121.14140-1-huangguangbin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600016.china.huawei.com (7.193.23.20)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jie Wang <wangjie125@huawei.com>

Currently these two checks in ethnl_set_rings are added after rtnl_lock()
which will do useless works if the request is invalid.

So this patch moves these checks before the rtnl_lock() to avoid these
costs.

Signed-off-by: Jie Wang <wangjie125@huawei.com>
Signed-off-by: Guangbin Huang <huangguangbin2@huawei.com>
---
 net/ethtool/rings.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index 9ed60c507d97..fa3ec8d438f7 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -152,6 +152,24 @@ int ethnl_set_rings(struct sk_buff *skb, struct genl_info *info)
 	if (!ops->get_ringparam || !ops->set_ringparam)
 		goto out_dev;
 
+	if (tb[ETHTOOL_A_RINGS_RX_BUF_LEN] &&
+	    !(ops->supported_ring_params & ETHTOOL_RING_USE_RX_BUF_LEN)) {
+		ret = -EOPNOTSUPP;
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[ETHTOOL_A_RINGS_RX_BUF_LEN],
+				    "setting rx buf len not supported");
+		goto out_dev;
+	}
+
+	if (tb[ETHTOOL_A_RINGS_CQE_SIZE] &&
+	    !(ops->supported_ring_params & ETHTOOL_RING_USE_CQE_SIZE)) {
+		ret = -EOPNOTSUPP;
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[ETHTOOL_A_RINGS_CQE_SIZE],
+				    "setting cqe size not supported");
+		goto out_dev;
+	}
+
 	if (tb[ETHTOOL_A_RINGS_TX_PUSH] &&
 	    !(ops->supported_ring_params & ETHTOOL_RING_USE_TX_PUSH)) {
 		ret = -EOPNOTSUPP;
@@ -201,24 +219,6 @@ int ethnl_set_rings(struct sk_buff *skb, struct genl_info *info)
 		goto out_ops;
 	}
 
-	if (kernel_ringparam.rx_buf_len != 0 &&
-	    !(ops->supported_ring_params & ETHTOOL_RING_USE_RX_BUF_LEN)) {
-		ret = -EOPNOTSUPP;
-		NL_SET_ERR_MSG_ATTR(info->extack,
-				    tb[ETHTOOL_A_RINGS_RX_BUF_LEN],
-				    "setting rx buf len not supported");
-		goto out_ops;
-	}
-
-	if (kernel_ringparam.cqe_size &&
-	    !(ops->supported_ring_params & ETHTOOL_RING_USE_CQE_SIZE)) {
-		ret = -EOPNOTSUPP;
-		NL_SET_ERR_MSG_ATTR(info->extack,
-				    tb[ETHTOOL_A_RINGS_CQE_SIZE],
-				    "setting cqe size not supported");
-		goto out_ops;
-	}
-
 	ret = dev->ethtool_ops->set_ringparam(dev, &ringparam,
 					      &kernel_ringparam, info->extack);
 	if (ret < 0)
-- 
2.33.0

