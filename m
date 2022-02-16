Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF8AC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Feb 2022 18:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244464AbiBQSZC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Feb 2022 13:25:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244400AbiBQSYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:24:53 -0500
Received: from cloud48395.mywhc.ca (cloud48395.mywhc.ca [173.209.37.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76713BFAA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 10:24:21 -0800 (PST)
Received: from [45.44.224.220] (port=39846 helo=localhost)
        by cloud48395.mywhc.ca with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <olivier@trillion01.com>)
        id 1nKkvU-0001fk-2c; Thu, 17 Feb 2022 12:50:44 -0500
From:   Olivier Langlois <olivier@trillion01.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        io-uring <io-uring@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <bd7c0495f7656e803e5736708591bb665e6eaacd.1645041650.git.olivier@trillion01.com>
From:   Olivier Langlois <olivier@trillion01.com>
Date:   Wed, 16 Feb 2022 14:53:42 -0500
Subject: [PATCH] io_uring: Remove unneeded test in io_run_task_work_sig()
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
Message-ID: <20220216195342.msHzSzRnlA5-AkKCUXsBadGES4RKF7GtdwBUCMY4xLU@z>

Avoid testing TIF_NOTIFY_SIGNAL twice by calling task_sigpending()
directly from io_run_task_work_sig()

Signed-off-by: Olivier Langlois <olivier@trillion01.com>
---
 fs/io_uring.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 77b9c7e4793b..9b320b5f158c 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -7683,11 +7683,11 @@ static int io_run_task_work_sig(void)
 {
 	if (io_run_task_work())
 		return 1;
-	if (!signal_pending(current))
-		return 0;
 	if (test_thread_flag(TIF_NOTIFY_SIGNAL))
 		return -ERESTARTSYS;
-	return -EINTR;
+	if (task_sigpending(current))
+		return -EINTR;
+	return 0;
 }
 
 /* when returns >0, the caller should retry */
-- 
2.35.1

