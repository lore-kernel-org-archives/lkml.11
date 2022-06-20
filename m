Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395FAC43334
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jun 2022 13:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347231AbiFTNiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jun 2022 09:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346925AbiFTNhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 09:37:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8E22871B;
        Mon, 20 Jun 2022 06:14:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C84B60FEF;
        Mon, 20 Jun 2022 13:13:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432A5C3411B;
        Mon, 20 Jun 2022 13:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655730814;
        bh=UQJ6FlovxwQc5SOGJLgNN+YfADKK5QP7JctfBCH+YzA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sTOFSXqm9bMUOvBq99Z1GHxj7tA3QmxkDuQT+l/WXUNA6soHMCIumqc0B6nTTsXAy
         1AI5t8QuJpsmL+EUth/7t6qrK4XTchY6nhLhVFSp9V315Eg1ena+BVj6Az1wGZ5ZU+
         +/7/AefcionLI02WtsfthqrDDSxQmPQS+Mktuxew=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 5.4 062/240] random: continually use hwgenerator randomness
Date:   Mon, 20 Jun 2022 14:49:23 +0200
Message-Id: <20220620124740.133004351@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220620124737.799371052@linuxfoundation.org>
References: <20220620124737.799371052@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominik Brodowski <linux@dominikbrodowski.net>

commit c321e907aa4803d562d6e70ebed9444ad082f953 upstream.

The rngd kernel thread may sleep indefinitely if the entropy count is
kept above random_write_wakeup_bits by other entropy sources. To make
best use of multiple sources of randomness, mix entropy from hardware
RNGs into the pool at least once within CRNG_RESEED_INTERVAL.

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/random.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2195,13 +2195,15 @@ void add_hwgenerator_randomness(const ch
 			return;
 	}
 
-	/* Suspend writing if we're above the trickle threshold.
+	/* Throttle writing if we're above the trickle threshold.
 	 * We'll be woken up again once below random_write_wakeup_thresh,
-	 * or when the calling thread is about to terminate.
+	 * when the calling thread is about to terminate, or once
+	 * CRNG_RESEED_INTERVAL has lapsed.
 	 */
-	wait_event_interruptible(random_write_wait,
+	wait_event_interruptible_timeout(random_write_wait,
 			!system_wq || kthread_should_stop() ||
-			POOL_ENTROPY_BITS() <= random_write_wakeup_bits);
+			POOL_ENTROPY_BITS() <= random_write_wakeup_bits,
+			CRNG_RESEED_INTERVAL);
 	mix_pool_bytes(buffer, count);
 	credit_entropy_bits(entropy);
 }


