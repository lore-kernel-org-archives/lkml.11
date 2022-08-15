Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A332C00140
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 23:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345216AbiHOX0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 19:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353043AbiHOXVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 19:21:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63391B8A4A;
        Mon, 15 Aug 2022 13:04:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E206B80EA8;
        Mon, 15 Aug 2022 20:04:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B24DC433C1;
        Mon, 15 Aug 2022 20:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660593896;
        bh=9060AYX/nv6AX4P/LEhYbVTwMkxdy/Fg7Y502/K8E4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u8wPh13OEvMM9/ma9NloniTOEdzVM3+Tc+M6tZT9P5j0KPqJcget8dYCIIA8TTS+j
         iRPf9CgcuDBVvlxKqz15YhfcC21TyBbDnWt4SetIZlqCYSpuskSWjpNJzRzR7uVPCR
         Xqi+O/1AODr7CK6WfrG7dFg7RMs5Fd+0+9DsuJ74=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.18 1025/1095] btrfs: zoned: introduce btrfs_zoned_bg_is_full
Date:   Mon, 15 Aug 2022 20:07:04 +0200
Message-Id: <20220815180511.473182359@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815180429.240518113@linuxfoundation.org>
References: <20220815180429.240518113@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naohiro Aota <naohiro.aota@wdc.com>

[ Upstream commit 1bfd476754a2d63f899ef9c3e253b17766b8fb73 ]

Introduce a wrapper to check if all the space in a block group is
allocated or not.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent-tree.c | 3 +--
 fs/btrfs/zoned.c       | 2 +-
 fs/btrfs/zoned.h       | 6 ++++++
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index bdebd77f31b4..56185541e188 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3803,8 +3803,7 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 
 	/* Check RO and no space case before trying to activate it */
 	spin_lock(&block_group->lock);
-	if (block_group->ro ||
-	    block_group->alloc_offset == block_group->zone_capacity) {
+	if (block_group->ro || btrfs_zoned_bg_is_full(block_group)) {
 		ret = 1;
 		/*
 		 * May need to clear fs_info->{treelog,data_reloc}_bg.
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 0a6a3d6f5af7..170681797283 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1859,7 +1859,7 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 	}
 
 	/* No space left */
-	if (block_group->alloc_offset == block_group->zone_capacity) {
+	if (btrfs_zoned_bg_is_full(block_group)) {
 		ret = false;
 		goto out_unlock;
 	}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 199b69670fa2..0740458894ac 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -384,4 +384,10 @@ static inline void btrfs_zoned_data_reloc_unlock(struct btrfs_inode *inode)
 		mutex_unlock(&root->fs_info->zoned_data_reloc_io_lock);
 }
 
+static inline bool btrfs_zoned_bg_is_full(const struct btrfs_block_group *bg)
+{
+	ASSERT(btrfs_is_zoned(bg->fs_info));
+	return (bg->alloc_offset == bg->zone_capacity);
+}
+
 #endif
-- 
2.35.1



