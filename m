Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF17C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 11:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358745AbiBHLbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 06:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356582AbiBHKwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:52:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADBEC03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 02:52:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46E1461538
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 10:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64169C004E1;
        Tue,  8 Feb 2022 10:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644317523;
        bh=LOsnrHhtZ02v5wdKdIpP4CXhD4olCp1tiNeKEg5L2bY=;
        h=From:To:Cc:Subject:Date:From;
        b=ZGsO2CWjFjH85KytSFltbGoyHDgWbO/Dc/g9b7Td1eDR+IV2ALxBKXIFYLDwZK1Oj
         cNWK2Xn/hl9E9p/B80AnW7flcfVTu6EU4bLsC+2fnlC/uww4gzRwUADmy44COeqpuY
         dhF1evwfHhsJcpvWXM/1UzZ9MKMmNl3/g7dDYR+N/0GP9NPCCc7VmaYBFJlAMvwKUE
         HeIUUW7Dl4xWGT7OgYqZZNBKTZX/B+7ZezvtKLJv+1px5zczdsr8BAOZsSbw3kYlPc
         JCx0o4fb+u0TjaNH51THr+tkcq2ozqk4LN2Cj3vuuNTmb/7p212imlyhO6r5ZBtq7g
         6fDvlM/G1q22w==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH RFC] f2fs: sync node page without cp_rwsem during block_operations()
Date:   Tue,  8 Feb 2022 18:51:56 +0800
Message-Id: <20220208105156.3810115-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's avoid holding cp_rwsem write lock during f2fs_sync_node_pages()
in block_operations(), then cp_rwsem write lock's coverage in checkpoint
can be shrunk, then it expects there will be more opportunity that
foreground operator can grab cp_rwsem read lock.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/checkpoint.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index f7cb4277de70..7596faa0be45 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1190,6 +1190,8 @@ static int block_operations(struct f2fs_sb_info *sbi)
 		.for_reclaim = 0,
 	};
 	int err = 0, cnt = 0;
+	bool sync_lockless = true;
+	unsigned int retry_cnt = 3;
 
 	/*
 	 * Let's flush inline_data in dirty node pages.
@@ -1249,15 +1251,25 @@ static int block_operations(struct f2fs_sb_info *sbi)
 
 	if (get_pages(sbi, F2FS_DIRTY_NODES)) {
 		f2fs_up_write(&sbi->node_write);
+		if (!retry_cnt--)
+			sync_lockless = false;
+		if (sync_lockless) {
+			f2fs_up_write(&sbi->node_change);
+			f2fs_unlock_all(sbi);
+		}
 		atomic_inc(&sbi->wb_sync_req[NODE]);
 		err = f2fs_sync_node_pages(sbi, &wbc, false, FS_CP_NODE_IO);
 		atomic_dec(&sbi->wb_sync_req[NODE]);
 		if (err) {
-			f2fs_up_write(&sbi->node_change);
-			f2fs_unlock_all(sbi);
+			if (!sync_lockless) {
+				f2fs_up_write(&sbi->node_change);
+				f2fs_unlock_all(sbi);
+			}
 			return err;
 		}
 		cond_resched();
+		if (sync_lockless)
+			goto retry_flush_quotas;
 		goto retry_flush_nodes;
 	}
 
-- 
2.25.1

