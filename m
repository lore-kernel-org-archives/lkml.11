Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA07C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jun 2022 16:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376633AbiFVQsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jun 2022 12:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359763AbiFVQrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:47:48 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D3837BE2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:47:11 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:37884)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o43VW-00AWlO-PX; Wed, 22 Jun 2022 10:47:10 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:57378 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o43VV-00FwIL-GT; Wed, 22 Jun 2022 10:47:10 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        bigeasy@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Robert O'Callahan <roc@pernos.co>, Kyle Huey <khuey@pernos.co>,
        Keno Fischer <keno@juliacomputing.com>
References: <20220421150248.667412396@infradead.org>
        <20220421150654.817117821@infradead.org>
        <87czhap9dy.fsf@email.froward.int.ebiederm.org>
        <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
        <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
        <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
        <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
        <87r13gd4xy.fsf_-_@email.froward.int.ebiederm.org>
Date:   Wed, 22 Jun 2022 11:47:02 -0500
In-Reply-To: <87r13gd4xy.fsf_-_@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Wed, 22 Jun 2022 11:43:37 -0500")
Message-ID: <875yksd4s9.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1o43VV-00FwIL-GT;;;mid=<875yksd4s9.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19r0/CpyEf7c9BvUdaOre1lAKO5rEMaStY=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 3/3] signal: Drop signals received after a fatal signal has
 been processed
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In 403bad72b67d ("coredump: only SIGKILL should interrupt the
coredumping task") Oleg modified the kernel to drop all signals that
come in during a coredump except SIGKILL, and suggested that it might
be a good idea to generalize that to other cases after the process has
received a fatal signal.

Semantically it does not make sense to perform any signal delivery
after the process has already been killed.

When a signal is sent while a process is dying today the signal is
placed in the signal queue by __send_signal and a single task of the
process is woken up with signal_wake_up, if there are any tasks that
have not set PF_EXITING.

Take things one step farther and have prepare_signal report that all
signals that come after a process has been killed should be ignored.
While retaining the historical exception of allowing SIGKILL to
interrupt coredumps.

Update the comment in fs/coredump.c to make it clear coredumps are
special in being able to receive SIGKILL.

This changes things so that a process stopped in PTRACE_EVENT_EXIT can
not be made to escape it's ptracer and finish exiting by sending it
SIGKILL.  That a process can be made to leave PTRACE_EVENT_EXIT and
escape it's tracer by sending the process a SIGKILL has been
complicating tracer's for no apparent advantage.  If the process needs
to be made to leave PTRACE_EVENT_EXIT all that needs to happen is to
kill the proceses's tracer.  This differs from the coredump code where
there is no other mechanism besides honoring SIGKILL to expedite the
end of coredumping.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/coredump.c   | 2 +-
 kernel/signal.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index ebc43f960b64..b836948c9543 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -354,7 +354,7 @@ static int zap_process(struct task_struct *start, int exit_code)
 	struct task_struct *t;
 	int nr = 0;
 
-	/* ignore all signals except SIGKILL, see prepare_signal() */
+	/* Allow SIGKILL, see prepare_signal() */
 	start->signal->flags = SIGNAL_GROUP_EXIT;
 	start->signal->group_exit_code = exit_code;
 	start->signal->group_stop_count = 0;
diff --git a/kernel/signal.c b/kernel/signal.c
index edb1dc9b00dc..369d65b06025 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -913,8 +913,9 @@ static bool prepare_signal(int sig, struct task_struct *p, bool force)
 		if (signal->core_state)
 			return sig == SIGKILL;
 		/*
-		 * The process is in the middle of dying, nothing to do.
+		 * The process is in the middle of dying, drop the signal.
 		 */
+		return false;
 	} else if (sig_kernel_stop(sig)) {
 		/*
 		 * This is a stop signal.  Remove SIGCONT from all queues.
-- 
2.35.3

