Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CC1C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Mar 2022 12:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242468AbiCGMfR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242401AbiCGMeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:34:44 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FD440E5A;
        Mon,  7 Mar 2022 04:33:30 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V6WFbFi_1646656406;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V6WFbFi_1646656406)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Mar 2022 20:33:27 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 14/21] erofs: register cookie context for bootstrap blob
Date:   Mon,  7 Mar 2022 20:32:58 +0800
Message-Id: <20220307123305.79520-15-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220307123305.79520-1-jefflexu@linux.alibaba.com>
References: <20220307123305.79520-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Registers fscache_cookie for the bootstrap blob file. The bootstrap blob
file can be specified by a new mount option, which is going to be
introduced by a following patch.

Something worth mentioning about the cleanup routine.

1. The init routine is prior to when the root inode gets initialized,
and thus the corresponding cleanup routine shall be placed under
.kill_sb() callback.

2. The init routine will instantiate anonymous inodes under the
super_block, and thus .put_super() callback shall also contain the
cleanup routine. Or we'll get "VFS: Busy inodes after unmount." warning.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/internal.h |  3 +++
 fs/erofs/super.c    | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index bb5e992fe0df..277dcd5888ea 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -75,6 +75,7 @@ struct erofs_mount_opts {
 	unsigned int max_sync_decompress_pages;
 #endif
 	unsigned int mount_opt;
+	char *uuid;
 };
 
 struct erofs_dev_context {
@@ -152,6 +153,8 @@ struct erofs_sb_info {
 	/* sysfs support */
 	struct kobject s_kobj;		/* /sys/fs/erofs/<devname> */
 	struct completion s_kobj_unregister;
+
+	struct erofs_fscache_context *bootstrap;
 };
 
 #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 798f0c379e35..8c5783c6f71f 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -598,6 +598,16 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	sbi->devs = ctx->devs;
 	ctx->devs = NULL;
 
+	if (!erofs_bdev_mode(sb)) {
+		struct erofs_fscache_context *bootstrap;
+
+		bootstrap = erofs_fscache_get_ctx(sb, ctx->opt.uuid, true);
+		if (IS_ERR(bootstrap))
+			return PTR_ERR(bootstrap);
+
+		sbi->bootstrap = bootstrap;
+	}
+
 	err = erofs_read_superblock(sb);
 	if (err)
 		return err;
@@ -753,6 +763,7 @@ static void erofs_kill_sb(struct super_block *sb)
 		return;
 
 	erofs_free_dev_context(sbi->devs);
+	erofs_fscache_put_ctx(sbi->bootstrap);
 	fs_put_dax(sbi->dax_dev);
 	kfree(sbi);
 	sb->s_fs_info = NULL;
@@ -771,6 +782,8 @@ static void erofs_put_super(struct super_block *sb)
 	iput(sbi->managed_cache);
 	sbi->managed_cache = NULL;
 #endif
+	erofs_fscache_put_ctx(sbi->bootstrap);
+	sbi->bootstrap = NULL;
 }
 
 static struct file_system_type erofs_fs_type = {
-- 
2.27.0

