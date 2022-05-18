Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DACEC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 May 2022 17:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241227AbiERRzy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 May 2022 13:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241173AbiERRzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 13:55:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB79B16
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 10:55:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 324A66181A
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 17:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB88C385A5;
        Wed, 18 May 2022 17:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652896549;
        bh=HBYXEZNCYGiDeETVCOvO+Gk69oq/4MZUE9rOXOS97fk=;
        h=From:To:Cc:Subject:Date:From;
        b=ZqmcwOBnYweBt/zdVLG+N3QXD/Fj4An0JfumB8lIO7aj4FlQyywbVfZrAngMtHLsH
         4nI50PPFXnxPGqmcKBYOJ7aM9nUuYSmAh4Arq3cq+JzNOJ0qxf7oJWKS9v6d7fcRm3
         WzB/Pqy6AmNOKUUMigcWrh5wGehwNKzF7o3+XD+jGswLhWbOcJXby/HIGybirIHdtQ
         5Bvu+QsFWqCZuuHXmOab137O1yJwXLY+PhJCwrsUXeoQ0WlXjwewdNYesXbfLnuEVN
         yKn8/969Md7M3Ew45hAfKvZXkgiod+9DofJ9ANyHVPjhpjoJmrtTjkb3zhuffxfVZr
         qq3ywZcGNKHoQ==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: decompress data without workqueue
Date:   Wed, 18 May 2022 10:55:47 -0700
Message-Id: <20220518175547.3284875-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's decompress data under the same context to avoid workqueue delay.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 54a7a8ad994d..37aa7ac5d463 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -285,10 +285,12 @@ static void f2fs_read_end_io(struct bio *bio)
 		return;
 	}
 
-	if (ctx && (ctx->enabled_steps & (STEP_DECRYPT | STEP_DECOMPRESS))) {
+	if (ctx && (ctx->enabled_steps & STEP_DECRYPT)) {
 		INIT_WORK(&ctx->work, f2fs_post_read_work);
 		queue_work(ctx->sbi->post_read_wq, &ctx->work);
 	} else {
+		if (ctx && (ctx->enabled_steps & STEP_DECOMPRESS))
+			f2fs_handle_step_decompress(ctx);
 		f2fs_verify_and_finish_bio(bio);
 	}
 }
-- 
2.36.1.124.g0e6072fb45-goog

