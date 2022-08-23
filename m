Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9723C32772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 09:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242675AbiHWJwO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 05:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347526AbiHWJum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 05:50:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBE99D8D7;
        Tue, 23 Aug 2022 01:45:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEA316156B;
        Tue, 23 Aug 2022 08:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D34C433D6;
        Tue, 23 Aug 2022 08:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661244302;
        bh=YlTI9DmHwU0RitNQw6RsPnRquoOs7ihx7xRrzv0p7Qc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v9j9pYmP9Rawba+ucIGpLFnVqhQv6VuEUDZjrXP80Msa+ChfWBg4pUOyqReRd0GIq
         /32LquGnbsOd5yWT6WT/gLbwnPRtm114crVrWA3wiZRAJ1ujo1ogY1KmtH+JyOGNU8
         eQZfckoPyH51KCfzUL2qY+pSumQ+3MZ109cARmVg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li Lingfeng <lilingfeng3@huawei.com>,
        Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 116/229] ext4: recover csum seed of tmp_inode after migrating to extents
Date:   Tue, 23 Aug 2022 10:24:37 +0200
Message-Id: <20220823080057.826514577@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080053.202747790@linuxfoundation.org>
References: <20220823080053.202747790@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Lingfeng <lilingfeng3@huawei.com>

[ Upstream commit 07ea7a617d6b278fb7acedb5cbe1a81ce2de7d0c ]

When migrating to extents, the checksum seed of temporary inode
need to be replaced by inode's, otherwise the inode checksums
will be incorrect when swapping the inodes data.

However, the temporary inode can not match it's checksum to
itself since it has lost it's own checksum seed.

mkfs.ext4 -F /dev/sdc
mount /dev/sdc /mnt/sdc
xfs_io -fc "pwrite 4k 4k" -c "fsync" /mnt/sdc/testfile
chattr -e /mnt/sdc/testfile
chattr +e /mnt/sdc/testfile
umount /dev/sdc
fsck -fn /dev/sdc

========
...
Pass 1: Checking inodes, blocks, and sizes
Inode 13 passes checks, but checksum does not match inode.  Fix? no
...
========

The fix is simple, save the checksum seed of temporary inode, and
recover it after migrating to extents.

Fixes: e81c9302a6c3 ("ext4: set csum seed in tmp inode while migrating to extents")
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20220617062515.2113438-1-lilingfeng3@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/migrate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
index b6e9d56696ef..5849bf2c41ad 100644
--- a/fs/ext4/migrate.c
+++ b/fs/ext4/migrate.c
@@ -442,7 +442,7 @@ int ext4_ext_migrate(struct inode *inode)
 	struct inode *tmp_inode = NULL;
 	struct migrate_struct lb;
 	unsigned long max_entries;
-	__u32 goal;
+	__u32 goal, tmp_csum_seed;
 	uid_t owner[2];
 
 	/*
@@ -490,6 +490,7 @@ int ext4_ext_migrate(struct inode *inode)
 	 * the migration.
 	 */
 	ei = EXT4_I(inode);
+	tmp_csum_seed = EXT4_I(tmp_inode)->i_csum_seed;
 	EXT4_I(tmp_inode)->i_csum_seed = ei->i_csum_seed;
 	i_size_write(tmp_inode, i_size_read(inode));
 	/*
@@ -600,6 +601,7 @@ int ext4_ext_migrate(struct inode *inode)
 	 * the inode is not visible to user space.
 	 */
 	tmp_inode->i_blocks = 0;
+	EXT4_I(tmp_inode)->i_csum_seed = tmp_csum_seed;
 
 	/* Reset the extent details */
 	ext4_ext_tree_init(handle, tmp_inode);
-- 
2.35.1



