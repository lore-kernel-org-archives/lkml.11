Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B34C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Apr 2022 23:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbiDIXok (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Apr 2022 19:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiDIXoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 19:44:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED52358834;
        Sat,  9 Apr 2022 16:42:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A59A4ED1;
        Sat,  9 Apr 2022 16:42:28 -0700 (PDT)
Received: from airbuntu (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 178323F5A1;
        Sat,  9 Apr 2022 16:42:25 -0700 (PDT)
Date:   Sun, 10 Apr 2022 00:42:24 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ed Tsai <ed.tsai@mediatek.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH v3 2/2] sched/tracing: Report TASK_RTLOCK_WAIT tasks as
 TASK_UNINTERRUPTIBLE
Message-ID: <20220409234224.q57dr43bpcll3ryv@airbuntu>
References: <20220120162520.570782-1-valentin.schneider@arm.com>
 <20220120162520.570782-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220120162520.570782-3-valentin.schneider@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC stable

On 01/20/22 16:25, Valentin Schneider wrote:
> TASK_RTLOCK_WAIT currently isn't part of TASK_REPORT, thus a task blocking
> on an rtlock will appear as having a task state == 0, IOW TASK_RUNNING.
> 
> The actual state is saved in p->saved_state, but reading it after reading
> p->__state has a few issues:
> o that could still be TASK_RUNNING in the case of e.g. rt_spin_lock
> o ttwu_state_match() might have changed that to TASK_RUNNING
> 
> As pointed out by Eric, adding TASK_RTLOCK_WAIT to TASK_REPORT implies
> exposing a new state to userspace tools which way not know what to do with
> them. The only information that needs to be conveyed here is that a task is
> waiting on an rt_mutex, which matches TASK_UNINTERRUPTIBLE - there's no
> need for a new state.
> 
> Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

Any objection for this to be picked up by stable? We care about Patch 1 only in
this series for stable, but it seems sensible to pick this one too, no strong
feeling if it is omitted though.

AFAICT it seems the problem dates back since commit:

	1593baab910d ("sched/debug: Implement consistent task-state printing")

or even before. I think v4.14+ is good enough.

Thoughts?

Thanks!

--
Qais Yousef
