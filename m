Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24890C43334
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jun 2022 19:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiFZTPU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jun 2022 15:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiFZTPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 15:15:17 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F15DF3A
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 12:15:16 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:48334)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o5Xiz-00ASkZ-SI; Sun, 26 Jun 2022 13:15:13 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:57732 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o5Xiy-008aSI-T2; Sun, 26 Jun 2022 13:15:13 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
References: <20220622140853.31383-1-pmladek@suse.com>
        <YraWWl+Go17uPOgR@mtj.duckdns.org>
        <CAHk-=wiC7rj1o7vTnYUPfD7YxAu09MZiZbahHqvLm9+Cgg1dFw@mail.gmail.com>
        <874k0863x8.fsf@email.froward.int.ebiederm.org>
        <CAHk-=wgTG2K3erROP19320zBN6BHVf0hRfXGdawkGR4gzrJN6w@mail.gmail.com>
        <CAHk-=whLsaRKaFKS0UffeCYYCVyP0bbiB4BTYTaXtScgu6R9yA@mail.gmail.com>
        <87pmiw1fy6.fsf@email.froward.int.ebiederm.org>
        <CAHk-=wiutNT47oNhyk_WvMj2qp4pehYFptXCUzW=u_2STLQiww@mail.gmail.com>
        <CAHk-=whX_=BNZ4kVEAu2NV3CMnhwsuYTyE65FQXUMx8VPNOAOA@mail.gmail.com>
Date:   Sun, 26 Jun 2022 14:14:45 -0500
In-Reply-To: <CAHk-=whX_=BNZ4kVEAu2NV3CMnhwsuYTyE65FQXUMx8VPNOAOA@mail.gmail.com>
        (Linus Torvalds's message of "Sat, 25 Jun 2022 16:48:38 -0700")
Message-ID: <87ilonuti2.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1o5Xiy-008aSI-T2;;;mid=<87ilonuti2.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/6ntGUKYDJC32bDb8alF2ElKoq9ehJkes=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 0/3] kthread: Stop using TASK_UNINTERRUPTIBLE
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Being silly I figured I would poke my nose in and see how much work it
is to never wake up kthreads until we are ready to use them.

This is my first draft at that and something that can hopefully shape
the conversation on how we want to fix things a little bit.

The big thing that needs to happen that I haven't implemented is that
kthread_run and kthread_run_on_cpu need to be uninlined and moved into
kthread.c.  This will allow them to call wake_up_new_task even from
modular code.

The handful of drivers that are using kthread_create_on_node by
extension need to be modified to use kthread_run or kthread_run_on_cpu.

Eric W. Biederman (3):
      kthread: Remove the flags argument from kernel_thread
      kthread: Replace kernel_thread with new_kthread
      kthread: Stop abusing TASK_UNINTERRUPTIBLE (INCOMPLETE)

 arch/arm/common/bL_switcher.c             |   2 +-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |   4 +-
 drivers/block/mtip32xx/mtip32xx.c         |   2 +-
 drivers/firmware/psci/psci_checker.c      |   2 +-
 drivers/firmware/stratix10-svc.c          |   4 +-
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c         |   2 +-
 drivers/scsi/bnx2i/bnx2i_init.c           |   2 +-
 drivers/scsi/qedi/qedi_main.c             |   2 +-
 include/linux/kthread.h                   |   4 +-
 include/linux/sched/task.h                |   2 +-
 init/main.c                               |   6 +-
 kernel/bpf/cpumap.c                       |   2 +-
 kernel/dma/map_benchmark.c                |   2 +-
 kernel/fork.c                             |   5 +-
 kernel/kthread.c                          | 120 +++++++++++++++---------------
 kernel/smpboot.c                          |   1 +
 kernel/workqueue.c                        |   2 +-
 net/core/pktgen.c                         |   2 +-
 net/sunrpc/svc.c                          |   2 +-
 19 files changed, 82 insertions(+), 86 deletions(-)

Eric
