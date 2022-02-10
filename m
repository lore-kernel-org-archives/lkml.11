Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98260C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Feb 2022 22:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344900AbiBJWWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Feb 2022 17:22:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344868AbiBJWWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 17:22:49 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41049117E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:22:49 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id f10so13026847lfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bwpOdgFQsH734At37yjdv4Nb0bvjgu3SgbDAbXyvUB4=;
        b=fI0xbKcdzpA+8Va5155Mdfuw440giBRX8QLLR8+CLcUsOBdRYP4z5OQCb57mF1a8N6
         t4s6l4rmrsyAyL1hj58kI/rAt3V/SV8/lSX51xzZhhhpDCqA409AECsie1YGy4IeHGLE
         +GVtYOgiHoGkj9QW0fe8XD1crWNgUuUWYkRV89jW49qmBY2DLgAVREQwkcLu3xvYYS9r
         kgPtnyKJRn30npoDJjXj4RnYDRe+JgEthHfR2mGk6dY1Mcg5fOQAR3nblzbsl3+Mdw+7
         HYI9DpKPo3laQm7w7tXBN9WHS9Ql//I9J2NxCSL2J+brvwZ7zgOSXv0otFoAhUzNRBlM
         BG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bwpOdgFQsH734At37yjdv4Nb0bvjgu3SgbDAbXyvUB4=;
        b=e60Fx/IkUsYiVkYRuRTK2Xzo5+4Z/6v1xRk/A9cB4yeFA3PUETLKpw1VRsf1gq8vt0
         u1XVOXUB/gSH715pe1hDrnlVDS5c8uvIsQKVhW+yFv9uuwpPJ8sAFw84axA+GXJpMl33
         6YPWpFl6g6N64RwcXW+OMur2oq9ZOOqg65pQ/MKENGl/bQ3SYnhcyjMDdA+FEmMPRE7K
         o7czx47d+K8oZlwIz1G98V8O1SaCH0N4mqpkVvFJSyI0ohYVy1tMJUviOi30QVeR2uHC
         8LJD4agZmOzfeT3ajw/+fgVNlnxLNHR10fkl8bFZI12iI0XF0PmJYQNKJ6TRhAXUkuYa
         pXWQ==
X-Gm-Message-State: AOAM532sgGJbx9RTvZd0Ahq+iWiY9xFp/+OvJO5TJ87cHk9o52pA4hnr
        pmKUsv1lhw3HvW8b1FMJvdrblH/9KU3sbAxazlm0WA==
X-Google-Smtp-Source: ABdhPJz3n2/MNQsc8l0zgRAoXCBWTnu0KCr4v87xDGQiIoKz3e1x0R0A09Vnlf+JoKpSRstq0zNn8mmNb53j/3k3w/4=
X-Received: by 2002:a05:6512:3e10:: with SMTP id i16mr6280877lfv.184.1644531767275;
 Thu, 10 Feb 2022 14:22:47 -0800 (PST)
MIME-Version: 1.0
References: <20220210081437.1884008-1-shakeelb@google.com> <20220210081437.1884008-5-shakeelb@google.com>
 <YgVyZrDPxVgP6OLG@carbon.dhcp.thefacebook.com>
In-Reply-To: <YgVyZrDPxVgP6OLG@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 10 Feb 2022 14:22:36 -0800
Message-ID: <CALvZod5xFmCVV_AZO1be8pYakmDvYh-QXmNYtTNT4zvCw-m4bQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] memcg: synchronously enforce memory.high
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 12:15 PM Roman Gushchin <guro@fb.com> wrote:
>
[...]
>
> Has this approach been extensively tested in the production?
>
> Injecting sleeps at return-to-userspace moment is safe in terms of priority
> inversions: a slowed down task will unlikely affect the rest of the system.
>
> It way less predictable for a random allocation in the kernel mode, what if
> the task is already holding a system-wide resource?
>
> Someone might argue that it's not better than a system-wide memory shortage
> and the same allocation might go into a direct reclaim anyway, but with
> the way how memory.high is used it will happen way more often.
>

Thanks for the review.

This patchset is tested in the test environment for now and I do plan
to test this in production but that is a slow process and will take
some time.

Let me answer the main concern you have raised i.e. the safety of
throttling a task synchronously in the charge code path. Please note
that synchronous memory reclaim and oom-killing can already cause the
priority inversion issues you have mentioned. The way we usually
tackle such issues are through userspace controllers. For example oomd
is the userspace solution for catering such issues related to
oom-killing. Here we have a similar userspace daemon monitoring the
workload and deciding if it should let the workload grow or kill it.

Now should we keep the current high limit enforcement implementation
and let it be ineffective for some real workloads or should we make
the enforcement more robust and let the userspace tackle some corner
case priority inversion issues. I think we should follow the second
option as we already have precedence of doing the same for reclaim and
oom-killing.

thanks,
Shakeel
