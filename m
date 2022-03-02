Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71578C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 04:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239536AbiCBEhR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Mar 2022 23:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239512AbiCBEgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 23:36:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856CEB12C1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 20:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=MglquwP1b/HuaDjvT7vJEBPQk37mCfbILyADYa7E3VI=; b=qNV3WqbHUTN9l0d8l6byATAMU/
        icRIZcZcX7rmfNHPyRhgN9wVQ/i+BboJM8H/fjjqZ0e4agrbfDKjOWsuURCsxgXnX6U3axwTF65BK
        dFtk3aCwsc2mOdFhNotNEWIOSwCoFB94YiEwEHhfHsxkrZpz3dn0OVPolKN6N6IiBnT+TGHmfYMdY
        0zQZTBOiWR1pIJqTIvcvc//xrSSOfdF1qc5Glel8Q7Cb0Y1CPWdRcKlWGxWBeK1IzgfSoI7MxCesK
        nN1ZbApMR2RGJV7hFpNd5TTZvaFpoJr4OzlIjRfhfer5HYvWIfqKegdIIhG/+q7htaDrOqBpXjRVh
        OOfaH15A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPGhS-00AF7J-Ix; Wed, 02 Mar 2022 04:34:54 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/19] wait: Parameterize the return variable to __wait_event_lock_irq_timeout()
Date:   Wed,  2 Mar 2022 04:34:43 +0000
Message-Id: <20220302043451.2441320-12-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220302043451.2441320-1-willy@infradead.org>
References: <20220302043451.2441320-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macros should not refer to variables which aren't in their arguments.
Pass the name from both its callers.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/wait.h | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 524e0d1690a4..757285a04c88 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -1109,7 +1109,7 @@ do {										\
 	__ret;									\
 })
 
-#define __wait_event_lock_irq_timeout(wq_head, condition, lock, timeout, state)	\
+#define __wait_event_lock_irq_timeout(wq_head, condition, lock, timeout, state, __ret)	\
 	___wait_event(wq_head, ___wait_cond_timeout(condition, __ret),		\
 		      state, 0, timeout,					\
 		      spin_unlock_irq(&lock);					\
@@ -1140,25 +1140,25 @@ do {										\
  * was interrupted by a signal, and the remaining jiffies otherwise
  * if the condition evaluated to true before the timeout elapsed.
  */
-#define wait_event_interruptible_lock_irq_timeout(wq_head, condition, lock,	\
-						  timeout)			\
-({										\
-	long __ret = timeout;							\
-	if (!___wait_cond_timeout(condition, __ret))				\
-		__ret = __wait_event_lock_irq_timeout(				\
-					wq_head, condition, lock, timeout,	\
-					TASK_INTERRUPTIBLE);			\
-	__ret;									\
+#define wait_event_interruptible_lock_irq_timeout(wq_head, condition, lock, \
+						  timeout)		\
+({									\
+	long __ret = timeout;						\
+	if (!___wait_cond_timeout(condition, __ret))			\
+		__ret = __wait_event_lock_irq_timeout(			\
+					wq_head, condition, lock, timeout, \
+					TASK_INTERRUPTIBLE, __ret);	\
+	__ret;								\
 })
 
-#define wait_event_lock_irq_timeout(wq_head, condition, lock, timeout)		\
-({										\
-	long __ret = timeout;							\
-	if (!___wait_cond_timeout(condition, __ret))				\
-		__ret = __wait_event_lock_irq_timeout(				\
-					wq_head, condition, lock, timeout,	\
-					TASK_UNINTERRUPTIBLE);			\
-	__ret;									\
+#define wait_event_lock_irq_timeout(wq_head, condition, lock, timeout)	\
+({									\
+	long __ret = timeout;						\
+	if (!___wait_cond_timeout(condition, __ret))			\
+		__ret = __wait_event_lock_irq_timeout(			\
+					wq_head, condition, lock, timeout, \
+					TASK_UNINTERRUPTIBLE, __ret);	\
+	__ret;								\
 })
 
 /*
-- 
2.34.1

