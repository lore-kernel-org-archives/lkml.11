Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEE7C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 20 May 2022 04:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238119AbiETEKe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 May 2022 00:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiETEK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 00:10:29 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E0514AA4A
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 21:10:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VDoVd5w_1653019820;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VDoVd5w_1653019820)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 20 May 2022 12:10:25 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     hch@infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 1/2] freevxfs: fix kernel-doc warning in vxfs_super.c
Date:   Fri, 20 May 2022 12:10:15 +0800
Message-Id: <20220520041016.80354-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following W=1 kernel warnings:

fs/freevxfs/vxfs_super.c:184: warning: expecting prototype for
vxfs_read_super(). Prototype was for vxfs_fill_super() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/freevxfs/vxfs_super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/freevxfs/vxfs_super.c b/fs/freevxfs/vxfs_super.c
index c3b82f716f9a..310d73e254df 100644
--- a/fs/freevxfs/vxfs_super.c
+++ b/fs/freevxfs/vxfs_super.c
@@ -165,7 +165,7 @@ static int vxfs_try_sb_magic(struct super_block *sbp, int silent,
 }
 
 /**
- * vxfs_read_super - read superblock into memory and initialize filesystem
+ * vxfs_fill_super - read superblock into memory and initialize filesystem
  * @sbp:		VFS superblock (to fill)
  * @dp:			fs private mount data
  * @silent:		do not complain loudly when sth is wrong
-- 
2.20.1.7.g153144c

