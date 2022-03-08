Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16905C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Mar 2022 18:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349648AbiCHS1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Mar 2022 13:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349698AbiCHS0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:26:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A102AE0B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 10:25:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB60AB818A2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 18:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3951C340EB;
        Tue,  8 Mar 2022 18:25:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="MQUUy+Ag"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1646763920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CQ+IVBr7O0f2WkL2DHrWgZedfmnrNLjmZsZWJVL+jdA=;
        b=MQUUy+AgTpJoEJAwnrszvcojsIm71iP5sUx3xXm3zeie7O6d6LBiR2IWXP0bEg7mus34s7
        iYoe7sVVVewcPQhyiR1FDMc6ie6a/KwcUJd3nVVIarjFiUOCRCPiXQ++PeylEy4mUsbbKF
        LeCOsdB9td4eoDrQeGngvSWkrH6Xv2I=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c6ad17ba (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 8 Mar 2022 18:25:20 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] random: make consistent usage of crng_ready()
Date:   Tue,  8 Mar 2022 11:25:17 -0700
Message-Id: <20220308182517.273662-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than sometimes checking `crng_init < 2`, we should always use the
crng_ready() macro, so that should we change anything later, it's
consistent. Additionally, that macro already has a likely() around it,
which means we don't need to open code our own likely() and unlikely()
annotations.

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 69591d599338..e37ae7ef039c 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -123,7 +123,7 @@ static void try_to_generate_entropy(void);
  */
 int wait_for_random_bytes(void)
 {
-	if (likely(crng_ready()))
+	if (crng_ready())
 		return 0;
 
 	do {
@@ -289,7 +289,7 @@ static void crng_reseed(bool force)
 		++next_gen;
 	WRITE_ONCE(base_crng.generation, next_gen);
 	WRITE_ONCE(base_crng.birth, jiffies);
-	if (crng_init < 2) {
+	if (!crng_ready()) {
 		crng_init = 2;
 		finalize_init = true;
 	}
@@ -352,7 +352,7 @@ static void crng_make_state(u32 chacha_state[CHACHA_STATE_WORDS],
 	 * ready, we do fast key erasure with the base_crng directly, because
 	 * this is what crng_pre_init_inject() mutates during early init.
 	 */
-	if (unlikely(!crng_ready())) {
+	if (!crng_ready()) {
 		bool ready;
 
 		spin_lock_irqsave(&base_crng.lock, flags);
@@ -795,7 +795,7 @@ static void credit_entropy_bits(size_t nbits)
 		entropy_count = min_t(unsigned int, POOL_BITS, orig + add);
 	} while (cmpxchg(&input_pool.entropy_count, orig, entropy_count) != orig);
 
-	if (crng_init < 2 && entropy_count >= POOL_MIN_BITS)
+	if (!crng_ready() && entropy_count >= POOL_MIN_BITS)
 		crng_reseed(false);
 }
 
-- 
2.35.1

