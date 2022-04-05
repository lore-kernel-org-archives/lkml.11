Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D6BC4332F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 10:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353759AbiDEKJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 06:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241099AbiDEIct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:32:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8AD15718;
        Tue,  5 Apr 2022 01:27:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA31260AFB;
        Tue,  5 Apr 2022 08:27:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA78CC385A1;
        Tue,  5 Apr 2022 08:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649147245;
        bh=qXqfx40qQ5JvHY/HCPqeC+CgsiXSNii4hw22CsqeTk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BDIerafSYu2+nr1RrjfQ05Kbp0tgpHYu1EVYp6gugehL5cLpQJx9Yh8hI1dOSH1hu
         pp2GSSYP80b/kQUiPDgzC279VVWrt2UOkASx8zWdP7rUOGkf3UUYLYEz8kcsZvcYZO
         XpzYP/RUyAAzpu6QQ9q5s/ZCsphFblCC+roovMww=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.17 1055/1126] io_uring: bump poll refs to full 31-bits
Date:   Tue,  5 Apr 2022 09:30:02 +0200
Message-Id: <20220405070438.432743258@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070407.513532867@linuxfoundation.org>
References: <20220405070407.513532867@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

commit e2c0cb7c0cc72939b61a7efee376206725796625 upstream.

The previous commit:

1bc84c40088 ("io_uring: remove poll entry from list when canceling all")

removed a potential overflow condition for the poll references. They
are currently limited to 20-bits, even if we have 31-bits available. The
upper bit is used to mark for cancelation.

Bump the poll ref space to 31-bits, making that kind of situation much
harder to trigger in general. We'll separately add overflow checking
and handling.

Fixes: aa43477b0402 ("io_uring: poll rework")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/io_uring.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -5414,7 +5414,7 @@ struct io_poll_table {
 };
 
 #define IO_POLL_CANCEL_FLAG	BIT(31)
-#define IO_POLL_REF_MASK	((1u << 20)-1)
+#define IO_POLL_REF_MASK	GENMASK(30, 0)
 
 /*
  * If refs part of ->poll_refs (see IO_POLL_REF_MASK) is 0, it's free. We can


