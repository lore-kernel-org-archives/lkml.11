Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB85CC43334
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jun 2022 10:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376481AbiFPKvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jun 2022 06:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376318AbiFPKvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 06:51:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4120C5DD21;
        Thu, 16 Jun 2022 03:50:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0EEC617B8;
        Thu, 16 Jun 2022 10:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FCDC34114;
        Thu, 16 Jun 2022 10:50:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="dT6p1zSu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1655376655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uTERnYPuwjRZQXfIjr47fU7ZO8ZGzfOVFqYzObg2Ojc=;
        b=dT6p1zSuZ6WeR654dSzP58Y1lm2C2JMXaCeUAlQNMQdOoZ9daxGQdNycF27Pz9K3DJuoj6
        jZX1yZKbSb5NX4i07DfZTt8maM1mCw119b1LNfSwHwpzya2QPNa+ZYgRXytn2sN5DVxaDS
        aC82037FHFaOWq+OOeK9aZe2arBKesc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a1dd5f95 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 16 Jun 2022 10:50:55 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>, stable@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH] random: schedule mix_interrupt_randomness() less often
Date:   Thu, 16 Jun 2022 12:50:52 +0200
Message-Id: <20220616105052.322610-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It used to be that mix_interrupt_randomness() would credit 1 bit each
time it ran, and so add_interrupt_randomness() would schedule mix() to
run every 64 interrupts, a fairly arbitrary number, but nonetheless
considered to be a decent enough conservative estimate.

Since e3e33fc2ea7f ("random: do not use input pool from hard IRQs"),
mix() is now able to credit multiple bits, depending on the number of
calls to add(). This was done for reasons separate from this commit, but
it has the nice side effect of enabling this patch to schedule mix()
less often.

Currently the rules are:
a) Credit 1 bit for every 64 calls to add().
b) Schedule mix() once a second that add() is called.
c) Schedule mix() once every 64 calls to add().

Rules (a) and (c) no longer need to be coupled. It's still important to
have _some_ value in (c), so that we don't "over-saturate" the fast
pool, but the once per second we get from rule (b) is a plenty enough
baseline. So, by increasing the 64 in rule (c) to something larger, we
avoid calling queue_work_on() as frequently during irq storms.

This commit changes that 64 in rule (c) to be 1024, which means we
schedule mix() 16 times less often. And it does *not* need to change the
64 in rule (a).

Fixes: 58340f8e952b ("random: defer fast pool mixing to worker")
Cc: stable@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 655e327d425e..d0e4c89c4fcb 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1009,7 +1009,7 @@ void add_interrupt_randomness(int irq)
 	if (new_count & MIX_INFLIGHT)
 		return;
 
-	if (new_count < 64 && !time_is_before_jiffies(fast_pool->last + HZ))
+	if (new_count < 1024 && !time_is_before_jiffies(fast_pool->last + HZ))
 		return;
 
 	if (unlikely(!fast_pool->mix.func))
-- 
2.35.1

