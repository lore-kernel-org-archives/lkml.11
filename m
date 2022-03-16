Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE70C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Mar 2022 10:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238367AbiCPKV2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Mar 2022 06:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbiCPKVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 06:21:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0015A5BD1A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 03:20:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD783B81A34
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 10:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5630C340E9;
        Wed, 16 Mar 2022 10:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647426009;
        bh=/O1Nhrg2OVtXL/SSKJRs6a8jMBlhRF0EgxSsjcaNu0Y=;
        h=From:To:Cc:Subject:Date:From;
        b=S+isYU66SstsukJ6kfyz5DNuehqto6YJ82XjSjYa1hOR1/vGmQhj7T7t0+HHCzKv9
         4anjJIqogV0DqfF/UCRNamOcXgywYRWuvWy/6mGjzbYK2SpkwAIyiLB3exSIPVzhz+
         tR0rgegTTn4RtH6YaY8dySNLPMd408f55Yj45gujmlvVBZw/m+HHSeYzLCCH3yFh5p
         wfBGowmca9mL8au3jSn8J76ES2j6corrdOoFaCLMDnhictoT3RHtf1xkh0tfw6lY8q
         X1jlPn6HAj37pJmoPrMvxImMpc3TMC+RbFkr9d83PxNsQfKjUe/symF5+mzYwj147J
         PwnS2/Tmnxscg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        Chao Yu <chao.yu@oppo.com>
Subject: [PATCH] f2fs: compress: fix to print raw data size in error path of lz4 decompression
Date:   Wed, 16 Mar 2022 18:20:00 +0800
Message-Id: <20220316102000.3727130-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In lz4_decompress_pages(), if size of decompressed data is not equal to
expected one, we should print the size rather than size of target buffer
for decompressed data, fix it.

Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
 fs/f2fs/compress.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 67bac2792e57..11e99bf6286c 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -314,10 +314,9 @@ static int lz4_decompress_pages(struct decompress_io_ctx *dic)
 	}
 
 	if (ret != PAGE_SIZE << dic->log_cluster_size) {
-		printk_ratelimited("%sF2FS-fs (%s): lz4 invalid rlen:%zu, "
+		printk_ratelimited("%sF2FS-fs (%s): lz4 invalid ret:%d, "
 					"expected:%lu\n", KERN_ERR,
-					F2FS_I_SB(dic->inode)->sb->s_id,
-					dic->rlen,
+					F2FS_I_SB(dic->inode)->sb->s_id, ret,
 					PAGE_SIZE << dic->log_cluster_size);
 		return -EIO;
 	}
-- 
2.25.1

