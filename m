Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E987C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 May 2022 09:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237918AbiETJ6E (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 May 2022 05:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbiETJ6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 05:58:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C855EDE2
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 02:57:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFB4761C4A
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1CAFC385AA;
        Fri, 20 May 2022 09:57:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="N6SXTpij"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653040675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Za8jSp0yqPB+l+OyGKfHicMuSJ/twvFBa+n/uLcHdb8=;
        b=N6SXTpiji65z9HWsno1ZTPxqeuf1IQrbzM3sKT2DjEyXJZameFL/L56jdkTPB+z/D6grZz
        PJK3j+cScfK8PueDrz08W3RCidb+eFymY1YuWIVETXTledS2YEB+M6nyPAc1sBaB8appFh
        JXB27KsQiyyVYCfuM/AWOpSv2RciQ+Y=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ccf116e5 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 20 May 2022 09:57:55 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>, Jens Axboe <axboe@suse.de>
Subject: [PATCH] splice: allow direct splicing with chardevs
Date:   Fri, 20 May 2022 11:57:47 +0200
Message-Id: <20220520095747.123748-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original direct splicing mechanism from Jens required the input to
be a regular file because it was avoiding the special socket case. It
also recognized blkdevs as being close enough to a regular file. But it
forgot about chardevs, which behave the same way and work fine here.

This commit adds the missing S_ISCHR condition so that chardevs such as
/dev/urandom can be directly spliced without strangely returning
-EINVAL.

Cc: Jens Axboe <axboe@suse.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Fixes: b92ce5589374 ("[PATCH] splice: add direct fd <-> fd splicing support")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 fs/splice.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/splice.c b/fs/splice.c
index 047b79db8eb5..7e673b1786fb 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -824,7 +824,7 @@ ssize_t splice_direct_to_actor(struct file *in, struct splice_desc *sd,
 	 * piped splicing for that!
 	 */
 	i_mode = file_inode(in)->i_mode;
-	if (unlikely(!S_ISREG(i_mode) && !S_ISBLK(i_mode)))
+	if (unlikely(!S_ISREG(i_mode) && !S_ISBLK(i_mode) && !S_ISCHR(i_mode)))
 		return -EINVAL;
 
 	/*
-- 
2.35.1

