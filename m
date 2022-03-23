Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82289C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 15:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245243AbiCWPfI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 11:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245188AbiCWPeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:34:36 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBBA1C1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 08:33:03 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1648049581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aF3Mslkri/nAJdWJHWopR/qwkkYDeoi5D+QsOOTejFE=;
        b=nNAzpZbKSwmLx4A2amh2xH45n/jkeaQtW9aDxERhBqdxXr0WWfhl/Px1TE/xZY0Xkbi6Cq
        K9yC5jBZIQ5+7PE8DIQinb4t2A03pyiAVjcmTRtiHfOzC2EaxLrC2XbgByndT7rP7lWvKR
        VFe3EK68JHwPi7qycD8mUFa0N2Tj/DE=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Mark Rutland <mark.rutland@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 0/4] kasan, arm64, scs, stacktrace: collect stack traces from Shadow Call Stack
Date:   Wed, 23 Mar 2022 16:32:51 +0100
Message-Id: <cover.1648049113.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

kasan, arm64, scs, stacktrace: collect stack traces from Shadow Call Stack

Currently, KASAN always uses the normal stack trace collection routines,
which rely on the unwinder, when saving alloc and free stack traces.

Instead of invoking the unwinder, collect the stack trace by copying
frames from the Shadow Call Stack whenever it is enabled. This reduces
boot time by 30% for all KASAN modes when Shadow Call Stack is enabled.

Stack staces are collected from the Shadow Call Stack via a new
stack_trace_save_shadow() interface.

Note that the frame of the interrupted function is not included into
the stack trace, as it is not yet saved on the SCS when an interrupt
happens.

---

To deal with this last thing, we could save the interrupted frame address
in another per-CPU variable. I'll look into implementing this for v3.

I decided to postpone the changes to stack depot that avoid copying
frames twice until a planned upcoming update for stack depot.

Changes v1->v2:
- Provide a kernel-wide stack_trace_save_shadow() interface for collecting
  stack traces from shadow stack.
- Use ptrauth_strip_insn_pac() and READ_ONCE_NOCHECK, see the comments.
- Get SCS pointer from x18, as per-task value is meant to save the SCS
  value on CPU switches.
- Collect stack frames from SDEI and IRQ contexts.

Andrey Konovalov (4):
  stacktrace: add interface based on shadow call stack
  arm64, scs: save scs_sp values per-cpu when switching stacks
  arm64: implement stack_trace_save_shadow
  kasan: use stack_trace_save_shadow

 arch/Kconfig                       |  6 +++
 arch/arm64/Kconfig                 |  1 +
 arch/arm64/include/asm/assembler.h | 12 +++++
 arch/arm64/include/asm/scs.h       | 13 ++++-
 arch/arm64/kernel/entry.S          | 28 ++++++++--
 arch/arm64/kernel/irq.c            |  4 +-
 arch/arm64/kernel/sdei.c           |  5 +-
 arch/arm64/kernel/stacktrace.c     | 83 ++++++++++++++++++++++++++++++
 include/linux/stacktrace.h         | 15 ++++++
 kernel/stacktrace.c                | 21 ++++++++
 mm/kasan/common.c                  |  9 ++--
 11 files changed, 183 insertions(+), 14 deletions(-)

-- 
2.25.1

