Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EBEC4332F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 16:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiCIQoi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 11:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238066AbiCIQbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:31:21 -0500
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE5F192E20
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 08:25:36 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:59030)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nRz80-008XMQ-BD; Wed, 09 Mar 2022 09:25:32 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:34572 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nRz7z-005hAS-9o; Wed, 09 Mar 2022 09:25:31 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Wed,  9 Mar 2022 10:24:45 -0600
Message-Id: <20220309162454.123006-4-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
References: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nRz7z-005hAS-9o;;;mid=<20220309162454.123006-4-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+HRP4lktCkAF4NIFX02aF6wH5SiahMO9Y=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 04/13] ptrace: Remove arch_syscall_{enter,exit}_tracehook
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions are alwasy one-to-one wrappers around
ptrace_report_syscall_entry and ptrace_report_syscall_exit.
So directly call the functions they are wrapping instead.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/entry-common.h | 43 ++----------------------------------
 kernel/entry/common.c        |  4 ++--
 2 files changed, 4 insertions(+), 43 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index a670e9fba7a9..9efbdda61f7a 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -79,26 +79,6 @@ static __always_inline void arch_check_user_regs(struct pt_regs *regs);
 static __always_inline void arch_check_user_regs(struct pt_regs *regs) {}
 #endif
 
-/**
- * arch_syscall_enter_tracehook - Wrapper around tracehook_report_syscall_entry()
- * @regs:	Pointer to currents pt_regs
- *
- * Returns: 0 on success or an error code to skip the syscall.
- *
- * Defaults to tracehook_report_syscall_entry(). Can be replaced by
- * architecture specific code.
- *
- * Invoked from syscall_enter_from_user_mode()
- */
-static inline __must_check int arch_syscall_enter_tracehook(struct pt_regs *regs);
-
-#ifndef arch_syscall_enter_tracehook
-static inline __must_check int arch_syscall_enter_tracehook(struct pt_regs *regs)
-{
-	return ptrace_report_syscall_entry(regs);
-}
-#endif
-
 /**
  * enter_from_user_mode - Establish state when coming from user mode
  *
@@ -157,7 +137,7 @@ void syscall_enter_from_user_mode_prepare(struct pt_regs *regs);
  * It handles the following work items:
  *
  *  1) syscall_work flag dependent invocations of
- *     arch_syscall_enter_tracehook(), __secure_computing(), trace_sys_enter()
+ *     ptrace_report_syscall_entry(), __secure_computing(), trace_sys_enter()
  *  2) Invocation of audit_syscall_entry()
  */
 long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall);
@@ -279,25 +259,6 @@ static __always_inline void arch_exit_to_user_mode(void) { }
  */
 void arch_do_signal_or_restart(struct pt_regs *regs, bool has_signal);
 
-/**
- * arch_syscall_exit_tracehook - Wrapper around tracehook_report_syscall_exit()
- * @regs:	Pointer to currents pt_regs
- * @step:	Indicator for single step
- *
- * Defaults to tracehook_report_syscall_exit(). Can be replaced by
- * architecture specific code.
- *
- * Invoked from syscall_exit_to_user_mode()
- */
-static inline void arch_syscall_exit_tracehook(struct pt_regs *regs, bool step);
-
-#ifndef arch_syscall_exit_tracehook
-static inline void arch_syscall_exit_tracehook(struct pt_regs *regs, bool step)
-{
-	ptrace_report_syscall_exit(regs, step);
-}
-#endif
-
 /**
  * exit_to_user_mode - Fixup state when exiting to user mode
  *
@@ -347,7 +308,7 @@ void syscall_exit_to_user_mode_work(struct pt_regs *regs);
  *	- rseq syscall exit
  *      - audit
  *	- syscall tracing
- *	- tracehook (single stepping)
+ *	- ptrace (single stepping)
  *
  *  2) Preparatory work
  *	- Exit to user mode loop (common TIF handling). Invokes
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index f52e57c4d6d8..f0b1daa1e8da 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -59,7 +59,7 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
 
 	/* Handle ptrace */
 	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
-		ret = arch_syscall_enter_tracehook(regs);
+		ret = ptrace_report_syscall_entry(regs);
 		if (ret || (work & SYSCALL_WORK_SYSCALL_EMU))
 			return -1L;
 	}
@@ -253,7 +253,7 @@ static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
 
 	step = report_single_step(work);
 	if (step || work & SYSCALL_WORK_SYSCALL_TRACE)
-		arch_syscall_exit_tracehook(regs, step);
+		ptrace_report_syscall_exit(regs, step);
 }
 
 /*
-- 
2.29.2

