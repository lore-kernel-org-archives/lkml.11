Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DDCC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 16:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235684AbiCIQph (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 11:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238099AbiCIQbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:31:21 -0500
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F62192E35
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 08:25:39 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:33396)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nRz82-00329F-Jv; Wed, 09 Mar 2022 09:25:34 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:34572 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nRz81-005hAS-Gm; Wed, 09 Mar 2022 09:25:34 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Wed,  9 Mar 2022 10:24:46 -0600
Message-Id: <20220309162454.123006-5-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
References: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nRz81-005hAS-Gm;;;mid=<20220309162454.123006-5-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18M+LFl+3GrdoDApc9hc69jyTG2SyR/cMQ=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 05/13] ptrace: Remove tracehook_signal_handler
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two line function tracehook_signal_handler is only called from
signal_delivered.  Expand it inline in signal_delivered and remove it.
Just to make it easier to understand what is going on.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/Kconfig              |  1 -
 include/linux/tracehook.h | 17 -----------------
 kernel/signal.c           |  3 ++-
 3 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index a517a949eb1d..6382520ef0a5 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -219,7 +219,6 @@ config TRACE_IRQFLAGS_SUPPORT
 #	CORE_DUMP_USE_REGSET	#define'd in linux/elf.h
 #	TIF_SYSCALL_TRACE	calls ptrace_report_syscall_{entry,exit}
 #	TIF_NOTIFY_RESUME	calls tracehook_notify_resume()
-#	signal delivery		calls tracehook_signal_handler()
 #
 config HAVE_ARCH_TRACEHOOK
 	bool
diff --git a/include/linux/tracehook.h b/include/linux/tracehook.h
index 819e82ac09bd..b77bf4917196 100644
--- a/include/linux/tracehook.h
+++ b/include/linux/tracehook.h
@@ -52,23 +52,6 @@
 struct linux_binprm;
 
 
-/**
- * tracehook_signal_handler - signal handler setup is complete
- * @stepping:		nonzero if debugger single-step or block-step in use
- *
- * Called by the arch code after a signal handler has been set up.
- * Register and stack state reflects the user handler about to run.
- * Signal mask changes have already been made.
- *
- * Called without locks, shortly before returning to user mode
- * (or handling more signals).
- */
-static inline void tracehook_signal_handler(int stepping)
-{
-	if (stepping)
-		ptrace_notify(SIGTRAP);
-}
-
 /**
  * set_notify_resume - cause tracehook_notify_resume() to be called
  * @task:		task that will call tracehook_notify_resume()
diff --git a/kernel/signal.c b/kernel/signal.c
index 38602738866e..0e0bd1c1068b 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2898,7 +2898,8 @@ static void signal_delivered(struct ksignal *ksig, int stepping)
 	set_current_blocked(&blocked);
 	if (current->sas_ss_flags & SS_AUTODISARM)
 		sas_ss_reset(current);
-	tracehook_signal_handler(stepping);
+	if (stepping)
+		ptrace_notify(SIGTRAP);
 }
 
 void signal_setup_done(int failed, struct ksignal *ksig, int stepping)
-- 
2.29.2

