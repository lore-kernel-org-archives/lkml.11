Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFC2C4332F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 16:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237087AbiCIQsn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 11:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238001AbiCIQbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:31:17 -0500
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B65192C8E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 08:25:30 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:58940)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nRz7u-008XLf-2X; Wed, 09 Mar 2022 09:25:26 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:34572 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nRz7t-005hAS-3k; Wed, 09 Mar 2022 09:25:25 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Wed,  9 Mar 2022 10:24:43 -0600
Message-Id: <20220309162454.123006-2-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
References: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nRz7t-005hAS-3k;;;mid=<20220309162454.123006-2-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18NPI0fwGnL/QDFI18nl9zROcIqRJPmxUU=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 02/13] ptrace/arm: Rename tracehook_report_syscall report_syscall
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the arm and arm64 code more concise and less confusing by
renaming the architecture specific tracehook_report_syscall to
report_syscall.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm/kernel/ptrace.c   | 7 +++----
 arch/arm64/kernel/ptrace.c | 7 +++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 43b963ea4a0e..e5aa3237853d 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -831,8 +831,7 @@ enum ptrace_syscall_dir {
 	PTRACE_SYSCALL_EXIT,
 };
 
-static void tracehook_report_syscall(struct pt_regs *regs,
-				    enum ptrace_syscall_dir dir)
+static void report_syscall(struct pt_regs *regs, enum ptrace_syscall_dir dir)
 {
 	unsigned long ip;
 
@@ -856,7 +855,7 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 	int scno;
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
-		tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
+		report_syscall(regs, PTRACE_SYSCALL_ENTER);
 
 	/* Do seccomp after ptrace; syscall may have changed. */
 #ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
@@ -897,5 +896,5 @@ asmlinkage void syscall_trace_exit(struct pt_regs *regs)
 		trace_sys_exit(regs, regs_return_value(regs));
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
-		tracehook_report_syscall(regs, PTRACE_SYSCALL_EXIT);
+		report_syscall(regs, PTRACE_SYSCALL_EXIT);
 }
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 39dbdfdc38d3..b7845575f86f 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1792,8 +1792,7 @@ enum ptrace_syscall_dir {
 	PTRACE_SYSCALL_EXIT,
 };
 
-static void tracehook_report_syscall(struct pt_regs *regs,
-				     enum ptrace_syscall_dir dir)
+static void report_syscall(struct pt_regs *regs, enum ptrace_syscall_dir dir)
 {
 	int regno;
 	unsigned long saved_reg;
@@ -1842,7 +1841,7 @@ int syscall_trace_enter(struct pt_regs *regs)
 	unsigned long flags = read_thread_flags();
 
 	if (flags & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
-		tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
+		report_syscall(regs, PTRACE_SYSCALL_ENTER);
 		if (flags & _TIF_SYSCALL_EMU)
 			return NO_SYSCALL;
 	}
@@ -1870,7 +1869,7 @@ void syscall_trace_exit(struct pt_regs *regs)
 		trace_sys_exit(regs, syscall_get_return_value(current, regs));
 
 	if (flags & (_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP))
-		tracehook_report_syscall(regs, PTRACE_SYSCALL_EXIT);
+		report_syscall(regs, PTRACE_SYSCALL_EXIT);
 
 	rseq_syscall(regs);
 }
-- 
2.29.2

