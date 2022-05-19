Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF854C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 03:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbiESDCd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 May 2022 23:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiESDC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 23:02:27 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4754356F8A
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 20:02:26 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L3ZPB3BSrz1JCHG
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:01:02 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 11:02:24 +0800
From:   GUO Zihua <guozihua@huawei.com>
To:     <linux-kernel@vger.kernel.org>
Subject: [RESEND] samples: Remove redundant assignment for cn_test sample
Date:   Thu, 19 May 2022 11:00:50 +0800
Message-ID: <20220519030050.218224-1-guozihua@huawei.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.31]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant assignment for m->len

Signed-off-by: GUO Zihua <guozihua@huawei.com>
---
 samples/connector/cn_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/samples/connector/cn_test.c b/samples/connector/cn_test.c
index 0958a171d048..42d6c9f33842 100644
--- a/samples/connector/cn_test.c
+++ b/samples/connector/cn_test.c
@@ -124,7 +124,6 @@ static void cn_test_timer_func(struct timer_list *unused)
 
 		memcpy(&m->id, &cn_test_id, sizeof(m->id));
 		m->seq = cn_test_timer_counter;
-		m->len = sizeof(data);
 
 		m->len =
 		    scnprintf(data, sizeof(data), "counter = %u",
-- 
2.36.0

