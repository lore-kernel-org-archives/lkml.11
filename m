Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AB1C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Mar 2022 02:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237673AbiCDCWB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Mar 2022 21:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiCDCWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 21:22:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BD21704FB;
        Thu,  3 Mar 2022 18:21:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A363F61785;
        Fri,  4 Mar 2022 02:21:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0981EC004E1;
        Fri,  4 Mar 2022 02:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646360473;
        bh=NRULPurRWArfqoX9j/cTOT5shOU683ryvGRdna1/ZSA=;
        h=From:To:Cc:Subject:Date:From;
        b=FT3siMyN1CTlDnKcAtbJ5IircAhYNdNQPlfLl7nm3/6lornAnx2vmnpsXm/AFHFCr
         xRUG2/E8cmT2j6Q2GPjs8Gt/Fz27VW5Ry/Rp1+qnCdb5zsbgTYRov8of3Zv9eCKU9S
         T3nreASvLa32hr9jm7Gf1rphLvz1zmLGcV6ZA+jE30e1mmPeH9bzDJqV1AQef6CNL1
         m/odgR9keHkl52e5z9xSc++Cmr+hAokgu8ibtk1/3qUHwt/PrftF2OdPWuY5FSCXng
         5L5CEHuNFNzQPcjTuGeEHbVxXkz22LLNxEVWBKODRaSSM8+7dwa3uwkQE01AufdJF3
         8T8d6XRNP7A5w==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] vfs: do not try to evict inode when super is frozen
Date:   Thu,  3 Mar 2022 18:21:04 -0800
Message-Id: <20220304022104.2525009-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise, we will get a deadlock.

[freeze test]                         shrinkder
freeze_super
 - pwercpu_down_write(SB_FREEZE_FS)
                                       - super_cache_scan
                                         - down_read(&sb->s_umount)
                                           - prune_icache_sb
                                            - dispose_list
                                             - evict
                                              - f2fs_evict_inode
thaw_super
 - down_write(&sb->s_umount);
                                              - __percpu_down_read(SB_FREEZE_FS)

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index 7af820ba5ad5..f7303d91f874 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -79,6 +79,12 @@ static unsigned long super_cache_scan(struct shrinker *shrink,
 	if (!trylock_super(sb))
 		return SHRINK_STOP;
 
+	/* This prevents inode eviction that requires SB_FREEZE_FS. */
+	if (sb->s_writers.frozen == SB_FREEZE_FS) {
+		up_read(&sb->s_umount);
+		return SHRINK_STOP;
+	}
+
 	if (sb->s_op->nr_cached_objects)
 		fs_objects = sb->s_op->nr_cached_objects(sb, sc);
 
-- 
2.35.1.616.g0bdcbb4464-goog

