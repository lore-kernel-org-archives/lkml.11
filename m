Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D5DC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Apr 2022 01:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377548AbiDVB7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Apr 2022 21:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbiDVB7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 21:59:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E57A3C4B3;
        Thu, 21 Apr 2022 18:56:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CE88B821CA;
        Fri, 22 Apr 2022 01:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F9EC385A5;
        Fri, 22 Apr 2022 01:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650592585;
        bh=CzcOPGlCV2xBPZx/jKlTI8M8Y1NunJ0Bj92iUue9INk=;
        h=From:To:Cc:Subject:Date:From;
        b=iiLN8BDg66zTXKmHVej8yVayRizhGuBO6B+N2pie/4oFdO7UER4X0grM5jKZfUd5X
         +l0pfAj72kDnySTte91S4LoxcsVEjE68ufCnw7zdwmBU5yMniRL/NKJEdiQAUPPLXZ
         k8sdEWmmwA00Jc9SQa/QIWcGgucBqOF5oDVB5KKU2nM1GS0nSvIw/vegRomfXUuHfy
         bqgaR4JGg1AavxejnRftYJp/6+mxq+KuomAQi1Az1kNY7WLhHn61GrJm3jApHLyvB8
         cvR4UtgHXunncIwzmHJdcnjh7xB8q+tXreEONhBmKJplF6tUtCHvWNEFKG9xD75BdB
         R42WeyOzze27A==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, stable@vger.kernel.org
Subject: [PATCH] f2fs: should not truncate blocks during roll-forward recovery
Date:   Thu, 21 Apr 2022 18:56:24 -0700
Message-Id: <20220422015624.3521607-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the file preallocated blocks and fsync'ed, we should not truncate them during
roll-forward recovery which will recover i_size correctly back.

Fixes: d4dd19ec1ea0 ("f2fs: do not expose unwritten blocks to user by DIO")
Cc: <stable@vger.kernel.org> # 5.17+
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 71f232dcf3c2..83639238a1fe 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -550,7 +550,8 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 	}
 	f2fs_set_inode_flags(inode);
 
-	if (file_should_truncate(inode)) {
+	if (file_should_truncate(inode) &&
+			!is_sbi_flag_set(sbi, SBI_POR_DOING)) {
 		ret = f2fs_truncate(inode);
 		if (ret)
 			goto bad_inode;
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

