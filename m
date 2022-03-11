Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C709AC433FE
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Mar 2022 08:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240585AbiCKIrZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Mar 2022 03:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiCKIrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 03:47:22 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61841BA927;
        Fri, 11 Mar 2022 00:46:19 -0800 (PST)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KFKHn44rbzfYtt;
        Fri, 11 Mar 2022 16:44:53 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 16:46:17 +0800
From:   Ziyang Xuan <william.xuanziyang@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 2/2] net: macvlan: add net device refcount tracker
Date:   Fri, 11 Mar 2022 17:04:03 +0800
Message-ID: <c9cc41c3f234c86e8d185f590c22463871c80578.1646989143.git.william.xuanziyang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1646989143.git.william.xuanziyang@huawei.com>
References: <cover.1646989143.git.william.xuanziyang@huawei.com>
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

Add net device refcount tracker to macvlan.

Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
---
 drivers/net/macvlan.c      | 4 ++--
 include/linux/if_macvlan.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index d36af413e372..d6241ad66c0c 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -912,7 +912,7 @@ static int macvlan_init(struct net_device *dev)
 	port->count += 1;
 
 	/* Get macvlan's reference to lowerdev */
-	dev_hold(lowerdev);
+	dev_hold_track(lowerdev, &vlan->dev_tracker, GFP_KERNEL);
 
 	return 0;
 }
@@ -1181,7 +1181,7 @@ static void macvlan_dev_free(struct net_device *dev)
 	struct macvlan_dev *vlan = netdev_priv(dev);
 
 	/* Get rid of the macvlan's reference to lowerdev */
-	dev_put(vlan->lowerdev);
+	dev_put_track(vlan->lowerdev, &vlan->dev_tracker);
 }
 
 void macvlan_common_setup(struct net_device *dev)
diff --git a/include/linux/if_macvlan.h b/include/linux/if_macvlan.h
index 10c94a3936ca..b42294739063 100644
--- a/include/linux/if_macvlan.h
+++ b/include/linux/if_macvlan.h
@@ -21,6 +21,7 @@ struct macvlan_dev {
 	struct hlist_node	hlist;
 	struct macvlan_port	*port;
 	struct net_device	*lowerdev;
+	netdevice_tracker	dev_tracker;
 	void			*accel_priv;
 	struct vlan_pcpu_stats __percpu *pcpu_stats;
 
-- 
2.25.1

