Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D2EC433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Apr 2022 10:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237653AbiDRKY7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Apr 2022 06:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiDRKYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 06:24:55 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB096A1BC;
        Mon, 18 Apr 2022 03:22:16 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 18 Apr
 2022 18:22:17 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Mon, 18 Apr
 2022 18:22:14 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC:     Haowen Bai <baihaowen@meizu.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] net: eql: Use kzalloc instead of kmalloc/memset
Date:   Mon, 18 Apr 2022 18:22:13 +0800
Message-ID: <1650277333-31090-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kzalloc rather than duplicating its implementation, which
makes code simple and easy to understand.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/net/eql.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/eql.c b/drivers/net/eql.c
index 1111d1f33865..557ca8ff9dec 100644
--- a/drivers/net/eql.c
+++ b/drivers/net/eql.c
@@ -425,14 +425,13 @@ static int eql_enslave(struct net_device *master_dev, slaving_request_t __user *
 	if ((master_dev->flags & IFF_UP) == IFF_UP) {
 		/* slave is not a master & not already a slave: */
 		if (!eql_is_master(slave_dev) && !eql_is_slave(slave_dev)) {
-			slave_t *s = kmalloc(sizeof(*s), GFP_KERNEL);
+			slave_t *s = kzalloc(sizeof(*s), GFP_KERNEL);
 			equalizer_t *eql = netdev_priv(master_dev);
 			int ret;
 
 			if (!s)
 				return -ENOMEM;
 
-			memset(s, 0, sizeof(*s));
 			s->dev = slave_dev;
 			s->priority = srq.priority;
 			s->priority_bps = srq.priority;
-- 
2.7.4

