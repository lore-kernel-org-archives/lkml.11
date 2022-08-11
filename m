Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20E6C25B0C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Aug 2022 14:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbiHKOBY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Aug 2022 10:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235099AbiHKOBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 10:01:21 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB26527CC8;
        Thu, 11 Aug 2022 07:01:19 -0700 (PDT)
X-QQ-mid: bizesmtp90t1660226475t13hmhz6
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 11 Aug 2022 22:01:14 +0800 (CST)
X-QQ-SSF: 01000000002000G0V000B00A0000020
X-QQ-FEAT: cbck7jzG4wYo3aiVvWYVzvdHMUgvcwyQUi4mOQ1T1deJu/652BMV+k+UWrUoE
        rprXS/Lnl5izxO04w2CoUJeecGdf19pFJkKkSM2fg/aSP3N5gD0F/gTC5PhLyXJ7Yg8IL03
        vs9AQCDBWWH1o1PYn4Ipj4vnKQxhxIPcvuBmf1iNgopb/NPsRWVbS7TdStM2wQvx3/sZZwJ
        XHzXSDpH2WSxtsSwGWtK3hU9EohaPrF2SRZWiuD3gAkxta/HYHg8yyfoemYI1HeCKXX+KhM
        UYEpZMSmKT098tFqxaiadGWd5Qg0I/m5pvR9ZxpCS5RjwQbODrf0R+MbA19popPt6sDT2sn
        gC96Gqw8iRaCgOSkIeQfU6y4bbkrgFpH5h1I4/17tsAQvlQSW6hVIvOQyZntSiCTnC/2vcW
        AErN8FMx54A=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] fs/pipe.c: Fix comment typo
Date:   Thu, 11 Aug 2022 22:01:07 +0800
Message-Id: <20220811140107.29595-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `do' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 fs/pipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 74ae9fafd25a..f4a070b12519 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -579,7 +579,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	__pipe_unlock(pipe);
 
 	/*
-	 * If we do do a wakeup event, we do a 'sync' wakeup, because we
+	 * If we do a wakeup event, we do a 'sync' wakeup, because we
 	 * want the reader to start processing things asap, rather than
 	 * leave the data pending.
 	 *
-- 
2.36.1

