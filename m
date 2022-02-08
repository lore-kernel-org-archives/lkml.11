Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE93C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 23:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238664AbiBHXwA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 18:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236600AbiBHXv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 18:51:58 -0500
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCBEC061576;
        Tue,  8 Feb 2022 15:51:56 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id i34so1030632lfv.2;
        Tue, 08 Feb 2022 15:51:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JXBA9Bf6g5bwrheDyWU+pJqTnLEiYG/XMhVWfsgYsuI=;
        b=JxeB+WsaL82CArm1yXDgKHNLFOa+1i63KJSWgKqoHndsVUREuQwvB08kAOEKT7RPD6
         n8lPk4Ba6YD90mZxGiQGE5AOACpbDz2hZd3khUoVVjz4FkuGQjbzv3MxoP4Pl+Sy3X+e
         XKMcOaypgJO9xrPAMW6W1F+4cP13NwyMoJdjFGNmfkpLb4jz3aX/tPWTB/wNJUNJ6wkw
         v9moiB/+UAy+8jmoZPbDsRBrUVdRGefN4wbkBS7Biq6PwOSJnzjuEgU8V8sK6utHscad
         1ZokzT3/Qi/yPWVapRUemLpkgsTSIKTQIBnIgQlypSZ1RKs97qN+JU8nxR3R30VbrmOl
         QwEA==
X-Gm-Message-State: AOAM533RpaS83poIp2bTIPU2gfbKO1YbM4kTU7Y56r7vzyoGNqZbJMWP
        kQyXXys/wIB/8Ym1erLksPV3eE9cL/hlneuq+C4=
X-Google-Smtp-Source: ABdhPJyzRDsgErMiiKVoZ/UAFL3OnJ9rGziwDnv+IxwH5Xu7WN0ZYCjD+CwNuzPFt5GJLTQdxZ0aa3fbqBQPpHf/euY=
X-Received: by 2002:ac2:4bc1:: with SMTP id o1mr4565388lfq.528.1644364314961;
 Tue, 08 Feb 2022 15:51:54 -0800 (PST)
MIME-Version: 1.0
References: <20220208184208.79303-1-namhyung@kernel.org> <20220208184208.79303-3-namhyung@kernel.org>
 <YgK6k4TXnRbm02dh@slm.duckdns.org> <CAM9d7cgKLycpFuXq0VgC=ADtAipXtKdfRcDqvZwMrNBz7hXd7A@mail.gmail.com>
In-Reply-To: <CAM9d7cgKLycpFuXq0VgC=ADtAipXtKdfRcDqvZwMrNBz7hXd7A@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 8 Feb 2022 15:51:43 -0800
Message-ID: <CAM9d7cgFHxiru+1_-1_nVvgwE0dHdKGR-QS6AAVdAo0Hf0-mLA@mail.gmail.com>
Subject: Re: [PATCH 02/12] cgroup: rstat: Make cgroup_rstat_cpu_lock name readable
To:     Tejun Heo <tj@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 8, 2022 at 11:16 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Tejun,
>
> On Tue, Feb 8, 2022 at 10:46 AM Tejun Heo <tj@kernel.org> wrote:
> >
> > On Tue, Feb 08, 2022 at 10:41:58AM -0800, Namhyung Kim wrote:
> > > The raw_spin_lock_init() uses the argument to name its lockdep map.
> > > But passing per_cpu_ptr() macro directly makes it a very very long
> > > name as it expanded like below:
> > >
> > >   ({ do { const void *__vpp_verify = (typeof((&cgroup_rstat_cpu_lock) ...
> > >
> > > Let's fix it by passing a local variable instead.  With this change,
> > > the name now looks like:
> > >
> > >   cgrp_rstat_cpu_lock
> > >
> > > Cc: Tejun Heo <tj@kernel.org>
> > > Cc: Zefan Li <lizefan.x@bytedance.com>
> > > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > > Cc: cgroups@vger.kernel.org
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> >
> > Acked-by: Tejun Heo <tj@kernel.org>
>
> Thanks!
>
> >
> > but maybe add a comment explaining what's going on?
>
> Sure, I'll add the comment.

Actually it depends on CONFIG_DEBUG_SPINLOCK.
If it's enabled, the name looks fine.  But if not, the macro
expansion would happen and generate the long name.

Thanks,
Namhyung
