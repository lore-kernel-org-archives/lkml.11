Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65680ECAAD2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Aug 2022 01:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiH3BoI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Aug 2022 21:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH3BoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 21:44:05 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169E27CB49
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 18:44:05 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 142so9901106pfu.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 18:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=kvfKUYf9OUfq0ppnWYvMirHqrPbNPptxti+/5ivJPww=;
        b=MmBov6sVKeRbWTDJmtwo/KPAoYKuMuoDiW+gGCoZu1M8XEfhpibgN9L+QakXqVPgst
         Khvyo3008hwdb+ma+9dA6rrVAIc+w0IBjO6NTe9CLmfwuYHsGR0R3sE638qqCPs6lnoP
         xetEHjppOnbkujHoAHGo4h+flx0jB9tVj2WVQ2/jvcrx0U1Hm6UjQf6DvoAqeRhboYNc
         ZVRGkHCD5n845PVA7RfYP625eICYeGcpKA2xeC9cZq13wtj3GKyQRBozdBlZklArxk1x
         XRtL/MsjpzGm8qe9Kpx5AgtUBr+G2HKWBvCPN3pDNLKcH9qPqyuG8yoood4Rn1qHA7Qm
         khQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=kvfKUYf9OUfq0ppnWYvMirHqrPbNPptxti+/5ivJPww=;
        b=BjXDgIRW2q9jImpv+0+vyki9xr1d6OjLjOl3qlLOitByQbhfUlucrRZHT8QTvQ0OgP
         1LOhitmTIY/SKnJqLMMEH3+UenVEIDXnwGY5LqtgzAAWITSo8jmPdlJA4Z7R8yhV9v6U
         3MVAwDETkx/gC94gNzQ+Eb22OXPFNmED+w2c+OvgiyB8WXsbGgZZQ4A8RIGEAuvMKkoV
         x1bpR0P5tLMx8NKdeyX/76+HENly3oY7WwtDOts5JgcQvVNHxnGHauxbLkY3FoP8+6qm
         Wt5it+O1OvDY8lcJ5JuqJ5BkpGRYmjKovfAfhh3WVwRCHZtXmr4ptlDjEmjgPjDUvB4O
         kE7w==
X-Gm-Message-State: ACgBeo3AxR6tTYouiW1+E2o4dpB6VpxzovlrdUYPWqxhrl9sJ3Yvnj74
        5yObIoMSuWqycmJIdsR4qs1WmQM2BP0=
X-Google-Smtp-Source: AA6agR6k4OtdOcWngNOKmbP/OzxxmbtTW/XiZ1/SA3uQNF2MC6/pcVzFwld2td8Z1fbda/u8x3KBZw==
X-Received: by 2002:a63:221f:0:b0:41f:12e6:105b with SMTP id i31-20020a63221f000000b0041f12e6105bmr15767361pgi.185.1661823843951;
        Mon, 29 Aug 2022 18:44:03 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id v14-20020aa799ce000000b00535faa9d6f2sm7976038pfi.53.2022.08.29.18.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 18:44:03 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <brauner@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 0/4] seccomp: add the synchronous mode for seccomp_unotify
Date:   Mon, 29 Aug 2022 18:43:52 -0700
Message-Id: <20220830014356.5364-1-avagin@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

seccomp_unotify allows more privileged processes does actions on behalf
of less privileged processes.

In many cases, the workflow is fully synchronous. It means a target
process triggers a system call and passes controls to a supervisor
process that handles the system call and returns controls to the target
process. In this context, "synchronous" means that only one process is
running and another one is waiting.

The new WF_CURRENT_CPU flag advises the scheduler to move the wakee to
the current CPU. For such synchronous workflows, it makes context
switches a few times faster.

Right now, each interaction takes 12µs. With this patch, it takes about
3µs.

Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Peter Oskolkov <posk@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tycho Andersen <tycho@tycho.pizza>
Cc: Will Drewry <wad@chromium.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>

Andrei Vagin (3):
  seccomp: don't use semaphore and wait_queue together
  sched: add a few helpers to wake up tasks on the current cpu
  seccomp: add the synchronous mode for seccomp_unotify

Peter Oskolkov (1):
  sched/umcg: add WF_CURRENT_CPU and externise ttwu

 include/linux/completion.h   |  1 +
 include/linux/swait.h        |  1 +
 include/linux/wait.h         |  3 ++
 include/uapi/linux/seccomp.h |  4 ++
 kernel/sched/completion.c    | 12 ++++++
 kernel/sched/core.c          |  5 +--
 kernel/sched/fair.c          |  4 ++
 kernel/sched/sched.h         | 13 ++++---
 kernel/sched/swait.c         | 11 ++++++
 kernel/sched/wait.c          |  5 +++
 kernel/seccomp.c             | 73 +++++++++++++++++++++++++++++-------
 11 files changed, 110 insertions(+), 22 deletions(-)

-- 
2.37.2

