Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14695C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Mar 2022 12:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355787AbiCPMxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Mar 2022 08:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237944AbiCPMxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 08:53:24 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6670F66ACC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 05:52:10 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KJVW45QTBzfZ3Q;
        Wed, 16 Mar 2022 20:50:40 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (7.185.36.200) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 20:52:08 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 16 Mar
 2022 20:52:08 +0800
From:   Yu Liao <liaoyu15@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tytso@mit.edu>, <liaoyu15@huawei.com>, <liwei391@huawei.com>
Subject: [PATCH -next] ext4: cleanup ext4_fc_del()
Date:   Wed, 16 Mar 2022 21:01:26 +0800
Message-ID: <20220316130126.261904-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the local variable sbi and EXT4_SB(inode->i_sb) are equivalent,
simply replace EXT4_SB(inode->i_sb) with sbi.

Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 fs/ext4/fast_commit.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 3d72565ec6e8..51ff3c8d05d5 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -284,13 +284,13 @@ void ext4_fc_del(struct inode *inode)
 	struct ext4_fc_dentry_update *fc_dentry;
 
 	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
-	    (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY))
+	    (sbi->s_mount_state & EXT4_FC_REPLAY))
 		return;
 
 restart:
-	spin_lock(&EXT4_SB(inode->i_sb)->s_fc_lock);
+	spin_lock(&sbi->s_fc_lock);
 	if (list_empty(&ei->i_fc_list) && list_empty(&ei->i_fc_dilist)) {
-		spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
+		spin_unlock(&sbi->s_fc_lock);
 		return;
 	}
 
-- 
2.25.1

