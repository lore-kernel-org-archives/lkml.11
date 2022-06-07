Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C35C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 05:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236890AbiFGF7B (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 01:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236879AbiFGF66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 01:58:58 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D48522DE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 22:58:57 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id e11so14593746pfj.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 22:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vhyeByqESMejGx5K1JZDwSGtodZB7YcNJdkA/XZ0nhs=;
        b=kJEPNwOx4uW/m0EmGEFbJCpF8utS8wjUtlPoQt/S+v3DQr6KNVz4SgD0N03AKsEJcX
         SO2IryPIeU/NYudxkDqQlve5MgWVNEd/UXTv4cQqyk1Xzg3ZqII+PMM+EuXOg1NIjJ4V
         jN7s5HxeykfvrWLOjcbQLVgsfbgmfTztwpMbAhaLNSeYFu4K1h3uX8J4o9hWA8ieYllK
         xdufyQ5KNBtOtIG80GB/m9OHwp8pxjZMmYG+HQsZiZNpZO5SvgjTSYceofuW/EpV1qLZ
         d8zB/sQ5OLtm52akYLt52jq1fouG4Dac89ykzUVvMKJVmu9w6rMtBvbq8X3+G+NZYOLg
         Jf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vhyeByqESMejGx5K1JZDwSGtodZB7YcNJdkA/XZ0nhs=;
        b=FJfl9A13p6L2Me7xs4FcOblF7UnkU+5iYNyyUf9l6SvKKj4cxSg8T9w/gq8OoxnBre
         QlkLZ6urhl2T9SUOCHPMQxGqsi0twekCJVUJ+epkOWaQGJF4KA7JogU1FCG1oZmm0Ufm
         68PFOa1Dp/GOKvP6npOnA456AbXGfGiEK544SwTQyB5KhB8/fL9U+/r5nTKisedwd2zc
         TD4TtPuHmP6hk4vzCK6AceagR+rn0rk1vM80pD3PKFJYHboI/z8ghYYQ1Q3kqZSo576d
         tUq+dByWFyB0EkFmUkPsBWGfvBUWQssyGj95yBOxPJD57IBHftCyspdUocaxPFMhfrqG
         W2Ig==
X-Gm-Message-State: AOAM530W+HPKrQ5O5Uv8zGpxPSRIyVOiTqsCO4lpCs5R3RyMNd8qLLWm
        stTYIl1p9JDolDhAYkEc+iz+wy28W42xnVOKi4YcLA==
X-Google-Smtp-Source: ABdhPJwXxF6peQ10a5eWuUpr6DpQPJGXHi4ZWloktkYqxy/TE7XHk0xrvMNVQW9Hi1HjZEWtcQAiGQ5Ygiw5VDdAR10=
X-Received: by 2002:a63:4c09:0:b0:3fc:a85f:8c07 with SMTP id
 z9-20020a634c09000000b003fca85f8c07mr24071397pga.509.1654581536373; Mon, 06
 Jun 2022 22:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <6b362c6e-9c80-4344-9430-b831f9871a3c@openvz.org>
 <f9394752-e272-9bf9-645f-a18c56d1c4ec@openvz.org> <Yp4F6n2Ie32re7Ed@qian> <360a2672-65a7-4ad4-c8b8-cc4c1f0c02cd@openvz.org>
In-Reply-To: <360a2672-65a7-4ad4-c8b8-cc4c1f0c02cd@openvz.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 6 Jun 2022 22:58:45 -0700
Message-ID: <CALvZod7+tpgKSQpMAgNKDtcsimcSjoh4rbKmUsy3G=QcRHci+Q@mail.gmail.com>
Subject: Re: [PATCH memcg v6] net: set proper memcg for net_init hooks allocations
To:     Vasily Averin <vvs@openvz.org>
Cc:     Qian Cai <quic_qiancai@quicinc.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 6, 2022 at 11:45 AM Vasily Averin <vvs@openvz.org> wrote:
>
[...]
>
> As far as I understand this report means that 'init_net' have incorrect
> virtual address on arm64.

So, the two call stacks tell the addresses belong to the kernel
modules (nfnetlink and nf_tables) whose underlying memory is allocated
through vmalloc and virt_to_page() does not work on vmalloc()
addresses.

>
> Roman, Shakeel, I need your help
>
> Should we perhaps verify kaddr via virt_addr_valid() before using virt_to_page()
> If so, where it should be checked?

I think virt_addr_valid() check in mem_cgroup_from_obj() should work
but I think it is expensive on the arm64 platform. The cheaper and a
bit hacky way to avoid such addresses is to directly use
is_vmalloc_addr() directly.
