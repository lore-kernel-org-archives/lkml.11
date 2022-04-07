Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2844C4332F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Apr 2022 01:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbiDGBNZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 21:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbiDGBM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 21:12:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857F6181B29;
        Wed,  6 Apr 2022 18:10:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C706B82695;
        Thu,  7 Apr 2022 01:10:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64874C385AA;
        Thu,  7 Apr 2022 01:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649293853;
        bh=RuSQpMbX+u7nDjOX7UuFFC9DdR5u87Bu5cQd4/zrhrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MxGzCzQ9w/w41YSW/ZMLds3KRjzEgLahAWy6vuWDTZYzhhHsecKFvF6tp6UTEIrrS
         BQ7klPG2xPW2EoEF0/4eD42ZfxUx3RtH+XiNUm4tjj2ZISRySKhrVbymuBtXX7COmQ
         DpTayzrZJq3sZZT4y5Z/dKqg46zkI0jc/1N0+StoSnwnU5URPiRb+U2MZhoJvmYadV
         VfzkuzLaZMCViSCUYPzrOVbvhWCgpQ6fpRuhRLVOXvwIZI9IrCB0V32aTHqbzhQML+
         m2RI1gvl0IhWL9/v7vo2OK9tXHqDlFtK6l6icJVrGhnN1Rea26G/B7kowqtTR4J5zJ
         6aWAghzWIxd/Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <sashal@kernel.org>, rpeterso@redhat.com,
        cluster-devel@redhat.com
Subject: [PATCH AUTOSEL 5.17 12/31] gfs2: Disable page faults during lockless buffered reads
Date:   Wed,  6 Apr 2022 21:10:10 -0400
Message-Id: <20220407011029.113321-12-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407011029.113321-1-sashal@kernel.org>
References: <20220407011029.113321-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit 52f3f033a5dbd023307520af1ff551cadfd7f037 ]

During lockless buffered reads, filemap_read() holds page cache page
references while trying to copy data to the user-space buffer.  The
calling process isn't holding the inode glock, but the page references
it holds prevent those pages from being removed from the page cache, and
that prevents the underlying inode glock from being moved to another
node.  Thus, we can end up in the same kinds of distributed deadlock
situations as with normal (non-lockless) buffered reads.

Fix that by disabling page faults during lockless reads as well.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 8c39a8571b1f..79741d05e562 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -956,14 +956,16 @@ static ssize_t gfs2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			return ret;
 		iocb->ki_flags &= ~IOCB_DIRECT;
 	}
+	pagefault_disable();
 	iocb->ki_flags |= IOCB_NOIO;
 	ret = generic_file_read_iter(iocb, to);
 	iocb->ki_flags &= ~IOCB_NOIO;
+	pagefault_enable();
 	if (ret >= 0) {
 		if (!iov_iter_count(to))
 			return ret;
 		written = ret;
-	} else {
+	} else if (ret != -EFAULT) {
 		if (ret != -EAGAIN)
 			return ret;
 		if (iocb->ki_flags & IOCB_NOWAIT)
-- 
2.35.1

