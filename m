Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B7DECAAA1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Aug 2022 15:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiH3Psl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Aug 2022 11:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiH3Psf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:48:35 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16458B6032
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 08:48:34 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id u22so11496123plq.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 08:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=hNllKNHOzYlzwLSe4h2WfwgKyDb/1zfxegYu4XxgzHs=;
        b=C044xLj4vEPLZD+B4wrql2rOXp3W3xRSPge7WntDuscQ/J/u8b5QjnygLEIDoiwW0w
         +Dr7VMrbhFYSom+qkV/1RH6bV8OqHsonOo+dMH06uEAdiE9MpOmSff/q38N7NnOLf5jh
         4iO7Sd9prXW2z+5O+5E8VFxQj/EOEAPtxfe/5f721t4uqRlgQ5ZUzz2nEB3lov3orfUc
         g8RGIo227gXxXORc/LABwv/4EoUnkCrewA6q5g2iiAwoHRRKI3Qo2avuC6EoK++3CpM1
         AtZxWmoBliHWQmxB42KsVhqecjdXYg28zH4/XcnHWZp0cuyC6DLuhG3nl6Rrg4lK6t8a
         0hpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hNllKNHOzYlzwLSe4h2WfwgKyDb/1zfxegYu4XxgzHs=;
        b=LhAGqIZ3sA0G7J2f1r47b/BDQkU9uTFWSqHXrEJmWA+oq0xZA9xrEzfloHSy/oX9fU
         vXHb+Jt0ur5mt0di4/AAOXmxd+WnfjewZ4MvhPCOdq4erbLnVUr3ozJiEeVdT6XAX8bv
         huh/1ZDxgp+oiiOIkBQ2tfdVPWP0JLaaKFrbafOPeZWukTF5NQAsYJgfIsK1WcjAHr6u
         zU1CVs9MubAUmwY/VtWR4r8JaoiPH6Az5VGHNE6h1QsIM0s2ZkK2637S2Nh6Pr5P90N2
         ERx3FVE+/59FlsUe9U+AV53SHamd6xPgDba7QKCUFQNHnXLP9AkXsLRmZde+LsqkdDKN
         HDyQ==
X-Gm-Message-State: ACgBeo3gql9LbdChG9j2QnHU3Els2tas3ihYTExyiRn7RSD7tRNPAykv
        obP8v5jmL9+toon/VfKeMXtJXfbFEW4h35lZLwLETA==
X-Google-Smtp-Source: AA6agR6L1SyuMzUf8+xeARTBqavCpRaNKT6T+hGBy6ljvxZOnUHutxr1KeuC5g6EOuuX+XryhF9+3PBL5lvLY4jo71I=
X-Received: by 2002:a17:902:f612:b0:172:cbb0:9b4f with SMTP id
 n18-20020a170902f61200b00172cbb09b4fmr21157414plg.142.1661874513400; Tue, 30
 Aug 2022 08:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220830081457.118960-1-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20220830081457.118960-1-aneesh.kumar@linux.ibm.com>
From:   Wei Xu <weixugc@google.com>
Date:   Tue, 30 Aug 2022 08:48:22 -0700
Message-ID: <CAAPL-u9HDu4Kk23S+mTueCfnHG7ujQJH5zqgkwmyAN52et26SA@mail.gmail.com>
Subject: Re: [PATCH mm-unstable] mm/demotion: Make toptier_distance inclusive
 upper bound of toptiers
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com,
        Bharata B Rao <bharata@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 1:15 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> Based on suggestion from Wei Xu <weixugc@google.com>, having an
> inclusive upper bound is found simpler.
>
> Fixes: mm/demotion: Update node_is_toptier to work with memory tiers
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  mm/memory-tiers.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index c4bd6d052a33..c82eb0111383 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -179,7 +179,7 @@ bool node_is_toptier(int node)
>                 toptier = true;
>                 goto out;
>         }
> -       if (memtier->adistance_start < top_tier_adistance)
> +       if (memtier->adistance_start <= top_tier_adistance)
>                 toptier = true;
>         else
>                 toptier = false;
> @@ -361,7 +361,8 @@ static void establish_demotion_targets(void)
>                          * abstract distance below the max value of this memtier

below -> up to ?  Looks good to me otherwise.

Wei

>                          * is considered toptier.
>                          */
> -                       top_tier_adistance = memtier->adistance_start + MEMTIER_CHUNK_SIZE;
> +                       top_tier_adistance = memtier->adistance_start +
> +                                               MEMTIER_CHUNK_SIZE - 1;
>                         break;
>                 }
>         }
> --
> 2.37.2
>
