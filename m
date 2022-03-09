Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5099C352B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 16:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237291AbiCIQsv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 11:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238172AbiCIQbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:31:23 -0500
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC56A19416E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 08:25:44 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:35736)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nRz84-00CN9i-Og; Wed, 09 Mar 2022 09:25:36 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:34572 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nRz83-005hAS-Om; Wed, 09 Mar 2022 09:25:36 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Wed,  9 Mar 2022 10:24:47 -0600
Message-Id: <20220309162454.123006-6-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
References: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nRz83-005hAS-Om;;;mid=<20220309162454.123006-6-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/sct7WF471VqTYi29XPbFVbpflqmi3YZs=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 06/13] task_work: Remove unnecessary include from posix_timers.h
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Break a header file circular dependency by removing the unnecessary
include of task_work.h from posix_timers.h.

sched.h -> posix-timers.h
posix-timers.h -> task_work.h
task_work.h -> sched.h

Add missing includes of task_work.h to:
arch/x86/mm/tlb.c
kernel/time/posix-cpu-timers.c

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/mm/tlb.c              | 1 +
 include/linux/posix-timers.h   | 1 -
 kernel/time/posix-cpu-timers.c | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index a6cf56a14939..6eb4d91d5365 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -9,6 +9,7 @@
 #include <linux/cpu.h>
 #include <linux/debugfs.h>
 #include <linux/sched/smt.h>
+#include <linux/task_work.h>
 
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 5bbcd280bfd2..83539bb2f023 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -6,7 +6,6 @@
 #include <linux/list.h>
 #include <linux/alarmtimer.h>
 #include <linux/timerqueue.h>
-#include <linux/task_work.h>
 
 struct kernel_siginfo;
 struct task_struct;
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 96b4e7810426..9190d9eb236d 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -15,6 +15,7 @@
 #include <linux/workqueue.h>
 #include <linux/compat.h>
 #include <linux/sched/deadline.h>
+#include <linux/task_work.h>
 
 #include "posix-timers.h"
 
-- 
2.29.2

