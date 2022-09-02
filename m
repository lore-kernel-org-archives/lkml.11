Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14FEC6FA82
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Sep 2022 12:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236385AbiIBMo2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Sep 2022 08:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237369AbiIBMmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 08:42:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DA8E094E;
        Fri,  2 Sep 2022 05:32:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1137DB82A94;
        Fri,  2 Sep 2022 12:31:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71DADC433D6;
        Fri,  2 Sep 2022 12:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662121882;
        bh=+OwaWvDm6s13idP12RWK5sAQ7wn0qKFIK/qWMx36jbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TcX/Gn+DpruwKOjiewPLaO9pTOLxr2DypsSOaHSiCu1ZOS2OJkjVku0hPm9yef3M8
         I+oYHhz1aCrZEk8t/2VK3IURG13Y8inQC8pMFaRk3LfJY4YrBfrIUJqGw2i5oyuItm
         m0GP+B79xeQd9UiYBov5jxA1Ij7R6ugMr47PN280=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Abaci Robot <abaci@linux.alibaba.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 5.15 18/73] io_uring: Remove unused function req_ref_put
Date:   Fri,  2 Sep 2022 14:18:42 +0200
Message-Id: <20220902121405.058275058@linuxfoundation.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220902121404.435662285@linuxfoundation.org>
References: <20220902121404.435662285@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

[ upstream commmit c84b8a3fef663933007e885535591b9d30bdc860 ]

Fix the following clang warnings:

fs/io_uring.c:1195:20: warning: unused function 'req_ref_put'
[-Wunused-function].

Fixes: aa43477b0402 ("io_uring: poll rework")
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Link: https://lore.kernel.org/r/20220113162005.3011-1-jiapeng.chong@linux.alibaba.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[pavel: backport]
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/io_uring.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1155,12 +1155,6 @@ static inline bool req_ref_put_and_test(
 	return atomic_dec_and_test(&req->refs);
 }
 
-static inline void req_ref_put(struct io_kiocb *req)
-{
-	WARN_ON_ONCE(!(req->flags & REQ_F_REFCOUNT));
-	WARN_ON_ONCE(req_ref_put_and_test(req));
-}
-
 static inline void req_ref_get(struct io_kiocb *req)
 {
 	WARN_ON_ONCE(!(req->flags & REQ_F_REFCOUNT));


