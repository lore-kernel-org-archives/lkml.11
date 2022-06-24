Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2E6C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jun 2022 12:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbiFXMtK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jun 2022 08:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiFXMtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 08:49:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739D34BFEE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 05:49:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2CC5CB8269B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 12:49:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2D3C34114;
        Fri, 24 Jun 2022 12:49:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="psUq9EWP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656074943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vjMyEl75dmr8eRflVwcTt7vhBdHLHVoBDCUnFGTvdQc=;
        b=psUq9EWPmryrZ/JB9RU6hYTkYW5zm2raiYOyC9JcMZniEgiLsSHhZmPyjZrRxE3/4tm3Te
        pXNFU0Lay29HHtiKJi3iw2PJ9WiYZxBhqO4C5shson+YRJsjIfOI962uoTLYs8pYkXNtRe
        RLOWdcFxZP9wu2pRHOIRBN7dVgoXrCs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3a9f743b (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 24 Jun 2022 12:49:03 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH RESEND for-al-viro] splice: allow direct splicing with chardevs
Date:   Fri, 24 Jun 2022 14:48:52 +0200
Message-Id: <20220624124852.1495876-1-Jason@zx2c4.com>
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

Fixes: b92ce5589374 ("[PATCH] splice: add direct fd <-> fd splicing support")
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Resending this with Jens' reviewed-by attached (he wrote the original
code this patch modifies). The prior submission seems to have been
buried/forgotten. This is presumably for Al's tree, though if somebody
else wants to take it, I'd be happy to get it in anywhere. The prior
forgotten thread is here for reference:
https://lore.kernel.org/lkml/20220520095747.123748-1-Jason@zx2c4.com/T/#u

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

