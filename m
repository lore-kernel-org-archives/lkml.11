Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1697EC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Mar 2022 14:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbiCQOn2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Mar 2022 10:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbiCQOnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:43:08 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FA4200946
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 07:41:50 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KK8q50TL1z1GCTw;
        Thu, 17 Mar 2022 22:36:49 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Mar
 2022 22:41:48 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ziy@nvidia.com>, <baolin.wang@linux.alibaba.com>,
        <ying.huang@intel.com>, <songmuchun@bytedance.com>,
        <apopple@nvidia.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 01/11] mm/migration: remove unneeded local variable mapping_locked
Date:   Fri, 18 Mar 2022 19:16:59 +0800
Message-ID: <20220318111709.60311-2-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220318111709.60311-1-linmiaohe@huawei.com>
References: <20220318111709.60311-1-linmiaohe@huawei.com>
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

When mapping_locked is true, TTU_RMAP_LOCKED is always set to ttu. We can
check ttu instead so mapping_locked can be removed. And ttu is either 0
or TTU_RMAP_LOCKED now. Change '|=' to '=' to reflect this.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/migrate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 42e3a944f35c..50bc62d85eaf 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1230,7 +1230,6 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 		goto put_anon;
 
 	if (page_mapped(hpage)) {
-		bool mapping_locked = false;
 		enum ttu_flags ttu = 0;
 
 		if (!PageAnon(hpage)) {
@@ -1244,14 +1243,13 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 			if (unlikely(!mapping))
 				goto unlock_put_anon;
 
-			mapping_locked = true;
-			ttu |= TTU_RMAP_LOCKED;
+			ttu = TTU_RMAP_LOCKED;
 		}
 
 		try_to_migrate(src, ttu);
 		page_was_mapped = 1;
 
-		if (mapping_locked)
+		if (ttu & TTU_RMAP_LOCKED)
 			i_mmap_unlock_write(mapping);
 	}
 
-- 
2.23.0

