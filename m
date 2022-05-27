Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CA8C433FE
	for <linux-kernel@archiver.kernel.org>; Fri, 27 May 2022 11:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349995AbiE0L5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 May 2022 07:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353033AbiE0LvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 07:51:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70651053F1;
        Fri, 27 May 2022 04:46:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 162E361D94;
        Fri, 27 May 2022 11:46:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB9FC385A9;
        Fri, 27 May 2022 11:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653651996;
        bh=BlPUSq4NXxaVerrK3wlsEA2VYB0g37GE3yAVYt5V2tU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mCvuL2kXbvte0z9u/b9V9slpPgAi6u7Ruz/dKpDFMhNJluc71NWQkvsdeplKKs0I5
         eBuBW4tTOeLk3Hv6A9V9BexBPrMPeBwuUb0qE6kmU68cpttL+SpJ6xLx9XQOX6RTbU
         nKMw/a4sJPK4gNG81a4TdNt29nDvcF+hLrwKsFOg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 5.17 108/111] random: wire up fops->splice_{read,write}_iter()
Date:   Fri, 27 May 2022 10:50:20 +0200
Message-Id: <20220527084834.539636961@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220527084819.133490171@linuxfoundation.org>
References: <20220527084819.133490171@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

commit 79025e727a846be6fd215ae9cdb654368ac3f9a6 upstream.

Now that random/urandom is using {read,write}_iter, we can wire it up to
using the generic splice handlers.

Fixes: 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[Jason: added the splice_write path. Note that sendfile() and such still
 does not work for read, though it does for write, because of a file
 type restriction in splice_direct_to_actor(), which I'll address
 separately.]
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/random.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1384,6 +1384,8 @@ const struct file_operations random_fops
 	.compat_ioctl = compat_ptr_ioctl,
 	.fasync = random_fasync,
 	.llseek = noop_llseek,
+	.splice_read = generic_file_splice_read,
+	.splice_write = iter_file_splice_write,
 };
 
 const struct file_operations urandom_fops = {
@@ -1393,6 +1395,8 @@ const struct file_operations urandom_fop
 	.compat_ioctl = compat_ptr_ioctl,
 	.fasync = random_fasync,
 	.llseek = noop_llseek,
+	.splice_read = generic_file_splice_read,
+	.splice_write = iter_file_splice_write,
 };
 
 


