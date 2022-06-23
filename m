Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7163BCCA47C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jun 2022 17:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbiFWROH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jun 2022 13:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiFWRLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 13:11:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33801B7B1;
        Thu, 23 Jun 2022 09:51:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95BACB82490;
        Thu, 23 Jun 2022 16:51:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00AAC3411B;
        Thu, 23 Jun 2022 16:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656003088;
        bh=EfDHez6bplTEEaL8HZ+uQVhkOVviWmPlixb/w9592Jk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r3tqG1rNIxjx8JLuEx0kgbUjE3AQJDfbuOV8fl15J+ooX9ocvJIDh7vEePsuqjSAw
         mRfsWUZuhfpVXsJScnMoHym2z5KYUJfOfBxVcitnyXiuGNLaKNDznOEvHuC2EhbXIX
         llfDPEqW/bkxKBVFTueb3nCUnMaOJU17rOl6vk2k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jann Horn <jannh@google.com>,
        Eric Biggers <ebiggers@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 4.9 124/264] random: remove outdated INT_MAX >> 6 check in urandom_read()
Date:   Thu, 23 Jun 2022 18:41:57 +0200
Message-Id: <20220623164347.575405243@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220623164344.053938039@linuxfoundation.org>
References: <20220623164344.053938039@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jason A. Donenfeld" <Jason@zx2c4.com>

commit 434537ae54ad37e93555de21b6ac8133d6d773a9 upstream.

In 79a8468747c5 ("random: check for increase of entropy_count because of
signed conversion"), a number of checks were added around what values
were passed to account(), because account() was doing fancy fixed point
fractional arithmetic, and a user had some ability to pass large values
directly into it. One of things in that commit was limiting those values
to INT_MAX >> 6. The first >> 3 was for bytes to bits, and the next >> 3
was for bits to 1/8 fractional bits.

However, for several years now, urandom reads no longer touch entropy
accounting, and so this check serves no purpose. The current flow is:

urandom_read_nowarn()-->get_random_bytes_user()-->chacha20_block()

Of course, we don't want that size_t to be truncated when adding it into
the ssize_t. But we arrive at urandom_read_nowarn() in the first place
either via ordinary fops, which limits reads to MAX_RW_COUNT, or via
getrandom() which limits reads to INT_MAX.

Cc: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
Reviewed-by: Jann Horn <jannh@google.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/random.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1336,9 +1336,8 @@ void rand_initialize_disk(struct gendisk
 static ssize_t urandom_read_nowarn(struct file *file, char __user *buf,
 				   size_t nbytes, loff_t *ppos)
 {
-	int ret;
+	ssize_t ret;
 
-	nbytes = min_t(size_t, nbytes, INT_MAX >> 6);
 	ret = get_random_bytes_user(buf, nbytes);
 	trace_urandom_read(nbytes, input_pool.entropy_count);
 	return ret;


