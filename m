Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13041C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Feb 2022 15:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359519AbiBDPGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Feb 2022 10:06:07 -0500
Received: from foss.arm.com ([217.140.110.172]:50172 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353524AbiBDPGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:06:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA30A1396;
        Fri,  4 Feb 2022 07:06:04 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7734D3F774;
        Fri,  4 Feb 2022 07:06:02 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     ardb@kernel.org, bp@alien8.de, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, frederic@kernel.org,
        james.morse@arm.com, joey.gouly@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, peterz@infradead.org,
        tglx@linutronix.de, valentin.schneider@arm.com, will@kernel.org
Subject: [PATCH v2 0/7] arm64 / sched/preempt: support PREEMPT_DYNAMIC with static keys
Date:   Fri,  4 Feb 2022 15:05:50 +0000
Message-Id: <20220204150557.434610-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables PREEMPT_DYNAMIC on arm64. To do so, it adds a new
mechanism allowing the preemption functions to be enabled/disabled using
static keys rather than static calls, with architectures selecting
whether they use static calls or static keys.

With non-inline static calls, each function call results in a call to
the (out-of-line) trampoline which either tail-calls its associated
callee or performs an early return.

The key idea is that where we're only enabling/disabling a single
callee, we can inline this trampoline into the start of the callee,
using a static key to decide whether to return early, and leaving the
remaining codegen to the compiler. The overhead should be similar to
(and likely lower than) using a static call trampoline. Since most
codegen is up to the compiler, we sidestep a number of implementation
pain-points (e.g. things like CFI should "just work" as well as they do
for any other functions).

The bulk of the diffstat for kernel/sched/core.c is shuffling the
PREEMPT_DYNAMIC code later in the file, and the actual additions are
fairly trivial.

I've given this very light build+boot testing so far.

Since v1 [1]:
* Rework Kconfig text to be clearer
* Rework arm64 entry code
* Clarify commit messages.

[1] https://lore.kernel.org/all/20211109172408.49641-1-mark.rutland@arm.com/

Mark Rutland (7):
  sched/preempt: move PREEMPT_DYNAMIC logic later
  sched/preempt: refactor sched_dynamic_update()
  sched/preempt: simplify irqentry_exit_cond_resched() callers
  sched/preempt: decouple HAVE_PREEMPT_DYNAMIC from GENERIC_ENTRY
  sched/preempt: add PREEMPT_DYNAMIC using static keys
  arm64: entry: centralize premeption decision
  arm64: support PREEMPT_DYNAMIC

 arch/Kconfig                     |  37 +++-
 arch/arm64/Kconfig               |   1 +
 arch/arm64/include/asm/preempt.h |  16 +-
 arch/arm64/kernel/entry-common.c |  28 ++-
 arch/x86/Kconfig                 |   2 +-
 arch/x86/include/asm/preempt.h   |  10 +-
 include/linux/entry-common.h     |  15 +-
 include/linux/kernel.h           |   7 +-
 include/linux/sched.h            |  10 +-
 kernel/entry/common.c            |  22 +-
 kernel/sched/core.c              | 346 ++++++++++++++++++-------------
 11 files changed, 322 insertions(+), 172 deletions(-)

-- 
2.30.2

