Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FE8C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jun 2022 06:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbiFBG4I (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jun 2022 02:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiFBG4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:56:03 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BED61290
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 23:56:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VF9Mp6A_1654152957;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VF9Mp6A_1654152957)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Jun 2022 14:55:58 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     richard@nod.at
Cc:     chengzhihao1@huawei.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next v2] ubifs: Fix some kernel-doc comments
Date:   Thu,  2 Jun 2022 14:55:56 +0800
Message-Id: <20220602065556.104006-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove warnings found by running scripts/kernel-doc,
which is caused by using 'make W=1'.
fs/ubifs/journal.c:1221: warning: Function parameter or member
'old_inode' not described in 'ubifs_jnl_rename'
fs/ubifs/journal.c:1221: warning: Function parameter or member 'old_nm'
not described in 'ubifs_jnl_rename'
fs/ubifs/journal.c:1221: warning: Function parameter or member
'new_inode' not described in 'ubifs_jnl_rename'
fs/ubifs/journal.c:1221: warning: Function parameter or member 'new_nm'
not described in 'ubifs_jnl_rename'
fs/ubifs/journal.c:1221: warning: Function parameter or member
'whiteout' not described in 'ubifs_jnl_rename'
fs/ubifs/journal.c:1221: warning: Excess function parameter 'old_dentry'
description in 'ubifs_jnl_rename'
fs/ubifs/journal.c:1221: warning: Excess function parameter 'new_dentry'
description in 'ubifs_jnl_rename'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/ubifs/journal.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index 75dab0ae3939..61f72a557655 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -1201,9 +1201,13 @@ int ubifs_jnl_xrename(struct ubifs_info *c, const struct inode *fst_dir,
  * ubifs_jnl_rename - rename a directory entry.
  * @c: UBIFS file-system description object
  * @old_dir: parent inode of directory entry to rename
- * @old_dentry: directory entry to rename
+ * @old_inode: directory entry's inode to rename
+ * @old_nm: name of the old directory entry to rename
  * @new_dir: parent inode of directory entry to rename
- * @new_dentry: new directory entry (or directory entry to replace)
+ * @new_inode: new directory entry's inode (or directory entry's inode to
+ *		replace)
+ * @new_nm: new name of the new directory entry
+ * @whiteout: whiteout inode
  * @sync: non-zero if the write-buffer has to be synchronized
  *
  * This function implements the re-name operation which may involve writing up
-- 
2.20.1.7.g153144c

