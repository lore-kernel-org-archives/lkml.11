Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353B9C4332F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 May 2022 13:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244600AbiEJNvA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 May 2022 09:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243437AbiEJNa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 09:30:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DBD2C7A79
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 06:21:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92242B81DA5
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 13:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDAD3C385CB
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 13:21:34 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="dcXNmMLx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652188893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=h9LpMP7cxeGbwoT+ipVaVjALSaR2sJ6nkC0H4Oa3Mw0=;
        b=dcXNmMLxnhTLkfi2DTDokR6/h/sjWXYVnDOD4siwdvURNrzhdQRgFVXM8qTWJqICLDev5K
        n985MjDsKxaUkK5oaz6Lclymodqq8TL0M7uZdo7WwD57FsU6G5jy+CGuf9EsCrZNY0LCAX
        ahXFYvHqHz4S4bSX5SFFyQObhZhI8tM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0bd28c5a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 10 May 2022 13:21:32 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] random: use proper jiffies comparison macro
Date:   Tue, 10 May 2022 15:21:20 +0200
Message-Id: <20220510132120.102800-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This expands to exactly the same code that it replaces, but makes things
consistent by using the same macro for jiffy comparisons throughout.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 2f8559122dfa..b1ef334ed263 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -325,7 +325,7 @@ static bool crng_has_old_seed(void)
 			interval = max_t(unsigned int, CRNG_RESEED_START_INTERVAL,
 					 (unsigned int)uptime / 2 * HZ);
 	}
-	return time_after(jiffies, READ_ONCE(base_crng.birth) + interval);
+	return time_is_before_jiffies(READ_ONCE(base_crng.birth) + interval);
 }
 
 /*
-- 
2.35.1

