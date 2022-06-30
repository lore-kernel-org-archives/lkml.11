Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C95C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jun 2022 01:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiF3BM7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jun 2022 21:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiF3BM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 21:12:58 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E60840923
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 18:12:57 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id p14so16670839pfh.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 18:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vFGP9jKLqyRzd60npg9aDuu5nqMMDuznBntVVFZ6XeM=;
        b=FINzKCfeDl+UKugengjp6uE3KcYwdZiAw84pWVgrlz20BqPStzPIF0lJzZCK7+lg4Z
         QDkcbThVsL6+eXmto3QP8lc74CUGJSnqXFDJWUiEwRFE8+WNsBgDdVnwxEP9bJuptaD3
         C3CeZNNrTYfojfbsBuiLrJeNRnLzu/N5qran/A+5SqJPusABCycOfxi1N5P2tEyU9rLJ
         +VmsAayDP2GjiL09cJPE9shZGNTVubVqeCwcPINNcfQK6NQlTwgP/zYSf5IuuSFGltn+
         MIAHkcpcJOTsbuneIoYPvWyMLeevFtX3Q3EAqyf7UoR9YXiyjYFKMuW5MXzb4PQm0vbY
         u9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vFGP9jKLqyRzd60npg9aDuu5nqMMDuznBntVVFZ6XeM=;
        b=2NyPZ65JN5sCltRslAvCYW6rFG/54sO7Fl4XvCQKKi0XxRmo6b65RVyFnEwWKzEA+K
         DZlN8avnLcgyrzQLAqRqMEGdiLgpddTbU020afa1ORS3wCLinWWKcBZeCXCJY1wTaVO3
         BfR1QZWN+YRRg+fda6TG7ngYTvJcf/eErbe55kF/UnU2F5jEOLk79Lxoqro3s2GfXRAZ
         kvVjveFMvac/m7MPUGNgsJhCMC+OLOIbHyR/wnVRupoPm28TgAdyR20qJDv795DHw4aH
         Oyr+lTQIhpYX036gR8PtLtSknH5uu1m5CDZhtRsZMfWPTfE7HrvoUhvInfSusNVvL9bR
         jvSw==
X-Gm-Message-State: AJIora99EtgtOqLRNr1WZxtYIfYvdgGIP+p9yLCQNOzcVyWJrA4cPpNn
        Vurm5aK87qjgn3JpQfVybBfPRvG27b0r8wTyq44BKg==
X-Google-Smtp-Source: AGRyM1vxWR4CXhsqQ7bg8wi5fTGCKApMFsMb0ljldZ4k715UNFQi5FpIH+2opQjsvIcza6CivUsndpr/4E6qYAHz7LA=
X-Received: by 2002:a63:6cc8:0:b0:40d:e553:f200 with SMTP id
 h191-20020a636cc8000000b0040de553f200mr5146962pgc.166.1656551576894; Wed, 29
 Jun 2022 18:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <xm26fsjotqda.fsf@google.com> <20220629165542.da7fc8a2a5dbd53cf99572aa@linux-foundation.org>
In-Reply-To: <20220629165542.da7fc8a2a5dbd53cf99572aa@linux-foundation.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 29 Jun 2022 18:12:46 -0700
Message-ID: <CALvZod5KX7XEHR9h_jFHf5pJcYB+dODEeaLKrQLtSy9EUqgvWw@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH] epoll: autoremove wakers even more aggressively
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Benjamin Segall <bsegall@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Jason Baron <jbaron@akamai.com>,
        Khazhismel Kumykov <khazhy@google.com>, Heiher <r@hev.cc>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 4:55 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 15 Jun 2022 14:24:23 -0700 Benjamin Segall <bsegall@google.com> wrote:
>
> > If a process is killed or otherwise exits while having active network
> > connections and many threads waiting on epoll_wait, the threads will all
> > be woken immediately, but not removed from ep->wq. Then when network
> > traffic scans ep->wq in wake_up, every wakeup attempt will fail, and
> > will not remove the entries from the list.
> >
> > This means that the cost of the wakeup attempt is far higher than usual,
> > does not decrease, and this also competes with the dying threads trying
> > to actually make progress and remove themselves from the wq.
> >
> > Handle this by removing visited epoll wq entries unconditionally, rather
> > than only when the wakeup succeeds - the structure of ep_poll means that
> > the only potential loss is the timed_out->eavail heuristic, which now
> > can race and result in a redundant ep_send_events attempt. (But only
> > when incoming data and a timeout actually race, not on every timeout)
> >
>
> Thanks.  I added people from 412895f03cbf96 ("epoll: atomically remove
> wait entry on wake up") to cc.  Hopefully someone there can help review
> and maybe test this.
>
>

Thanks Andrew. Just wanted to add that we are seeing this issue in
production with real workloads and it has caused hard lockups.
Particularly network heavy workloads with a lot of threads in
epoll_wait() can easily trigger this issue if they get killed
(oom-killed in our case).
