Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC7DC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jun 2022 03:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348462AbiFEDr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jun 2022 23:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343800AbiFEDrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 23:47:08 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3992C63
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 20:46:56 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LG2ZG1vWCzgYYt;
        Sun,  5 Jun 2022 11:45:10 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 5 Jun 2022 11:46:55 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 5 Jun 2022 11:46:54 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <hughd@google.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>, <david@redhat.com>,
        <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 2/3] mm/shmem: return error code directly for invalid addr
Date:   Sun, 5 Jun 2022 11:55:56 +0800
Message-ID: <20220605035557.3957759-3-chenwandun@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220605035557.3957759-1-chenwandun@huawei.com>
References: <20220605035557.3957759-1-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return error code directly for addr is not PAGE_SIZE aligned or
beyond TASK_SIZE, no need to check these cases in caller.

Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 mm/shmem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 17f8297ece29..5e61692f2d8e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2142,10 +2142,10 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 		return addr;
 	if (IS_ERR_VALUE(addr))
 		return addr;
-	if (addr & ~PAGE_MASK)
-		return addr;
+	if (offset_in_page(addr))
+		return -EINVAL;
 	if (addr > TASK_SIZE - len)
-		return addr;
+		return -ENOMEM;
 
 	if (shmem_huge == SHMEM_HUGE_DENY)
 		return addr;
@@ -2196,7 +2196,7 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 	inflated_addr = get_area(NULL, uaddr, inflated_len, 0, flags);
 	if (IS_ERR_VALUE(inflated_addr))
 		return addr;
-	if (inflated_addr & ~PAGE_MASK)
+	if (offset_in_page(inflated_addr))
 		return addr;
 
 	inflated_offset = inflated_addr & (HPAGE_PMD_SIZE-1);
-- 
2.25.1

