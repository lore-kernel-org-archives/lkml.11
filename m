Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6826C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 21 May 2022 11:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237907AbiEULPb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 May 2022 07:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243920AbiEULMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 07:12:15 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05272E9F7;
        Sat, 21 May 2022 04:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZXvAiOORZJk+2KUX1I0y/bK94Dd0mtx55RA5nLehi6Y=;
  b=d5SlB1CMG3rFu+TRx3LRbslPbyGsXY+vCdqN9Xw+RNyTDuI0/elEifxF
   FWyfb684wL9vIdBbqlBsoqwKGnA0AlcnAlk3HLKCzlUqJzyyu/O7cJRLD
   31h2WRyaftNriGxA+tVO+Q6WMZXYvMK6d9MIhiHpo76t8r4rR6FJu+mse
   g=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727927"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:11:57 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     kernel-janitors@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] writeback: fix typo in comment
Date:   Sat, 21 May 2022 13:10:42 +0200
Message-Id: <20220521111145.81697-32-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spelling mistake (triple letters) in comment.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 fs/fs-writeback.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index a1074a26e784..a21d8f1a56d1 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -738,7 +738,7 @@ EXPORT_SYMBOL_GPL(wbc_attach_and_unlock_inode);
  * incorrectly attributed).
  *
  * To resolve this issue, cgroup writeback detects the majority dirtier of
- * an inode and transfers the ownership to it.  To avoid unnnecessary
+ * an inode and transfers the ownership to it.  To avoid unnecessary
  * oscillation, the detection mechanism keeps track of history and gives
  * out the switch verdict only if the foreign usage pattern is stable over
  * a certain amount of time and/or writeback attempts.

