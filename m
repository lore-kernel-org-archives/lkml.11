Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D98C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Apr 2022 21:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350161AbiDKVYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 17:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245205AbiDKVYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 17:24:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9812FE5C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:21:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08C1BB815C8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 21:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB4EC385A3;
        Mon, 11 Apr 2022 21:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649712105;
        bh=KMidD+w99wAIiwGhewAltcaEDYwfTgwuH9rySlM7owU=;
        h=From:To:Cc:Subject:Date:From;
        b=lk9VWBICFXjGKTnI22r2ysF69//hMym+TGv5xnjmfAAu0maDn0rXzdvqNYHyGD9Ev
         RiQerYKR1ioyJJQTrAY1ZTljIQNFs1HVWIt3TSrCoF+w+MKXoep1FwVmVhecdcINvc
         10EzMt5SIL63+xwx2HwNTQnREAZSAn3phmSwvqo6cvy67kjQk9S3YKNQzWeaFWau29
         hrvuOxMiQ2hfb6IYm4wfIdvz9iDDCLKkVbQFQLTRsDIcgfKT8HjqL7Z8m2+8A/Jw1V
         Z0Az20XQUp24kxfdlJ3QylhQTbzxq7LCUj4XRjqTSNmQ1p77v9OmpcBhYFDMwBsWCw
         N5TO3c0Q9UPWg==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: fix wrong condition check when failing metapage read
Date:   Mon, 11 Apr 2022 14:21:40 -0700
Message-Id: <20220411212141.1775589-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes wrong initialization.

Fixes: 50c63009f6ab ("f2fs: avoid an infinite loop in f2fs_sync_dirty_inodes")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index aba1b8a1ce66..ed61ac99a3cf 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -98,9 +98,9 @@ static struct page *__get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index,
 	}
 
 	if (unlikely(!PageUptodate(page))) {
-		if (page->index == sbi->metapage_eio_ofs &&
-			sbi->metapage_eio_cnt++ == MAX_RETRY_META_PAGE_EIO) {
-			set_ckpt_flags(sbi, CP_ERROR_FLAG);
+		if (page->index == sbi->metapage_eio_ofs) {
+			if (sbi->metapage_eio_cnt++ == MAX_RETRY_META_PAGE_EIO)
+				set_ckpt_flags(sbi, CP_ERROR_FLAG);
 		} else {
 			sbi->metapage_eio_ofs = page->index;
 			sbi->metapage_eio_cnt = 0;
-- 
2.35.1.1178.g4f1659d476-goog

