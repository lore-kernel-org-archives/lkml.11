Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C54C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 16:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbiCIQoT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 11:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237990AbiCIQbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:31:17 -0500
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B49B19143B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 08:25:28 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:33250)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nRz7r-00327k-UR; Wed, 09 Mar 2022 09:25:23 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:34572 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nRz7q-005hAS-Qu; Wed, 09 Mar 2022 09:25:23 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Wed,  9 Mar 2022 10:24:42 -0600
Message-Id: <20220309162454.123006-1-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
References: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nRz7q-005hAS-Qu;;;mid=<20220309162454.123006-1-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19zLug7qOq1vqtHb4J0vYNTM2ZFZM4qWrQ=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 01/13] ptrace: Move ptrace_report_syscall into ptrace.h
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move ptrace_report_syscall from tracehook.h into ptrace.h where it
belongs.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/ptrace.h    | 27 +++++++++++++++++++++++++++
 include/linux/tracehook.h | 26 --------------------------
 2 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index 8aee2945ff08..91b1074edb4c 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -413,4 +413,31 @@ static inline void user_single_step_report(struct pt_regs *regs)
 extern int task_current_syscall(struct task_struct *target, struct syscall_info *info);
 
 extern void sigaction_compat_abi(struct k_sigaction *act, struct k_sigaction *oact);
+
+/*
+ * ptrace report for syscall entry and exit looks identical.
+ */
+static inline int ptrace_report_syscall(unsigned long message)
+{
+	int ptrace = current->ptrace;
+
+	if (!(ptrace & PT_PTRACED))
+		return 0;
+
+	current->ptrace_message = message;
+	ptrace_notify(SIGTRAP | ((ptrace & PT_TRACESYSGOOD) ? 0x80 : 0));
+
+	/*
+	 * this isn't the same as continuing with a signal, but it will do
+	 * for normal use.  strace only continues with a signal if the
+	 * stopping signal is not SIGTRAP.  -brl
+	 */
+	if (current->exit_code) {
+		send_sig(current->exit_code, current, 1);
+		current->exit_code = 0;
+	}
+
+	current->ptrace_message = 0;
+	return fatal_signal_pending(current);
+}
 #endif
diff --git a/include/linux/tracehook.h b/include/linux/tracehook.h
index 88c007ab5ebc..998bc3863559 100644
--- a/include/linux/tracehook.h
+++ b/include/linux/tracehook.h
@@ -51,32 +51,6 @@
 #include <linux/blk-cgroup.h>
 struct linux_binprm;
 
-/*
- * ptrace report for syscall entry and exit looks identical.
- */
-static inline int ptrace_report_syscall(unsigned long message)
-{
-	int ptrace = current->ptrace;
-
-	if (!(ptrace & PT_PTRACED))
-		return 0;
-
-	current->ptrace_message = message;
-	ptrace_notify(SIGTRAP | ((ptrace & PT_TRACESYSGOOD) ? 0x80 : 0));
-
-	/*
-	 * this isn't the same as continuing with a signal, but it will do
-	 * for normal use.  strace only continues with a signal if the
-	 * stopping signal is not SIGTRAP.  -brl
-	 */
-	if (current->exit_code) {
-		send_sig(current->exit_code, current, 1);
-		current->exit_code = 0;
-	}
-
-	current->ptrace_message = 0;
-	return fatal_signal_pending(current);
-}
 
 /**
  * tracehook_report_syscall_entry - task is about to attempt a system call
-- 
2.29.2

