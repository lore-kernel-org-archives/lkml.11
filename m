Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4C5C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Apr 2022 00:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiDGAQ2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 20:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiDGAQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 20:16:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFABD13E401
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 17:13:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3762561D68
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 00:13:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9A2C385A1;
        Thu,  7 Apr 2022 00:13:40 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pis/TkKM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1649290419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QRt2RfkSFMgjmCRXHrKL01LfdfRyGFDE5GXEHiiimtM=;
        b=pis/TkKMyLO/wQ0vQ+Nh6ueg1paSbiy3c18R/xPYxIfE2MgWTiq8p5E19rnHKDPeAm1nQf
        +XQJ6lstzQ/XXH0gTqyM9T2OVWGx+ElL3aNzzjldLPW3JKNpyevUsa3Y1OSrtZGd3pRVSN
        3r0UJGYwt1N5UwqL8s9MBDUejpaodzg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d225cd6d (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 7 Apr 2022 00:13:39 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] /dev/[k]mem: make reads and writes interruptible
Date:   Thu,  7 Apr 2022 02:13:27 +0200
Message-Id: <20220407001327.109095-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 8619e5bdeee8 ("/dev/mem: Bail out upon SIGKILL."), /dev/[k]mem became
killable, and that commit noted:

  Theoretically, reading/writing /dev/mem and /dev/kmem can become
  "interruptible". But this patch chose "killable". Future patch will
  make them "interruptible" so that we can revert to "killable" if
  some program regressed.

So now we take the next step in making it "interruptible", by changing
fatal_signal_pending() into signal_pending().

Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index cc296f0823bd..84ca98ed1dad 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -101,7 +101,7 @@ static inline bool should_stop_iteration(void)
 {
 	if (need_resched())
 		cond_resched();
-	return fatal_signal_pending(current);
+	return signal_pending(current);
 }
 
 /*
-- 
2.35.1

