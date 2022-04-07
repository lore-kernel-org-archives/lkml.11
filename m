Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827A8C433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Apr 2022 19:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiDGTz4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Apr 2022 15:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiDGTzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 15:55:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818E83A1408
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 12:48:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFB66B8297E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 19:35:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FA2C385A4;
        Thu,  7 Apr 2022 19:35:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ic0q0fM+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1649360120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aHqtcyWWhoEYpTWEgHu8OiMUdmD4MGfIhGTDyFsMglk=;
        b=ic0q0fM+4dEuVACDUwWX5U6545jpmLwg7MsGK2G8PRxEw4JWQZ1kaSdXUxkw9Jir6jUX6n
        11hbvY0sRPm7VqjSZEEf8ui7CRcS3sGu/6KcOLPHJhfPNg0Ieg5/qDzrYE63UuUyj5Bd07
        BgADSpdz6iRN9dHjHMmnUSwBdg1m7KI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5110590a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 7 Apr 2022 19:35:20 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Cc:     tytso@mit.edu, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jann Horn <jannh@google.com>
Subject: [PATCH] random: allow partial reads if later user copies fail
Date:   Thu,  7 Apr 2022 21:34:33 +0200
Message-Id: <20220407193433.523299-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than failing entirely if a copy_to_user() fails at some point,
instead we should return a partial read for the amount that succeeded
prior, unless none succeeded at all, in which case we return -EFAULT as
before.

This makes it consistent with other reader interfaces. For example, the
following snippet for /dev/zero outputs "4" followed by "1":

  int fd;
  void *x = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
  assert(x != MAP_FAILED);
  fd = open("/dev/zero", O_RDONLY);
  assert(fd >= 0);
  printf("%zd\n", read(fd, x, 4));
  printf("%zd\n", read(fd, x + 4095, 4));
  close(fd);

This brings that same standard behavior to the various RNG reader
interfaces.

While we're at it, we can streamline the loop logic a little bit.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jann Horn <jannh@google.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index e15063d61460..dd31fddecd17 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -523,8 +523,7 @@ EXPORT_SYMBOL(get_random_bytes);
 
 static ssize_t get_random_bytes_user(void __user *buf, size_t nbytes)
 {
-	ssize_t ret = 0;
-	size_t len;
+	size_t len, ret = 0;
 	u32 chacha_state[CHACHA_STATE_WORDS];
 	u8 output[CHACHA_BLOCK_SIZE];
 
@@ -543,37 +542,37 @@ static ssize_t get_random_bytes_user(void __user *buf, size_t nbytes)
 	 * the user directly.
 	 */
 	if (nbytes <= CHACHA_KEY_SIZE) {
-		ret = copy_to_user(buf, &chacha_state[4], nbytes) ? -EFAULT : nbytes;
+		ret = copy_to_user(buf, &chacha_state[4], nbytes) ? 0 : nbytes;
 		goto out_zero_chacha;
 	}
 
-	do {
+	for (;;) {
 		chacha20_block(chacha_state, output);
 		if (unlikely(chacha_state[12] == 0))
 			++chacha_state[13];
 
 		len = min_t(size_t, nbytes, CHACHA_BLOCK_SIZE);
-		if (copy_to_user(buf, output, len)) {
-			ret = -EFAULT;
+		if (copy_to_user(buf, output, len))
 			break;
-		}
 
-		nbytes -= len;
 		buf += len;
 		ret += len;
+		nbytes -= len;
+		if (!nbytes)
+			break;
 
 		BUILD_BUG_ON(PAGE_SIZE % CHACHA_BLOCK_SIZE != 0);
-		if (!(ret % PAGE_SIZE) && nbytes) {
+		if (!(ret % PAGE_SIZE)) {
 			if (signal_pending(current))
 				break;
 			cond_resched();
 		}
-	} while (nbytes);
+	}
 
 	memzero_explicit(output, sizeof(output));
 out_zero_chacha:
 	memzero_explicit(chacha_state, sizeof(chacha_state));
-	return ret;
+	return ret ? ret : -EFAULT;
 }
 
 /*
-- 
2.35.1

