Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19D0C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 16:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbiCIQpV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 11:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238445AbiCIQb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:31:27 -0500
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABAD190C17
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 08:25:49 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:35780)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nRz89-00CNAK-HE; Wed, 09 Mar 2022 09:25:41 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:34572 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nRz86-005hAS-5s; Wed, 09 Mar 2022 09:25:41 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Wed,  9 Mar 2022 10:24:48 -0600
Message-Id: <20220309162454.123006-7-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
References: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nRz86-005hAS-5s;;;mid=<20220309162454.123006-7-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18pJwd2lf+RP9kvKgOhhWVsNfjktPzgMEY=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 07/13] task_work: Introduce task_work_pending
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrap the test of task->task_works in a helper function to make
it clear what is being tested.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/io_uring.c             | 6 +++---
 include/linux/task_work.h | 5 +++++
 include/linux/tracehook.h | 4 ++--
 kernel/signal.c           | 4 ++--
 kernel/task_work.c        | 2 +-
 5 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index e54c4127422e..e85261079a78 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2590,7 +2590,7 @@ static inline unsigned int io_sqring_entries(struct io_ring_ctx *ctx)
 
 static inline bool io_run_task_work(void)
 {
-	if (test_thread_flag(TIF_NOTIFY_SIGNAL) || current->task_works) {
+	if (test_thread_flag(TIF_NOTIFY_SIGNAL) || task_work_pending(current)) {
 		__set_current_state(TASK_RUNNING);
 		tracehook_notify_signal();
 		return true;
@@ -7602,7 +7602,7 @@ static int io_sq_thread(void *data)
 		}
 
 		prepare_to_wait(&sqd->wait, &wait, TASK_INTERRUPTIBLE);
-		if (!io_sqd_events_pending(sqd) && !current->task_works) {
+		if (!io_sqd_events_pending(sqd) && !task_work_pending(current)) {
 			bool needs_sched = true;
 
 			list_for_each_entry(ctx, &sqd->ctx_list, sqd_list) {
@@ -10321,7 +10321,7 @@ static __cold void __io_uring_show_fdinfo(struct io_ring_ctx *ctx,
 
 		hlist_for_each_entry(req, list, hash_node)
 			seq_printf(m, "  op=%d, task_works=%d\n", req->opcode,
-					req->task->task_works != NULL);
+					task_work_pending(req->task));
 	}
 
 	seq_puts(m, "CqOverflowList:\n");
diff --git a/include/linux/task_work.h b/include/linux/task_work.h
index 5b8a93f288bb..897494b597ba 100644
--- a/include/linux/task_work.h
+++ b/include/linux/task_work.h
@@ -19,6 +19,11 @@ enum task_work_notify_mode {
 	TWA_SIGNAL,
 };
 
+static inline bool task_work_pending(struct task_struct *task)
+{
+	return READ_ONCE(task->task_works);
+}
+
 int task_work_add(struct task_struct *task, struct callback_head *twork,
 			enum task_work_notify_mode mode);
 
diff --git a/include/linux/tracehook.h b/include/linux/tracehook.h
index b77bf4917196..fa834a22e86e 100644
--- a/include/linux/tracehook.h
+++ b/include/linux/tracehook.h
@@ -90,7 +90,7 @@ static inline void tracehook_notify_resume(struct pt_regs *regs)
 	 * hlist_add_head(task->task_works);
 	 */
 	smp_mb__after_atomic();
-	if (unlikely(current->task_works))
+	if (unlikely(task_work_pending(current)))
 		task_work_run();
 
 #ifdef CONFIG_KEYS_REQUEST_CACHE
@@ -115,7 +115,7 @@ static inline void tracehook_notify_signal(void)
 {
 	clear_thread_flag(TIF_NOTIFY_SIGNAL);
 	smp_mb__after_atomic();
-	if (current->task_works)
+	if (task_work_pending(current))
 		task_work_run();
 }
 
diff --git a/kernel/signal.c b/kernel/signal.c
index 0e0bd1c1068b..3b4cf25fb9b3 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2344,7 +2344,7 @@ static void ptrace_do_notify(int signr, int exit_code, int why)
 void ptrace_notify(int exit_code)
 {
 	BUG_ON((exit_code & (0x7f | ~0xffff)) != SIGTRAP);
-	if (unlikely(current->task_works))
+	if (unlikely(task_work_pending(current)))
 		task_work_run();
 
 	spin_lock_irq(&current->sighand->siglock);
@@ -2626,7 +2626,7 @@ bool get_signal(struct ksignal *ksig)
 	struct signal_struct *signal = current->signal;
 	int signr;
 
-	if (unlikely(current->task_works))
+	if (unlikely(task_work_pending(current)))
 		task_work_run();
 
 	/*
diff --git a/kernel/task_work.c b/kernel/task_work.c
index 1698fbe6f0e1..cc6fccb0e24d 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -78,7 +78,7 @@ task_work_cancel_match(struct task_struct *task,
 	struct callback_head *work;
 	unsigned long flags;
 
-	if (likely(!task->task_works))
+	if (likely(!task_work_pending(task)))
 		return NULL;
 	/*
 	 * If cmpxchg() fails we continue without updating pprev.
-- 
2.29.2

