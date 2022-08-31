Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C58AECAAD3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Aug 2022 04:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiHaEMc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Aug 2022 00:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiHaEM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 00:12:29 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59CB7E836;
        Tue, 30 Aug 2022 21:12:27 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MHVzL5j22z1N7d4;
        Wed, 31 Aug 2022 12:08:46 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 31 Aug
 2022 12:12:25 +0800
From:   Zhengchao Shao <shaozhengchao@huawei.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <jhs@mojatatu.com>,
        <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <shaozhengchao@huawei.com>
Subject: [PATCH net-next] net: sched: gred: remove NULL check before free table->tab in gred_destroy()
Date:   Wed, 31 Aug 2022 12:14:52 +0800
Message-ID: <20220831041452.33026-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kfree invoked by gred_destroy_vq checks whether the input parameter
is empty. Therefore, gred_destroy() doesn't need to check table->tab.

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 net/sched/sch_gred.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_gred.c b/net/sched/sch_gred.c
index e7af53f607bb..48da8ac8419e 100644
--- a/net/sched/sch_gred.c
+++ b/net/sched/sch_gred.c
@@ -911,10 +911,9 @@ static void gred_destroy(struct Qdisc *sch)
 	struct gred_sched *table = qdisc_priv(sch);
 	int i;
 
-	for (i = 0; i < table->DPs; i++) {
-		if (table->tab[i])
-			gred_destroy_vq(table->tab[i]);
-	}
+	for (i = 0; i < table->DPs; i++)
+		gred_destroy_vq(table->tab[i]);
+
 	gred_offload(sch, TC_GRED_DESTROY);
 	kfree(table->opt);
 }
-- 
2.17.1

