Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7A8C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 19:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiCYTcn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiCYTcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:32:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747492D8131
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:07:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 797F161C2E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 18:18:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9832C2BBE4;
        Fri, 25 Mar 2022 18:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648232333;
        bh=mfPWDhUfqbiFXpRrbs4H8Twleo93bChDmAXbKA3DZOI=;
        h=From:To:Cc:Subject:Date:From;
        b=o798N7GkFeIXVrWFHPZUaHG9jCRy9jMmPaypZ7TWckJNbKHKJvdpAefwEJlRnIRBQ
         ITBtHfs5ESK7wul7zx+DUIF/lpqKYsNODukV5/gruejEdwJVvd2To2a2kyPkInlHfj
         SdAEtxVnnnn9ELw8VCyZNaVjss5B+4Yp74WsOC+KB40iW3k1DcSm9IRHArs41771/3
         9cw5YkPzpKXCu0/8iFlgQLZlAggXEo4VTrcKOjfpjRYv/0ulhS3lKKYF8c7Dmn+w2p
         NsxEmt1rRdGOQshTgTtmTk7tngCAMIWTYVr1yQPZUFyOof/0T4b80t3pINYH5p6K4A
         eg/uP/F/HVn9w==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] f2fs: remove unnecessary f2fs_lock_op in f2fs_new_inode
Date:   Fri, 25 Mar 2022 11:18:50 -0700
Message-Id: <20220325181850.513023-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This can be removed, since f2fs_alloc_nid() actually doesn't require to block
checkpoint and __f2fs_build_free_nids() is covered by nm_i->nat_tree_lock.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/namei.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 5ed79b29999f..816285414564 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -37,13 +37,10 @@ static struct inode *f2fs_new_inode(struct user_namespace *mnt_userns,
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	f2fs_lock_op(sbi);
 	if (!f2fs_alloc_nid(sbi, &ino)) {
-		f2fs_unlock_op(sbi);
 		err = -ENOSPC;
 		goto fail;
 	}
-	f2fs_unlock_op(sbi);
 
 	nid_free = true;
 
-- 
2.35.1.1021.g381101b075-goog

