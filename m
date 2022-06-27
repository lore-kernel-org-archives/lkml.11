Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692BDC43334
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 11:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235977AbiF0Le5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 07:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236198AbiF0Ld1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:33:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFFBCE2A;
        Mon, 27 Jun 2022 04:30:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8685DB8111A;
        Mon, 27 Jun 2022 11:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABBCC341CD;
        Mon, 27 Jun 2022 11:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656329432;
        bh=XtTYzG2sSKDKpLMoDkSYqdHNzo+dDX9KmREtNYeCC4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oNg7W+z2dXbG9reXz8dl72Df6Pg9JOdo7GwQxC/+NOc6pF/xy9LxaGfRQ/QFJmvJB
         kl48CYO03xEtXmKv+cMP5qjFDlhjbw9WOaAF+uFbTLOnWSY7Oyy1IFuHQekF11dtTf
         pmfppipHe60TDtvzO7kAdBQvNVnW97TEex66xDUs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 5.4 58/60] random: update comment from copy_to_user() -> copy_to_iter()
Date:   Mon, 27 Jun 2022 13:22:09 +0200
Message-Id: <20220627111929.398188532@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627111927.641837068@linuxfoundation.org>
References: <20220627111927.641837068@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason A. Donenfeld <Jason@zx2c4.com>

commit 63b8ea5e4f1a87dea4d3114293fc8e96a8f193d7 upstream.

This comment wasn't updated when we moved from read() to read_iter(), so
this patch makes the trivial fix.

Fixes: 1b388e7765f2 ("random: convert to using fops->read_iter()")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/random.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -450,7 +450,7 @@ static ssize_t get_random_bytes_user(str
 
 	/*
 	 * Immediately overwrite the ChaCha key at index 4 with random
-	 * bytes, in case userspace causes copy_to_user() below to sleep
+	 * bytes, in case userspace causes copy_to_iter() below to sleep
 	 * forever, so that we still retain forward secrecy in that case.
 	 */
 	crng_make_state(chacha_state, (u8 *)&chacha_state[4], CHACHA_KEY_SIZE);


