Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441FAC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 06:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236449AbiCNGmn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 02:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiCNGmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 02:42:42 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736C53D1F8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 23:41:33 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KH6NP2qptzfZ2s;
        Mon, 14 Mar 2022 14:40:05 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 14 Mar
 2022 14:41:31 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <hughd@google.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2] mm/mlock: fix potential imbalanced rlimit ucounts adjustment
Date:   Mon, 14 Mar 2022 14:40:39 +0800
Message-ID: <20220314064039.62972-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

user_shm_lock forgets to set allowed to 0 when get_ucounts fails. So
the later user_shm_unlock might do the extra dec_rlimit_ucounts. Fix
this by resetting allowed to 0.

Fixes: d7c9e99aee48 ("Reimplement RLIMIT_MEMLOCK on top of ucounts")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Acked-by: Hugh Dickins <hughd@google.com>
---
v1->v2:
  correct Fixes tag and collect Acked-by tag
  Thanks Hugh for review!
---
 mm/mlock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/mlock.c b/mm/mlock.c
index 29372c0eebe5..efd2dd2943de 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -733,6 +733,7 @@ int user_shm_lock(size_t size, struct ucounts *ucounts)
 	}
 	if (!get_ucounts(ucounts)) {
 		dec_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, locked);
+		allowed = 0;
 		goto out;
 	}
 	allowed = 1;
-- 
2.23.0

