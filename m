Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C41BC2BB41
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Aug 2022 06:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiHPGvO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Aug 2022 02:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiHPGum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 02:50:42 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC8E107AE4;
        Mon, 15 Aug 2022 19:01:26 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M6DmV0jmLzXdgr;
        Tue, 16 Aug 2022 09:57:14 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 16 Aug
 2022 10:01:24 +0800
From:   Zhengchao Shao <shaozhengchao@huawei.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <shaozhengchao@huawei.com>
Subject: [PATCH net-next,3/3] net: sched: make red_offload() void
Date:   Tue, 16 Aug 2022 10:04:23 +0800
Message-ID: <20220816020423.323820-4-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220816020423.323820-1-shaozhengchao@huawei.com>
References: <20220816020423.323820-1-shaozhengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of function red_offload is unused, make red_offload()
void.

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 net/sched/sch_red.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
index 40adf1f07a82..8425f4169eed 100644
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -181,7 +181,7 @@ static void red_reset(struct Qdisc *sch)
 	red_restart(&q->vars);
 }
 
-static int red_offload(struct Qdisc *sch, bool enable)
+static void red_offload(struct Qdisc *sch, bool enable)
 {
 	struct red_sched_data *q = qdisc_priv(sch);
 	struct net_device *dev = qdisc_dev(sch);
@@ -191,7 +191,7 @@ static int red_offload(struct Qdisc *sch, bool enable)
 	};
 
 	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
-		return -EOPNOTSUPP;
+		return;
 
 	if (enable) {
 		opt.command = TC_RED_REPLACE;
@@ -207,7 +207,7 @@ static int red_offload(struct Qdisc *sch, bool enable)
 		opt.command = TC_RED_DESTROY;
 	}
 
-	return dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_RED, &opt);
+	dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_RED, &opt);
 }
 
 static void red_destroy(struct Qdisc *sch)
-- 
2.17.1

