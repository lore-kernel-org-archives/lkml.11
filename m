Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3907C38161
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 16:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237395AbiCIQtB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 11:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238580AbiCIQbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:31:33 -0500
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BC0199E13
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 08:26:00 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:35880)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nRz8E-00CNB3-Mf; Wed, 09 Mar 2022 09:25:46 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:34572 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nRz8D-005hAS-D6; Wed, 09 Mar 2022 09:25:46 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Wed,  9 Mar 2022 10:24:50 -0600
Message-Id: <20220309162454.123006-9-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
References: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nRz8D-005hAS-D6;;;mid=<20220309162454.123006-9-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19M6pEuQZgSnoOvvBw1GIhIL0rljS0N8nI=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 09/13] task_work: Decouple TIF_NOTIFY_SIGNAL and task_work
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a small handful of reasons besides pending signals that the
kernel might want to break out of interruptible sleeps.  The flag
TIF_NOTIFY_SIGNAL and the helpers that set and clear TIF_NOTIFY_SIGNAL
provide that the infrastructure for breaking out of interruptible
sleeps and entering the return to user space slow path for those
cases.

Expand tracehook_notify_signal inline in it's callers and remove it,
which makes clear that TIF_NOTIFY_SIGNAL and task_work are separate
concepts.

Update the comment on set_notify_signal to more accurately describe
it's purpose.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/io-wq.c                |  4 +++-
 fs/io_uring.c             |  4 +++-
 include/linux/tracehook.h | 15 ++-------------
 kernel/entry/kvm.c        |  7 +++++--
 4 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index bb7f161bb19c..8b9147873c2c 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -515,7 +515,9 @@ static bool io_flush_signals(void)
 {
 	if (unlikely(test_thread_flag(TIF_NOTIFY_SIGNAL))) {
 		__set_current_state(TASK_RUNNING);
-		tracehook_notify_signal();
+		clear_notify_signal();
+		if (task_work_pending(current))
+			task_work_run();
 		return true;
 	}
 	return false;
diff --git a/fs/io_uring.c b/fs/io_uring.c
index e85261079a78..d5fbae1030f9 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2592,7 +2592,9 @@ static inline bool io_run_task_work(void)
 {
 	if (test_thread_flag(TIF_NOTIFY_SIGNAL) || task_work_pending(current)) {
 		__set_current_state(TASK_RUNNING);
-		tracehook_notify_signal();
+		clear_notify_signal();
+		if (task_work_pending(current))
+			task_work_run();
 		return true;
 	}
 
diff --git a/include/linux/tracehook.h b/include/linux/tracehook.h
index b44a7820c468..e5d676e841e3 100644
--- a/include/linux/tracehook.h
+++ b/include/linux/tracehook.h
@@ -113,19 +113,8 @@ static inline void clear_notify_signal(void)
 }
 
 /*
- * called by exit_to_user_mode_loop() if ti_work & _TIF_NOTIFY_SIGNAL. This
- * is currently used by TWA_SIGNAL based task_work, which requires breaking
- * wait loops to ensure that task_work is noticed and run.
- */
-static inline void tracehook_notify_signal(void)
-{
-	clear_notify_signal();
-	if (task_work_pending(current))
-		task_work_run();
-}
-
-/*
- * Called when we have work to process from exit_to_user_mode_loop()
+ * Called to break out of interruptible wait loops, and enter the
+ * exit_to_user_mode_loop().
  */
 static inline void set_notify_signal(struct task_struct *task)
 {
diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
index cabf36a489e4..3ab5f98988c3 100644
--- a/kernel/entry/kvm.c
+++ b/kernel/entry/kvm.c
@@ -8,8 +8,11 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
 	do {
 		int ret;
 
-		if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
-			tracehook_notify_signal();
+		if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL)) {
+			clear_notify_signal();
+			if (task_work_pending(current))
+				task_work_run();
+		}
 
 		if (ti_work & _TIF_SIGPENDING) {
 			kvm_handle_signal_exit(vcpu);
-- 
2.29.2

