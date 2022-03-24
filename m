Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733F4C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Mar 2022 02:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347828AbiCXCnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 22:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347826AbiCXCnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 22:43:52 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8047939DF;
        Wed, 23 Mar 2022 19:42:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V82lYat_1648089737;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V82lYat_1648089737)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 24 Mar 2022 10:42:18 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     konishi.ryusuke@gmail.com
Cc:     linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next v2] fs: Fix some kernel-doc comments
Date:   Thu, 24 Mar 2022 10:42:15 +0800
Message-Id: <20220324024215.63479-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The description of @flags in nilfs_dirty_inode() kernel-doc
comment is missing, and some functions had kernel-doc that
used a hash instead of a colon to separate the parameter
name from the one line description.

Fix them to remove some warnings found by running scripts/kernel-doc,
which is caused by using 'make W=1'.

fs/nilfs2/inode.c:73: warning: Function parameter or member 'inode' not
described in 'nilfs_get_block'
fs/nilfs2/inode.c:73: warning: Function parameter or member 'blkoff' not
described in 'nilfs_get_block'
fs/nilfs2/inode.c:73: warning: Function parameter or member 'bh_result'
not described in 'nilfs_get_block'
fs/nilfs2/inode.c:73: warning: Function parameter or member 'create' not
described in 'nilfs_get_block'
fs/nilfs2/inode.c:145: warning: Function parameter or member 'file' not
described in 'nilfs_readpage'
fs/nilfs2/inode.c:145: warning: Function parameter or member 'page' not
described in 'nilfs_readpage'
fs/nilfs2/inode.c:968: warning: Function parameter or member 'flags' not
described in 'nilfs_dirty_inode'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---

--Changes in v2:
Modified description of @flags in nilfs_dirty_inode() kernel-doc comment

 fs/nilfs2/inode.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 476a4a649f38..ae0afc6a30bb 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -59,10 +59,10 @@ void nilfs_inode_sub_blocks(struct inode *inode, int n)
 
 /**
  * nilfs_get_block() - get a file block on the filesystem (callback function)
- * @inode - inode struct of the target file
- * @blkoff - file block number
- * @bh_result - buffer head to be mapped on
- * @create - indicate whether allocating the block or not when it has not
+ * @inode: inode struct of the target file
+ * @blkoff: file block number
+ * @bh_result: buffer head to be mapped on
+ * @create: indicate whether allocating the block or not when it has not
  *      been allocated yet.
  *
  * This function does not issue actual read request of the specified data
@@ -138,8 +138,8 @@ int nilfs_get_block(struct inode *inode, sector_t blkoff,
 /**
  * nilfs_readpage() - implement readpage() method of nilfs_aops {}
  * address_space_operations.
- * @file - file struct of the file to be read
- * @page - the page to be read
+ * @file: file struct of the file to be read
+ * @page: the page to be read
  */
 static int nilfs_readpage(struct file *file, struct page *page)
 {
@@ -957,6 +957,7 @@ int __nilfs_mark_inode_dirty(struct inode *inode, int flags)
 /**
  * nilfs_dirty_inode - reflect changes on given inode to an inode block.
  * @inode: inode of the file to be registered.
+ * @flags: flags to determine the dirty state of the inode
  *
  * nilfs_dirty_inode() loads a inode block containing the specified
  * @inode and copies data from a nilfs_inode to a corresponding inode
-- 
2.20.1.7.g153144c

