Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D6AC433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 03:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiBODwD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 22:52:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiBODwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 22:52:00 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5D810783D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 19:51:50 -0800 (PST)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JyRvS04FXzccm8;
        Tue, 15 Feb 2022 11:50:44 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 15 Feb
 2022 11:51:48 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <libaokun1@huawei.com>, <yukuai3@huawei.com>,
        Zhihao Cheng <chengzhihao1@huawei.com>
Subject: [PATCH -next] ubifs: rename_whiteout: correct old_dir size computing
Date:   Tue, 15 Feb 2022 12:07:36 +0800
Message-ID: <20220215040736.2839939-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When renaming the whiteout file, the old whiteout file is not deleted.
Therefore, we add the old dentry size to the old dir like XFS.
Otherwise, an error may be reported due to `fscki->calc_sz != fscki->size`
in check_indes.

Fixes: 9e0a1fff8db56ea ("ubifs: Implement RENAME_WHITEOUT")
Reported-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ubifs/dir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index ae082a0be2a3..86151889548e 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -1402,6 +1402,9 @@ static int do_rename(struct inode *old_dir, struct dentry *old_dentry,
 			iput(whiteout);
 			goto out_release;
 		}
+
+		/* Add the old_dentry size to the old_dir size. */
+		old_sz -= CALC_DENT_SIZE(fname_len(&old_nm));
 	}
 
 	lock_4_inodes(old_dir, new_dir, new_inode, whiteout);
-- 
2.31.1

