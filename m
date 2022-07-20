Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB26FC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jul 2022 01:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241591AbiGTBUU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jul 2022 21:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241703AbiGTBT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 21:19:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D18F691E6;
        Tue, 19 Jul 2022 18:15:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AD01616F6;
        Wed, 20 Jul 2022 01:15:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F86C36AE3;
        Wed, 20 Jul 2022 01:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658279738;
        bh=akwrV7qxX0ywEQUTgrCf6sEdocT6IoiF+KtS6DPvags=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jXQKxeBRYxUaf+OAzHdlFWr8nrf3Z+GnsWENAOCe0PxHcjMXviHkCY8JJ1TZsDm+L
         0dCCRSAT2pM7TgCWeVgc6O4Pwz67apm05hSXiVodZ9WdMonDuzwimPJn35DuYUUujY
         aE2MS83qrbs08vfqhrWKojEDRiovkrlltkZdy2vzmYnYlSBIerf2XubqrsODuNJ1o8
         /MW6X1UbXen1yDJjCdMeorrOXuFDegxBc5lspEiZA3EMtVnLLxmJG2Vr4zkqN2dnFI
         pJEDw//ZWsMQ3Yh/6Az7fvxnEKMQoGQE/GIzVUEtW2PvKxRtCdgSqWf/B3z36YcsAd
         RoXwl/CmxLXww==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Tommy Pettersson <ptp@lysator.liu.se>,
        Ciprian Craciun <ciprian.craciun@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-nilfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 27/42] nilfs2: fix incorrect masking of permission flags for symlinks
Date:   Tue, 19 Jul 2022 21:13:35 -0400
Message-Id: <20220720011350.1024134-27-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220720011350.1024134-1-sashal@kernel.org>
References: <20220720011350.1024134-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryusuke Konishi <konishi.ryusuke@gmail.com>

[ Upstream commit 5924e6ec1585445f251ea92713eb15beb732622a ]

The permission flags of newly created symlinks are wrongly dropped on
nilfs2 with the current umask value even though symlinks should have 777
(rwxrwxrwx) permissions:

 $ umask
 0022
 $ touch file && ln -s file symlink; ls -l file symlink
 -rw-r--r--. 1 root root 0 Jun 23 16:29 file
 lrwxr-xr-x. 1 root root 4 Jun 23 16:29 symlink -> file

This fixes the bug by inserting a missing check that excludes
symlinks.

Link: https://lkml.kernel.org/r/1655974441-5612-1-git-send-email-konishi.ryusuke@gmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: Tommy Pettersson <ptp@lysator.liu.se>
Reported-by: Ciprian Craciun <ciprian.craciun@gmail.com>
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nilfs2/nilfs.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index 7dcb77d38759..aceb8aadca14 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -198,6 +198,9 @@ static inline int nilfs_acl_chmod(struct inode *inode)
 
 static inline int nilfs_init_acl(struct inode *inode, struct inode *dir)
 {
+	if (S_ISLNK(inode->i_mode))
+		return 0;
+
 	inode->i_mode &= ~current_umask();
 	return 0;
 }
-- 
2.35.1

