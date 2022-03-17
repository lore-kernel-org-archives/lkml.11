Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA0BC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Mar 2022 08:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiCQIew (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Mar 2022 04:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbiCQIet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 04:34:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4435A2BD1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 01:33:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBB0DB81E2C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 08:33:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A59C340E9;
        Thu, 17 Mar 2022 08:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647506011;
        bh=q7Vevl95s1m0U8KAngYN2oMf3t0AsinbsCz5Gz67tfM=;
        h=From:To:Cc:Subject:Date:From;
        b=dZOX+BgtO8hmugGyMCIwQ8eHH4s9gxoQKH1210k5D1gxsPWWnL+3TokaTspzErZ1F
         d0W/HJcjGWif2cbZCwbPl7TFGJBVj/n+b7hCcE36aAYvRPBzJ+/R4bFC+7EQuq0en4
         bwgL+GIzDZwaIvaCBT1zkO+RsdqzLiEKWVPAueEgiSyIDwf0uMEnUoJ9h+sSrOxkYB
         DeeYAKZrHvGXDZbVPrcIy6ufvbI9wE73OS6YKrXg0i9VumW4WobzD7mI25dckiYaUV
         22vEBgh+nqQfj5i/3fWPn2PIypTwXvcPWz9yaZwG1/B8Z4sMPJYmlss9tAmxs2Q3f3
         ZRk6THfWfRF5g==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        Chao Yu <chao.yu@oppo.com>
Subject: [PATCH] f2fs: initialize sbi->gc_mode explicitly
Date:   Thu, 17 Mar 2022 16:33:15 +0800
Message-Id: <20220317083315.25974-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It needs to initialized sbi->gc_mode to GC_NORMAL explicitly.

Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
 fs/f2fs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1207402f7683..08f384b0bd0d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3590,6 +3590,7 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	F2FS_NODE_INO(sbi) = le32_to_cpu(raw_super->node_ino);
 	F2FS_META_INO(sbi) = le32_to_cpu(raw_super->meta_ino);
 	sbi->cur_victim_sec = NULL_SECNO;
+	sbi->gc_mode = GC_NORMAL;
 	sbi->next_victim_seg[BG_GC] = NULL_SEGNO;
 	sbi->next_victim_seg[FG_GC] = NULL_SEGNO;
 	sbi->max_victim_search = DEF_MAX_VICTIM_SEARCH;
-- 
2.32.0

