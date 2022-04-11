Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C011DC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Apr 2022 10:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344980AbiDKKFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 06:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238825AbiDKKFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:05:09 -0400
Received: from fuzzserver.tsinghua.edu.cn (unknown [166.111.139.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C7F40E73
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:02:55 -0700 (PDT)
Received: by fuzzserver.tsinghua.edu.cn (Postfix, from userid 1000)
        id 1E144F42C77; Mon, 11 Apr 2022 18:02:54 +0800 (CST)
From:   Zixuan Fu <r33s3n6@gmail.com>
To:     shaggy@kernel.org
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com, Zixuan Fu <r33s3n6@gmail.com>,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: [PATCH] fs: jfs: fix possible NULL pointer dereference in dbFree()
Date:   Mon, 11 Apr 2022 18:02:45 +0800
Message-Id: <20220411100245.685611-1-r33s3n6@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In our fault-injection testing, the variable "nblocks" in dbFree() can be
zero when kmalloc_array() fails in dtSearch(). In this case, the variable
 "mp" in dbFree() would be NULL and then it is dereferenced in 
"write_metapage(mp)".

The failure log is listed as follows:

[   13.824137] BUG: kernel NULL pointer dereference, address: 0000000000000020
...
[   13.827416] RIP: 0010:dbFree+0x5f7/0x910 [jfs]
[   13.834341] Call Trace:
[   13.834540]  <TASK>
[   13.834713]  txFreeMap+0x7b4/0xb10 [jfs]
[   13.835038]  txUpdateMap+0x311/0x650 [jfs]
[   13.835375]  jfs_lazycommit+0x5f2/0xc70 [jfs]
[   13.835726]  ? sched_dynamic_update+0x1b0/0x1b0
[   13.836092]  kthread+0x3c2/0x4a0
[   13.836355]  ? txLockFree+0x160/0x160 [jfs]
[   13.836763]  ? kthread_unuse_mm+0x160/0x160
[   13.837106]  ret_from_fork+0x1f/0x30
[   13.837402]  </TASK>
...

This patch adds a NULL check of "mp" before "write_metapage(mp)" is called.

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Zixuan Fu <r33s3n6@gmail.com>
---
 fs/jfs/jfs_dmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index d8502f4989d9..e75f31b81d63 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -385,7 +385,8 @@ int dbFree(struct inode *ip, s64 blkno, s64 nblocks)
 	}
 
 	/* write the last buffer. */
-	write_metapage(mp);
+	if (mp)
+		write_metapage(mp);
 
 	IREAD_UNLOCK(ipbmap);
 
-- 
2.25.1

