Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8D3C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 12:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbiBXMAu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 07:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiBXMAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 07:00:48 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1234BB8A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 04:00:19 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K4BDx34Ltzbbpy;
        Thu, 24 Feb 2022 19:55:45 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 24 Feb
 2022 20:00:17 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/oom_kill: remove unneeded is_memcg_oom check
Date:   Thu, 24 Feb 2022 19:59:33 +0800
Message-ID: <20220224115933.20154-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

oom_cpuset_eligible is always called when !is_memcg_oom. Remove this
unnecessary check.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/oom_kill.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 9fea6d3c1ec7..c70a4330e548 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -122,9 +122,6 @@ static bool oom_cpuset_eligible(struct task_struct *start,
 	bool ret = false;
 	const nodemask_t *mask = oc->nodemask;
 
-	if (is_memcg_oom(oc))
-		return true;
-
 	rcu_read_lock();
 	for_each_thread(start, tsk) {
 		if (mask) {
-- 
2.23.0

