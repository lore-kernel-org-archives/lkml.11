Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDED4C433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 May 2022 00:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbiEEAfB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 May 2022 20:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbiEEAe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 20:34:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE7B4BB87
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 17:31:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1410961D42
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 00:31:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85A7C385A5;
        Thu,  5 May 2022 00:31:19 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DxnB+sEE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651710678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Dcz9MFpNHCFKx2TGJDNIUqllRgwjj7RyATuty7yE2nQ=;
        b=DxnB+sEEzyL+6svIUzSDufMh/e3wx+lQebf9IokfpfK/iDGwIDHWDFvMyHSh+j2kepYwJn
        VRYFyML68HXiIid7/6o7t41zJH0vAB6+4Xz+WQdj2cVbRlsSDYRB1GNfsGS3dDp+UaPWkG
        awhF5yV02bKxT1b5BIuIByjxJbj4TGg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id dda00650 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 5 May 2022 00:31:18 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Stafford Horne <shorne@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] init: call time_init() before rand_initialize()
Date:   Thu,  5 May 2022 02:31:14 +0200
Message-Id: <20220505003114.177552-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently time_init() is called before rand_initialize(), but
rand_initialize() makes use of the timer on various platforms, and
sometimes this timer needs to be initialized by time_init() first. In
order to not return zero, reverse the order of these two calls. The
block doing random initialization was right before time_init() before,
so changing the order shouldn't have any complicated effects.

Cc: Stafford Horne <shorne@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Andrew - this file has no formal maintainer, but you've signed the most
commits, so I'm CC'ing you. This has some interactions with my
random.git tree, so unless there are objections, I'll queue it up there.
-Jason

 init/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index 98182c3c2c4b..e37ec99cf56d 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1035,6 +1035,7 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 	softirq_init();
 	timekeeping_init();
 	kfence_init();
+	time_init();
 
 	/*
 	 * For best initial stack canary entropy, prepare it after:
@@ -1049,7 +1050,6 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 	add_device_randomness(command_line, strlen(command_line));
 	boot_init_stack_canary();
 
-	time_init();
 	perf_event_init();
 	profile_init();
 	call_function_init();
-- 
2.35.1

