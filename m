Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6345C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 13:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354608AbiBNNs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 08:48:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbiBNNs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:48:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AC0BCBF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:48:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3468CB80EE1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:48:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716E6C340E9;
        Mon, 14 Feb 2022 13:48:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="j8Bhg8un"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644846526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cOMdCmNV4mNS64vF6rK6hBr6/XZqlUrl4jKwhxROapo=;
        b=j8Bhg8unZgSuUsrd4Co+LRkA1sOJyWPIC6shMwLLa5Tst6VY1nFwmom5QbG1ZAvLd7wadE
        a09jEBS8xy9zC9HvnrxQoCjyOJTTDK48vw63nKr6aQY9vcy0hUs0JVCkDY1v6H21F+n8Ao
        NJt74hQ5UVBLqBBRykc8c1YWNU+K/JE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3ff68864 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 14 Feb 2022 13:48:45 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] random: invalidate crngs and batches on cpuhp teardown
Date:   Mon, 14 Feb 2022 14:48:38 +0100
Message-Id: <20220214134838.980159-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a cpuhp teardown notifier, we can invalidate the keys
used by the per-cpu crngs and the batches used by per-cpu batched
entropy, so that if the cpus come back online, and the generation
counter happens to have cycled all the way around to where it was
before, it doesn't mistakenly use the old data. The chances of this
happening are exceedingly rare, but since we now have the notifier
setup, doing this is basically free.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sultan Alsawaf <sultan@kerneltoast.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index df5aef93da34..ce199af9bc56 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1225,6 +1225,15 @@ int random_dead_cpu(unsigned int cpu)
 	 * since the MIX_INFLIGHT flag will be cleared.
 	 */
 	per_cpu_ptr(&irq_randomness, cpu)->count = 0;
+
+	/*
+	 * We also want to invalidate per-cpu crngs and batches,
+	 * so that if the CPU does come back online, it uses
+	 * fresh entropy.
+	 */
+	per_cpu_ptr(&crngs, cpu)->generation = ULONG_MAX;
+	per_cpu_ptr(&batched_entropy_u32, cpu)->position = UINT_MAX;
+	per_cpu_ptr(&batched_entropy_u64, cpu)->position = UINT_MAX;
 	return 0;
 }
 
-- 
2.35.0

