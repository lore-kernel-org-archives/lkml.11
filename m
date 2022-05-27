Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72056C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 May 2022 11:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351750AbiE0LnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 May 2022 07:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351613AbiE0Ll6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 07:41:58 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8121339E1;
        Fri, 27 May 2022 04:40:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8863CCE1164;
        Fri, 27 May 2022 11:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF84C385A9;
        Fri, 27 May 2022 11:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653651613;
        bh=2o7T0INMSwsgvRo+n2iMUuYdHX+489kEgvJn3TjGvY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z/CK5MzQAcoLTE1x/EbXAICt+a+NWon4sAym4dwvcmlWF4j6tOuCJnRBrQ92rH8EP
         ZI9gGpnjlQhTleY5rVR0KUSe6FE7ruuteWyyEgt2Cuf+uQzd597zdGauOWyP7up4XC
         Ci6af1OYgbQyi+h6IEhLSTygiBsQLgjnag+0fVg0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 5.15 020/145] random: avoid superfluous call to RDRAND in CRNG extraction
Date:   Fri, 27 May 2022 10:48:41 +0200
Message-Id: <20220527084853.366996823@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220527084850.364560116@linuxfoundation.org>
References: <20220527084850.364560116@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jason A. Donenfeld" <Jason@zx2c4.com>

commit 2ee25b6968b1b3c66ffa408de23d023c1bce81cf upstream.

RDRAND is not fast. RDRAND is actually quite slow. We've known this for
a while, which is why functions like get_random_u{32,64} were converted
to use batching of our ChaCha-based CRNG instead.

Yet CRNG extraction still includes a call to RDRAND, in the hot path of
every call to get_random_bytes(), /dev/urandom, and getrandom(2).

This call to RDRAND here seems quite superfluous. CRNG is already
extracting things based on a 256-bit key, based on good entropy, which
is then reseeded periodically, updated, backtrack-mutated, and so
forth. The CRNG extraction construction is something that we're already
relying on to be secure and solid. If it's not, that's a serious
problem, and it's unlikely that mixing in a measly 32 bits from RDRAND
is going to alleviate things.

And in the case where the CRNG doesn't have enough entropy yet, we're
already initializing the ChaCha key row with RDRAND in
crng_init_try_arch_early().

Removing the call to RDRAND improves performance on an i7-11850H by
370%. In other words, the vast majority of the work done by
extract_crng() prior to this commit was devoted to fetching 32 bits of
RDRAND.

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/random.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1023,7 +1023,7 @@ static void crng_reseed(struct crng_stat
 static void _extract_crng(struct crng_state *crng,
 			  __u8 out[CHACHA_BLOCK_SIZE])
 {
-	unsigned long v, flags, init_time;
+	unsigned long flags, init_time;
 
 	if (crng_ready()) {
 		init_time = READ_ONCE(crng->init_time);
@@ -1033,8 +1033,6 @@ static void _extract_crng(struct crng_st
 				    &input_pool : NULL);
 	}
 	spin_lock_irqsave(&crng->lock, flags);
-	if (arch_get_random_long(&v))
-		crng->state[14] ^= v;
 	chacha20_block(&crng->state[0], out);
 	if (crng->state[12] == 0)
 		crng->state[13]++;


