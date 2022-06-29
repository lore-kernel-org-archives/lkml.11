Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A477C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jun 2022 07:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbiF2Hhe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jun 2022 03:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbiF2HhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 03:37:24 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8A1A35DF2;
        Wed, 29 Jun 2022 00:37:23 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 80AA81E80D50;
        Wed, 29 Jun 2022 15:36:12 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9S0AHZ_YARYC; Wed, 29 Jun 2022 15:36:09 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 4DD621E80D11;
        Wed, 29 Jun 2022 15:36:09 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     ebiederm@xmission.com, keescook@chromium.org,
        viro@zeniv.linux.org.uk
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        renyu@nfschina.com, Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH] exec: Fix a spelling mistake
Date:   Wed, 29 Jun 2022 15:29:32 +0800
Message-Id: <20220629072932.27506-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change 'wont't' to 'won't'.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 fs/exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 96b9847fca99..5f0656e10b5d 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1156,7 +1156,7 @@ static int de_thread(struct task_struct *tsk)
 		/*
 		 * We are going to release_task()->ptrace_unlink() silently,
 		 * the tracer can sleep in do_wait(). EXIT_DEAD guarantees
-		 * the tracer wont't block again waiting for this thread.
+		 * the tracer won't block again waiting for this thread.
 		 */
 		if (unlikely(leader->ptrace))
 			__wake_up_parent(leader, leader->parent);
-- 
2.34.1

