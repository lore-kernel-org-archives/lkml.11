Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87625C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 10:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238741AbiCNK4z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 06:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238614AbiCNK4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 06:56:51 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1471443ED9;
        Mon, 14 Mar 2022 03:55:42 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KHD1f0mZMzfYvc;
        Mon, 14 Mar 2022 18:54:14 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Mar 2022 18:55:39 +0800
From:   Ziyang Xuan <william.xuanziyang@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <netdev@vger.kernel.org>
CC:     <edumazet@google.com>, <sakiwit@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 3/3] net: ipvtap: fix error comments
Date:   Mon, 14 Mar 2022 19:13:25 +0800
Message-ID: <1fdd040200b495add1020f4a0890ce8d87267334.1647255926.git.william.xuanziyang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1647255926.git.william.xuanziyang@huawei.com>
References: <cover.1647255926.git.william.xuanziyang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use "macvlan" comment inappropriately in ipvtap module.
Fix them with "ipvlan" comment.

Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
---
 drivers/net/ipvlan/ipvtap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipvlan/ipvtap.c b/drivers/net/ipvlan/ipvtap.c
index ef02f2cf5ce1..c130cfb30822 100644
--- a/drivers/net/ipvlan/ipvtap.c
+++ b/drivers/net/ipvlan/ipvtap.c
@@ -83,7 +83,7 @@ static int ipvtap_newlink(struct net *src_net, struct net_device *dev,
 
 	INIT_LIST_HEAD(&vlantap->tap.queue_list);
 
-	/* Since macvlan supports all offloads by default, make
+	/* Since ipvlan supports all offloads by default, make
 	 * tap support all offloads also.
 	 */
 	vlantap->tap.tap_features = TUN_OFFLOADS;
@@ -95,7 +95,7 @@ static int ipvtap_newlink(struct net *src_net, struct net_device *dev,
 	if (err)
 		return err;
 
-	/* Don't put anything that may fail after macvlan_common_newlink
+	/* Don't put anything that may fail after ipvlan_link_new
 	 * because we can't undo what it does.
 	 */
 	err =  ipvlan_link_new(src_net, dev, tb, data, extack);
-- 
2.25.1

