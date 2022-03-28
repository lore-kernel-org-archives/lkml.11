Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF482C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Mar 2022 11:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240733AbiC1LWg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Mar 2022 07:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240783AbiC1LVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:21:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD3456744;
        Mon, 28 Mar 2022 04:19:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E48D1B81055;
        Mon, 28 Mar 2022 11:19:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABB6C36AE2;
        Mon, 28 Mar 2022 11:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648466344;
        bh=VmAP1FfGZcOdyX9tx8pMMq8DNl/LGmOclKKUyki6bmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UVCpmE8O0ib233VotJKtjExmhMmEhkZ4tsp6Znq/hiy4D9ucGvx8fmUR5kanDNMMf
         QPC+paYMoabRd8g6R8B8b+haaGBK3lBovJEaXcqiqddJyLx9IBVJAmHaNmUtMRvp6w
         ohVwYQWbcalomyQxfSfWGxzBqgQLpPmorpmbWhb9N220YQrAWStZW7Sq+tUVwqrRN+
         Yj+h9EpUg+JLrcZaSplV2jZfzr9dqduHt9rnqJ0ofqPc06VqiYwlL3Sv5T/8kEbe2S
         e8x/ssAzAlu+GCooKZpWgf1q3GdCt2ANGM+/mj0/m7emGcJmjFDLbYV3X7aTug0YhD
         Rw+aFc6I8qcnA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.17 20/43] random: round-robin registers as ulong, not u32
Date:   Mon, 28 Mar 2022 07:18:04 -0400
Message-Id: <20220328111828.1554086-20-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220328111828.1554086-1-sashal@kernel.org>
References: <20220328111828.1554086-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jason A. Donenfeld" <Jason@zx2c4.com>

[ Upstream commit da3951ebdcd1cb1d5c750e08cd05aee7b0c04d9a ]

When the interrupt handler does not have a valid cycle counter, it calls
get_reg() to read a register from the irq stack, in round-robin.
Currently it does this assuming that registers are 32-bit. This is
_probably_ the case, and probably all platforms without cycle counters
are in fact 32-bit platforms. But maybe not, and either way, it's not
quite correct. This commit fixes that to deal with `unsigned long`
rather than `u32`.

Cc: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/random.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 2f21c5473d86..d2ce6b1a229d 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1032,15 +1032,15 @@ static void add_interrupt_bench(cycles_t start)
 #define add_interrupt_bench(x)
 #endif
 
-static u32 get_reg(struct fast_pool *f, struct pt_regs *regs)
+static unsigned long get_reg(struct fast_pool *f, struct pt_regs *regs)
 {
-	u32 *ptr = (u32 *)regs;
+	unsigned long *ptr = (unsigned long *)regs;
 	unsigned int idx;
 
 	if (regs == NULL)
 		return 0;
 	idx = READ_ONCE(f->reg_idx);
-	if (idx >= sizeof(struct pt_regs) / sizeof(u32))
+	if (idx >= sizeof(struct pt_regs) / sizeof(unsigned long))
 		idx = 0;
 	ptr += idx++;
 	WRITE_ONCE(f->reg_idx, idx);
-- 
2.34.1

