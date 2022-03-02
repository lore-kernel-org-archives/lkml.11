Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280C1C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 04:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239453AbiCBEgf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Mar 2022 23:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239472AbiCBEg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 23:36:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E86B0D20
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 20:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=6pfakOYBTAGJXApeYSyam4vpJGARHkHxx5lbo6BGMVE=; b=UF5ZSlSqlDI0WKc+mMtKr8oUie
        5+Hxa6DGeOUccncsZpvQWXYItY5B+ni2rC+wMyjyTUOKAf5MD7MQW7s7/tpgqP6XeKM8OQ6q49Igq
        M7Qk5Pb9N6xXSqDCxr+RxknZgaMt6LfNYHSJ+T89bXM0MIIJOJkKep6wq8oDR28zbuUMrwYOjXiZ3
        wYmRW80MHJ1jMt6swQQeomvDz+swEstJXJckx9IOQxnijnbqdGZiWtnO/rGD/SRwyudfhDeCY8Sil
        tFvqimQ6+2uEFoJN13XB75JLPO8PyDrMj7yMSkVxjtYF4WmqCQnBeNm29O9rReeSe/VyNky5gsDOL
        5HPx1wfA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPGhR-00AF6x-Ns; Wed, 02 Mar 2022 04:34:53 +0000
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
Subject: [PATCH 00/19] Enable -Wshadow=local for kernel/sched
Date:   Wed,  2 Mar 2022 04:34:32 +0000
Message-Id: <20220302043451.2441320-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I thought I'd choose one of the more core parts of the kernel to
demonstrate the value of -Wshadow.  It found two places where there are
shadowed variables that are at least confusing.  For all I know they're
buggy and my resolution of these warnings is wrong.

The first 12 patches just untangle the unclean uses of __ret in wait.h
& friends.  Then 4 patches to fix problems in headers that are noticed
by kernel/sched.  Two patches fix the two places in kernel/sched/
with shadowed variables and the final patch adds -Wshadow=local to
the Makefile.

I'm quite certain this patch series isn't going in as-is.  But maybe
it'll inspire some patches that can go in.

Matthew Wilcox (Oracle) (19):
  wait: Parameterize the return variable to ___wait_event()
  swait: Parameterize the return variable to __swait_event_timeout()
  swait: Parameterize the return variable to
    __swait_event_interruptible_timeout()
  swait: Parameterize the return variable to
    __swait_event_idle_timeout()
  wait: Parameterize the return variable to __wait_event_timeout()
  wait: Parameterize the return variable to
    __wait_event_freezable_timeout()
  wait: Parameterize the return variable to
    __wait_event_interruptible_timeout()
  wait: Parameterize the return variable to __wait_event_idle_timeout()
  wait: Parameterize the return variable to
    __wait_event_idle_exclusive_timeout()
  wait: Parameterize the return variable to
    __wait_event_killable_timeout()
  wait: Parameterize the return variable to
    __wait_event_lock_irq_timeout()
  wait_bit: Parameterize the return variable to
    __wait_var_event_timeout()
  Add UNIQUE_ID
  wait: Add a unique identifier to ___wait_event()
  x86: Use a unique identifier in __WARN_FLAGS()
  x86: Pass a unique identifier to __xchg_op()
  sched/rt: Rename a shadowed variable
  sched/topology: Rename the cpu parameter
  sched: Enable -Wshadow=local

 arch/x86/include/asm/bug.h     |   4 +-
 arch/x86/include/asm/cmpxchg.h |   6 +-
 include/linux/compiler.h       |   1 +
 include/linux/swait.h          |  24 ++--
 include/linux/wait.h           | 223 ++++++++++++++++-----------------
 include/linux/wait_bit.h       |   9 +-
 kernel/sched/Makefile          |   1 +
 kernel/sched/rt.c              |   4 +-
 kernel/sched/topology.c        |   6 +-
 9 files changed, 138 insertions(+), 140 deletions(-)

-- 
2.34.1

