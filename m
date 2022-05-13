Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DAAC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 May 2022 19:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377939AbiEMT1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 May 2022 15:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383889AbiEMTZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 15:25:59 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B833206F
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 12:23:28 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id j2so17047340ybu.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 12:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WHAh9UufUB89p8wrDSbhPz5384xLkBNDZz0dQdBYF7w=;
        b=lzOWB3xzKxDXToluzqEM8In7qs9nfEIq4A+hD23ppM1L9D+w+ttUmJo9nF5Ucve+np
         wwWPLsvWyi+xqnCJlI8UxQQbIu4It6PhtRR3brdWTSFBnWxgDS4tV/sjam/KKT9isess
         nTuLbzf6ppc66fRwL3EY9mPWNOCoytqbX7qs/kaDiF5iPxQtD8kl3JFpz6eDTitKPdU2
         JtJ5Rcv6H+3V3PXbqj8ktFcl4u2Ktlmd2riekIvfHukQTKWSQwYRfqepHaQN4voLcMT6
         InBxVMEZVT+ZYaknIyWBuejWIBFcAdh3XZp6vH1P6po1buBUh6ogeQTEDzZ8wcvPdHzw
         KkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WHAh9UufUB89p8wrDSbhPz5384xLkBNDZz0dQdBYF7w=;
        b=qr4N7i8i/Y7DkXwYc/ozPwZkDRGIn80FY5GvZQpJGNOS1WMzAS+7o7rjJ4PGmfrKJ0
         HqbFEjXV2hkge59T3xU3Hh/NbUgl0YtWJ4jemtAkRGx/75XnB4tzxzNzKZt8br2FNbK5
         aIoN4oH6KSHoPlxvW5s4aWxiszjQHDqTjkRzfXb/6hrvnx7NyxPTybZnXEJZ+ByICNQZ
         7X30ygYHYLZfxGz5OU+fG9AFV7ZHSN/lWlf/9SlM/5vkYo61Xg40ELhLyVV3MaRbaidU
         Xrwo7omKcQ/sfbfQ5Vthxwi2mkTcD3V/c0J+ptQR+oWoZBWxae+2He/cSNJbUn/DA9bk
         lrRw==
X-Gm-Message-State: AOAM532nso7yt0rBdDiApzCD9b4U1rDsJ1tTMw7lv4A1ID90KO86k0fj
        293mBL80BCeeVJj0QQ5ONHy9Vsu/jFYRr9Uow5hu+Q==
X-Google-Smtp-Source: ABdhPJxfsPolrviPdxw1scwQ72GcAsWL/IeJZed2re0GEwXL20XCfMisCbW6LFUT/N7307ygKbUy0NYLDVxNPifJ57A=
X-Received: by 2002:a25:9348:0:b0:64b:4f09:4cb6 with SMTP id
 g8-20020a259348000000b0064b4f094cb6mr6464930ybo.120.1652469807764; Fri, 13
 May 2022 12:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220513005427.2507335-1-joshdon@google.com> <Yn3JTpXhWRTeahyG@slm.duckdns.org>
In-Reply-To: <Yn3JTpXhWRTeahyG@slm.duckdns.org>
From:   Josh Don <joshdon@google.com>
Date:   Fri, 13 May 2022 12:23:16 -0700
Message-ID: <CABk29Nv=J_ZUnDTkRhwdQop=REr_XDGjJxn_zVy4kBqwx8K57w@mail.gmail.com>
Subject: Re: [PATCH] sched/core: add forced idle accounting for cgroups
To:     Tejun Heo <tj@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Cruz Zhao <CruzZhao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Tejun,

On Thu, May 12, 2022 at 7:58 PM Tejun Heo <tj@kernel.org> wrote:
>
> On Thu, May 12, 2022 at 05:54:27PM -0700, Josh Don wrote:
> > 4feee7d1260 previously added per-task forced idle accounting. This patch
> > extends this to also include cgroups.
> >
> > rstat is used for cgroup accounting, except for the root, which uses
> > kcpustat in order to bypass the need for doing an rstat flush when
> > reading root stats.
> >
> > Only cgroup v2 is supported. Similar to the task accounting, the cgroup
> > accounting requires that schedstats is enabled.
>
> We've been collecting scheduler stats in cgroup core so that we always have
> them available whether cpu controller is enabled or not. There's nothing
> actually specific to cpu controller, right? Would it make sense to collect
> the cpu core stats the same way as the rest of scheduler stats?

Yea, that's right, this doesn't require the cpu controller to be
enabled. Are you suggesting to add a new field to cgroup_base_stat?

One other weird artifact of collecting forceidle time is that a cpu
may account it on behalf of its hyperthread sibling. Currently, the
core rstat code always accounts to the current cpu's percpu rstat
field. I can add an accounting function to support writes to a
different cpu's field, in order to make sure that the per-cpu totals
are correct (the forceidle accounting code holds rq->__lock, which
protects all HT siblings of a core). percpu totals aren't currently
exported in cgroup v2, but this is useful information that we'll
consume, so it would be nice to keep it accurate.

Best,
Josh
