Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0B7C28D13
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Aug 2022 23:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244126AbiHSXPn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Aug 2022 19:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244032AbiHSXPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 19:15:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DE0E3963
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:15:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 220436186B
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 23:15:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790F6C433B5;
        Fri, 19 Aug 2022 23:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660950918;
        bh=hsH/o/XnOoVziPjmhg1KsTFQFW0lzFCZrIpev5lAsvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q8IGFuqf4kKfjLuk+gnmnFzMccXzWYDvzPwg6rpVCNI9Br8FzWbbwKucztcrJS98W
         2ycsDmO+/bmF9bdR7uGyYcgfOWBzpI4C127aUUaD1Dl2nGdFosQGqCy/AUNa8BtmrF
         UHJT06DJiSOk2ZQ54Z8G6xJsv9+JCombZoftfhAMmZqDbsAe8avKCCQIYBGTU3h+My
         l+53bQFMcxxUMK6bVhUb55sH6tdScxOvB+D7W0yeTZGVx20KmPzHaGYPYXqRoEN8Z8
         ZXMFN18qOc0wfiDFBO+RXZcakTSQ7+jhCbDqUC9GzsOu5kxtJfSqVh2XixcWDvND13
         zUSj0Xtl7tIWA==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: complete checkpoints during remount
Date:   Fri, 19 Aug 2022 16:15:14 -0700
Message-Id: <20220819231514.3609958-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
In-Reply-To: <20220819231514.3609958-1-jaegeuk@kernel.org>
References: <20220819231514.3609958-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise, pending checkpoints can contribute a race condition to give a
quota warning.

- Thread                      - checkpoint thread
                              add checkpoints to the list
do_remount()
 down_write(&sb->s_umount);
 f2fs_remount()
                              block_operations()
                               down_read_trylock(&sb->s_umount) = 0
 up_write(&sb->s_umount);
                               f2fs_quota_sync()
                                dquot_writeback_dquots()
                                 WARN_ON_ONCE(!rwsem_is_locked(&sb->s_umount));

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 48ac3de4a533..88879c483805 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2349,6 +2349,9 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		f2fs_stop_ckpt_thread(sbi);
 		need_restart_ckpt = true;
 	} else {
+		/* flush if the prevous checkpoint, if exists. */
+		f2fs_flush_ckpt_thread(sbi);
+
 		err = f2fs_start_ckpt_thread(sbi);
 		if (err) {
 			f2fs_err(sbi,
-- 
2.37.1.595.g718a3a8f04-goog

