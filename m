Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA79C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jun 2022 03:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348191AbiFEDrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jun 2022 23:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347889AbiFEDrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 23:47:08 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253A9C74
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 20:46:57 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LG2bC3phCzjXGn;
        Sun,  5 Jun 2022 11:45:59 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 5 Jun 2022 11:46:53 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 5 Jun 2022 11:46:53 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <hughd@google.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>, <david@redhat.com>,
        <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 1/3] mm/shmem: check return value of shmem_init_inodecache
Date:   Sun, 5 Jun 2022 11:55:55 +0800
Message-ID: <20220605035557.3957759-2-chenwandun@huawei.com>
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

It will result in null pointer access if shmem_init_inodecache fail,
so check return value of shmem_init_inodecache

Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 mm/shmem.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 12d45a03f7fc..17f8297ece29 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3775,11 +3775,13 @@ static void shmem_init_inode(void *foo)
 	inode_init_once(&info->vfs_inode);
 }
 
-static void shmem_init_inodecache(void)
+static struct kmem_cache *shmem_init_inodecache(void)
 {
 	shmem_inode_cachep = kmem_cache_create("shmem_inode_cache",
 				sizeof(struct shmem_inode_info),
 				0, SLAB_PANIC|SLAB_ACCOUNT, shmem_init_inode);
+
+	return shmem_inode_cachep;
 }
 
 static void shmem_destroy_inodecache(void)
@@ -3923,7 +3925,10 @@ void __init shmem_init(void)
 {
 	int error;
 
-	shmem_init_inodecache();
+	if (!shmem_init_inodecache()) {
+		error = -ENOMEM;
+		goto out2;
+	}
 
 	error = register_filesystem(&shmem_fs_type);
 	if (error) {
-- 
2.25.1

