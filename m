Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65A2C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Mar 2022 22:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350703AbiCHWS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Mar 2022 17:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350929AbiCHWSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 17:18:17 -0500
Received: from cloud48395.mywhc.ca (cloud48395.mywhc.ca [173.209.37.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A63C5749F;
        Tue,  8 Mar 2022 14:17:16 -0800 (PST)
Received: from [45.44.224.220] (port=42886 helo=localhost)
        by cloud48395.mywhc.ca with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <olivier@trillion01.com>)
        id 1nRi8p-0000SK-Dp; Tue, 08 Mar 2022 17:17:15 -0500
Date:   Tue, 08 Mar 2022 17:17:14 -0500
Message-Id: <cover.1646777484.git.olivier@trillion01.com>
From:   Olivier Langlois <olivier@trillion01.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     Hao Xu <haoxu@linux.alibaba.com>,
        io-uring <io-uring@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 0/2] io_uring: Add support for napi_busy_poll
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud48395.mywhc.ca
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - trillion01.com
X-Get-Message-Sender-Via: cloud48395.mywhc.ca: authenticated_id: olivier@trillion01.com
X-Authenticated-Sender: cloud48395.mywhc.ca: olivier@trillion01.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sqpoll thread can be used for performing the napi busy poll in a
similar way that it does io polling for file systems supporting direct
access bypassing the page cache.

The other way that io_uring can be used for napi busy poll is by
calling io_uring_enter() to get events.

If the user specify a timeout value, it is distributed between polling
and sleeping by using the systemwide setting
/proc/sys/net/core/busy_poll.

The changes have been tested with this program:
https://github.com/lano1106/io_uring_udp_ping

and the result is:
Without sqpoll:
NAPI busy loop disabled:
rtt min/avg/max/mdev = 40.631/42.050/58.667/1.547 us
NAPI busy loop enabled:
rtt min/avg/max/mdev = 30.619/31.753/61.433/1.456 us

With sqpoll:
NAPI busy loop disabled:
rtt min/avg/max/mdev = 42.087/44.438/59.508/1.533 us
NAPI busy loop enabled:
rtt min/avg/max/mdev = 35.779/37.347/52.201/0.924 us

v2:
 * Evaluate list_empty(&ctx->napi_list) outside io_napi_busy_loop() to keep
   __io_sq_thread() execution as fast as possible
 * In io_cqring_wait(), move up the sig block to avoid needless computation
   if the block exits the function
 * In io_cqring_wait(), protect ctx->napi_list from race condition by
   splicing it into a local list
 * In io_cqring_wait(), allow busy polling when uts is missing
 * Fix kernel test robot issues
v3:
 * Fix do_div() type mismatch warning
 * Reduce uring_lock contention by creating a spinlock for protecting
   napi_list
 * Support correctly MULTISHOT poll requests
v4:
 * Put back benchmark result in commit text
v5:
 * Protect napi_list from concurrent access from io_workers threads

Olivier Langlois (2):
  io_uring: minor io_cqring_wait() optimization
  io_uring: Add support for napi_busy_poll

 fs/io_uring.c | 248 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 239 insertions(+), 9 deletions(-)

-- 
2.35.1

