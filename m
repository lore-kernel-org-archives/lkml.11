Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81621C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Apr 2022 05:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357776AbiD0FFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Apr 2022 01:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240085AbiD0FFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 01:05:50 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CE975226
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 22:02:39 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id g3so583102pgg.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 22:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VlpEDtcvA+To0Ed3cwb9iScxFZaMjp5cfRG/gTpfLho=;
        b=heaGRX2MBNx+YN1imPTz3HhCOViVeBMHIdVlwdrhyB8JEFeDwmSLYtRiZlAyB2ePWZ
         CaFKJp0ZCmYnEExgXzGbpvMQvUfMhy657rqfL1EpSN1h7CaaYEsLJrUHmkEkwJZ77Zn/
         xAvPQCxXNom9qF8FO3WkWUA5if3rMbKrKAh3LNtPRh3XZkSTL1aoLuQVjbXS2jn/uzsV
         rhRVhDcPdM0U3QPBTQBrrXEwzVfUo2eIaoUdCIAwL4pS0s4CEiIZnOO/AoYdrBOlzhlS
         f3QA8QtVgFi05KJhpB+K5nETGtMo1BBhOsjvj/zKaDkLcuCooTA3cCitJ64+tA/69241
         UkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VlpEDtcvA+To0Ed3cwb9iScxFZaMjp5cfRG/gTpfLho=;
        b=hh7gFf05YhJy3KPO/AQGcXXTJhxYsFkSwMMQM/aI8SO5r+nwwhgerLTkIC+OqzMEAG
         EmFnpv2JpcL+2qW3MLDDAhiZli1qOa9mw8FoKcqppUGSiBTRrSDC4eqTAsnx/khdcO0q
         1C7PH2jAtWb3dMalc1VUGawW1VLjH5YxwlPOinKQ8htLH3q6RuNUAibJpTK0MwHZvh1x
         yOajVmlbeOR4TmHeOKJCTAZSvRigR6nTLZQxzglkkUdCh41I24bdf/khI3On5KAgoezM
         iQlAKGDya4b0ntcyU3WO+PI5mhhW8+tx6lNYlhMptLxSsLBIB2ozJMOoNommLARWpFyf
         qdbg==
X-Gm-Message-State: AOAM530PQrkTgeqlrSabWrRxYESHdTiL0QDoLqryr92JKb8bqCgVcUGj
        rjRlVYq1RxhaiXC42ll7c20/2EelyoSp62y/M5y1Cg==
X-Google-Smtp-Source: ABdhPJyALh4fvlb0O6nAb99jtMwkx94OVbaXwL9Zh6eVK/Dd3FonRJEwBkLgV93oxKxkgSq3EeMv9vgGg2HRVORhRLg=
X-Received: by 2002:a63:fd07:0:b0:3aa:1cd9:194f with SMTP id
 d7-20020a63fd07000000b003aa1cd9194fmr22594340pgh.509.1651035759004; Tue, 26
 Apr 2022 22:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220420055807.GA16310@xsang-OptiPlex-9020> <43598597-72e1-6750-9bee-031fd463fc3b@intel.com>
In-Reply-To: <43598597-72e1-6750-9bee-031fd463fc3b@intel.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 26 Apr 2022 22:02:28 -0700
Message-ID: <CALvZod4_vNWYxzGR3BksZYgoti-9hOioMGwF2UVRnwcAGpFqXA@mail.gmail.com>
Subject: Re: [memcg] a8c49af3be: hackbench.throughput -13.7% regression
To:     Yin Fengwei <fengwei.yin@intel.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yin,

On Tue, Apr 26, 2022 at 7:53 PM Yin Fengwei <fengwei.yin@intel.com> wrote:
>
[...]
>
> If I comment out one line added by the commit <a8c49af3be> :
> static void memcg_account_kmem(struct mem_cgroup *memcg, int nr_pages)
> {
>         /* mod_memcg_state(memcg, MEMCG_KMEM, nr_pages); */  <--- comment out this line.

Can you to comment out the following block instead of the above line
and see if there is any impact?

>         if (!cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
>                 if (nr_pages > 0)
>                         page_counter_charge(&memcg->kmem, nr_pages);
>                 else
>                         page_counter_uncharge(&memcg->kmem, -nr_pages);
>         }
> }
>
