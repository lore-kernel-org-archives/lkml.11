Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F4DC3DA6B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Aug 2022 11:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiH2LUv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Aug 2022 07:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiH2LTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 07:19:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E77D6E2D7;
        Mon, 29 Aug 2022 04:13:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7AE661218;
        Mon, 29 Aug 2022 11:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE80C433C1;
        Mon, 29 Aug 2022 11:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661771579;
        bh=TMBHeboNLghMKzgaVvpn1uXQcBQMa8rbthZ+e+ZXWwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cdyENni/YVu3wYKJV0qO5Ici0WPwilyPWRx+/7fvBhxQDnBOKyMXYXFsE+GZBe5RS
         r5aPHsSHtE9HIeX58HQNm8eQpP6dO2djnbEacUURVQVwbzLkQSv5UsyuJY+sGCj5ZJ
         yB0sxCaBTnLqYgt82/RiXrKjqfLVbEr9JackhqOQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.15 118/136] io_uring: fix issue with io_write() not always undoing sb_start_write()
Date:   Mon, 29 Aug 2022 12:59:45 +0200
Message-Id: <20220829105809.534834253@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220829105804.609007228@linuxfoundation.org>
References: <20220829105804.609007228@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

commit e053aaf4da56cbf0afb33a0fda4a62188e2c0637 upstream.

This is actually an older issue, but we never used to hit the -EAGAIN
path before having done sb_start_write(). Make sure that we always call
kiocb_end_write() if we need to retry the write, so that we keep the
calls to sb_start_write() etc balanced.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/io_uring.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3720,7 +3720,12 @@ done:
 copy_iov:
 		iov_iter_restore(iter, state);
 		ret = io_setup_async_rw(req, iovec, inline_vecs, iter, false);
-		return ret ?: -EAGAIN;
+		if (!ret) {
+			if (kiocb->ki_flags & IOCB_WRITE)
+				kiocb_end_write(req);
+			return -EAGAIN;
+		}
+		return ret;
 	}
 out_free:
 	/* it's reportedly faster than delegating the null check to kfree() */


