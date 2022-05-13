Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12FFC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 May 2022 17:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382954AbiEMRXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 May 2022 13:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376461AbiEMRXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 13:23:48 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0906D53A7A
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:23:48 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d22so8564092plr.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pUiCnPMeV2tewEXDSR1Opfl8CW/W1nTXt/fBcyuE7po=;
        b=hcbrT8LB9KtUyOFhJcjNGDoACadQCvR45e8T6zhTyidWst7gm9QCPlPUMus2qyKZO5
         F5DqklOOcurOuJJoDyNyaahuz9kll92/JgnSl7AlqgPH+K3Sn2fBXIsuvf7m/+R6yAVS
         fsGK3TwUuxHbSqM+peiMHJozwxnh0TRDv3ZGQTeyAIlOMdMVBvwteTZ4PytPmR9t47Gg
         pqGrxwTsmpv7IbPbGbuf/rmrhjr8qRe8wpa4F75swNWUD2SfEYFj+qQV2DV/gexKRIvo
         8snEpImCqQT57ffaUneyHTR7IkLcLcdzbaRzu3MoseaxEL7zq3AKDZum93Mv0C+hXL9+
         x1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pUiCnPMeV2tewEXDSR1Opfl8CW/W1nTXt/fBcyuE7po=;
        b=Wc0TgOOVylb07zIYvqo/t6aUWYH9Ip2h/fZ7OfneHkjRDIOBGkAQOJBRuE+0qIMA+x
         v37m/0vu8iipDmvjoZulWLDyZgtVmhZ+TEFfVI3aqw2YQsYm5RT5qn9FJB4kPYgYLQEl
         I+Rl/0p9gKaaa4IoGx/3BrdKTL14Y32maKjI++5ifXYFkdiyKR1SqPeCTSpfEDChXgni
         3nw++S4hmtHEDvOnlYx4Od3u5/4cBLm47J9m4P/nktFmbyLhDLZS2D+tOPSbdogPoQiz
         Z+26iRZ6zyvZiFo3ah3ocPANHPi/gt7F49M9+XTBa+AL9ndnus77Zuq4fMbFqSbobpuz
         KMMA==
X-Gm-Message-State: AOAM5300zrbtQ/i5VeBMWTYk/q7QqJUInK7bK/S4NqhESVmJFogWte52
        uqbVnDEl7qAKltoAQzhhJ78qlgMe7iSrxHsUA+bPYw==
X-Google-Smtp-Source: ABdhPJz4VHbNlIGbH/16c9aEUEopLMQoK6LkB7d36n7lf29oYijqqNLTzk2YOn+i0DI+nxCAjpyhWmReuAOUVN9lSMM=
X-Received: by 2002:a17:902:b094:b0:15c:dee8:74c8 with SMTP id
 p20-20020a170902b09400b0015cdee874c8mr5479352plr.6.1652462627392; Fri, 13 May
 2022 10:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220510152847.230957-1-hannes@cmpxchg.org> <20220510152847.230957-7-hannes@cmpxchg.org>
In-Reply-To: <20220510152847.230957-7-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 13 May 2022 10:23:36 -0700
Message-ID: <CALvZod6kBZZFfD6Y5p_=9TMJr8P-vU_77NTq048wGUDr0wTv0Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] zswap: memcg accounting
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Minchan Kim <minchan@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 8:29 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
[...]
> +void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size)
> +{
> +       struct mem_cgroup *memcg;
> +
> +       VM_WARN_ON_ONCE(!(current->flags & PF_MEMALLOC));
> +
> +       /* PF_MEMALLOC context, charging must succeed */
)
Instead of these warnings and comment why not just explicitly use
memalloc_noreclaim_[save|restore]() ?

> +       if (obj_cgroup_charge(objcg, GFP_KERNEL, size))

Can we please make this specific charging an opt-in feature or at
least provide a way to opt-out? This will impact users/providers where
swap is used transparently (in terms of memory usage). Also do you
want this change for v1 users as well?

> +               VM_WARN_ON_ONCE(1);
> +
> +       rcu_read_lock();
> +       memcg = obj_cgroup_memcg(objcg);
> +       mod_memcg_state(memcg, MEMCG_ZSWAP_B, size);
> +       mod_memcg_state(memcg, MEMCG_ZSWAPPED, 1);
> +       rcu_read_unlock();
> +}
> +
