Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D4CC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 10:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245105AbiC3KDz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 06:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241067AbiC3KDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:03:54 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C06DBABA2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 03:02:09 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KT25n546JzdZN6;
        Wed, 30 Mar 2022 18:01:49 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 30 Mar 2022 18:02:07 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 30 Mar
 2022 18:02:07 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] fs: sysv: check sbi->s_firstdatazone in complete_read_super
Date:   Wed, 30 Mar 2022 18:42:15 +0800
Message-ID: <20220330104215.530223-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sbi->s_firstinodezone is initialized to 2 and sbi->s_firstdatazone is read
from sbd. There's no guarantee that sbi->s_firstdatazone must bigger than
sbi->s_firstinodezone. If sbi->s_firstdatazone less than 2, the filesystem
can still be mounted unexpetly. At this point, sbi->s_ninodes flip to very
large value and this filesystem is broken. We can observe this by
executing 'df' command. When we execute, we will get an error message:
	"sysv_count_free_inodes: unable to read inode table"

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 fs/sysv/super.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/sysv/super.c b/fs/sysv/super.c
index d1def0771a40..3365a30dc1e0 100644
--- a/fs/sysv/super.c
+++ b/fs/sysv/super.c
@@ -312,7 +312,9 @@ static int complete_read_super(struct super_block *sb, int silent, int size)
 	sbi->s_firstinodezone = 2;
 
 	flavour_setup[sbi->s_type](sbi, &sb->s_max_links);
-	
+	if (sbi->s_firstdatazone < sbi->s_firstinodezone)
+		return 0;
+
 	sbi->s_ndatazones = sbi->s_nzones - sbi->s_firstdatazone;
 	sbi->s_inodes_per_block = bsize >> 6;
 	sbi->s_inodes_per_block_1 = (bsize >> 6)-1;
-- 
2.25.1

