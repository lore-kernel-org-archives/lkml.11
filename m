Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD6CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 10:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiBIKkC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Feb 2022 05:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiBIKj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 05:39:58 -0500
Received: from out199-2.us.a.mail.aliyun.com (out199-2.us.a.mail.aliyun.com [47.90.199.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592A1E09DDAC;
        Wed,  9 Feb 2022 02:26:48 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V4.4LdI_1644402398;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V4.4LdI_1644402398)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 09 Feb 2022 18:26:44 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] io_uring: Fix uninitialized use of ret in io_eventfd_register()
Date:   Wed,  9 Feb 2022 18:26:37 +0800
Message-Id: <20220209102637.34088-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some scenarios, ret is not assigned in the whole process, so it
needs to be initialized at the beginning.

Clean up the following clang warning:

fs/io_uring.c:9373:13: note: initialize the variable 'ret' to silence
this warning.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 5479f0607430..7f277890f1ec 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -9370,7 +9370,7 @@ static int io_eventfd_register(struct io_ring_ctx *ctx, void __user *arg,
 {
 	struct io_ev_fd *ev_fd;
 	__s32 __user *fds = arg;
-	int fd, ret;
+	int fd, ret = 0;
 
 	ev_fd = rcu_dereference_protected(ctx->io_ev_fd,
 					lockdep_is_held(&ctx->uring_lock));
-- 
2.20.1.7.g153144c

