Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAB4C4167D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 08:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385650AbiDLIwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 04:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358979AbiDLHmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:42:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEBF54BD4;
        Tue, 12 Apr 2022 00:19:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A058A6153F;
        Tue, 12 Apr 2022 07:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE01C385A1;
        Tue, 12 Apr 2022 07:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649747987;
        bh=wYgE6jyFK7WGv03kxPI2/kG/+lpmU4aK7Xwji4y+v0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c+oiCuwVC6aTR7K7E4LagEWbOS7+PLQoaJkE+b8h1bdP3kYw4bD9zVQTrOzV0o2mW
         irC6cuLEmbWuCFI5NNJZHMLDfIgdgSBzxdcOwIzupyGCJsinVPqMJugG7tc4vEYJk1
         2vleNNwyObOfk0EAuEvQruZNwjupnhaf8NTVkPPU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.17 276/343] io_uring: dont check req->file in io_fsync_prep()
Date:   Tue, 12 Apr 2022 08:31:34 +0200
Message-Id: <20220412062959.289235162@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412062951.095765152@linuxfoundation.org>
References: <20220412062951.095765152@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

commit ec858afda857e361182ceafc3d2ba2b164b8e889 upstream.

This is a leftover from the really old days where we weren't able to
track and error early if we need a file and it wasn't assigned. Kill
the check.

Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/io_uring.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -4245,9 +4245,6 @@ static int io_fsync_prep(struct io_kiocb
 {
 	struct io_ring_ctx *ctx = req->ctx;
 
-	if (!req->file)
-		return -EBADF;
-
 	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
 		return -EINVAL;
 	if (unlikely(sqe->addr || sqe->ioprio || sqe->buf_index ||


