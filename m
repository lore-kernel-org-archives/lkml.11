Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735DFC43334
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 20:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiF1UNV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jun 2022 16:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiF1UMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:12:02 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23B0B7F8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:04:08 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id a15so1447129vkl.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p/B/lKMrNzso4spSPSsCwZNEn4kBXQBTjSLYuB7ZnRI=;
        b=mxjGCIOfoAmyxfccoTVGTAkTulE4wTRYdtQ0NYkKSucODYFSn4CXTYOLJsAq9ElhQv
         uunT5HmitaiA9fw9pTRw0VGQqrXPDlrqRAWNugtfmQXGziYg9gYeZs/TcsE04j56wCa2
         DqZcs9mpLd//uRQnfjfJT6O8MfdNpyP0L0YeDVwJO3wKKgrFDZG38eg5ER9ruT/SoC8B
         YU6irY89WDJqBvR5ysy4PjbUMhRh4gb7q3K/6V76QdXMaSpuVoA2r7ArJDwTANaVswum
         V1GRSDLx3CpAHnRP+ZMBe1GL/5GRQWwAOPU91cU+NXDLLFoN0yN9rY2XvKzXKfJJ/w8b
         sxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p/B/lKMrNzso4spSPSsCwZNEn4kBXQBTjSLYuB7ZnRI=;
        b=2XzbMhHPIYhoS1m2iDVY6GAYxvgWRbNTYhvhiksg6wn3TYFTePVyxO9XEFC7b32wT9
         yxxvAqI5i6Zy0ly7oqmZ6Ig0uNGNIn/veQsU+dftu0K2CZRDGU1xMWdOZmi/9YiAqj0r
         1RAUtMZvXiVlqRS9cJk6r9d+RzW/+7AdAaPT8mw7Ah904zlSwjU+I1bO2REm6DHs5o8N
         Oa+AQu9FrINz8jOkj3d3F5+YRHCRhe66gqok74bjqb7qL5kYvd7aBPQ72XljTI1u3ckL
         041vPGIYYUyw/d0lhYldNFA13rnpcxrWUbC9Jpzf5n5QMTs7XBFmBKnm6mWaGo+ca/h2
         ajbw==
X-Gm-Message-State: AJIora+CGHjHeFebXPwisJl5bL7vzeNZk5fKSAo/ohyYn+NoVCTMNWsb
        YRkKpch7oYRD8/Hhs4O9ZYZTcffzkfuxr0AHXzovRg==
X-Google-Smtp-Source: AGRyM1vPxcUSK6LIJdPh1va54HjoTAEorgGghWfusEMooGmXSA3C+Yy0DGKnB8TyAI3/Iaynh2pv8HFkBaKtY3sFGr8=
X-Received: by 2002:a1f:aac7:0:b0:35e:1c45:def with SMTP id
 t190-20020a1faac7000000b0035e1c450defmr2577667vke.35.1656446647926; Tue, 28
 Jun 2022 13:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-6-jthoughton@google.com> <d2ac6c08-5d73-828b-9e14-64ef03ff87dd@nutanix.com>
In-Reply-To: <d2ac6c08-5d73-828b-9e14-64ef03ff87dd@nutanix.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 28 Jun 2022 13:03:55 -0700
Message-ID: <CAHS8izPt+h59x1em6z7YbKg+u2f1fMyx6EZ0gwSZ_xu7AM6S-g@mail.gmail.com>
Subject: Re: [RFC PATCH 05/26] hugetlb: add CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
To:     "manish.mishra" <manish.mishra@nutanix.com>
Cc:     James Houghton <jthoughton@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Jue Wang <juew@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 5:29 AM manish.mishra <manish.mishra@nutanix.com> wrote:
>
>
> On 24/06/22 11:06 pm, James Houghton wrote:
> > This adds the Kconfig to enable or disable high-granularity mapping. It
> > is enabled by default for architectures that use
> > ARCH_WANT_GENERAL_HUGETLB.
> >
> > There is also an arch-specific config ARCH_HAS_SPECIAL_HUGETLB_HGM which
> > controls whether or not the architecture has been updated to support
> > HGM if it doesn't use general HugeTLB.
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
> reviewed-by:manish.mishra@nutanix.com

Mostly minor nits,

Reviewed-by: Mina Almasry <almasrymina@google.com>

> > ---
> >   fs/Kconfig | 7 +++++++
> >   1 file changed, 7 insertions(+)
> >
> > diff --git a/fs/Kconfig b/fs/Kconfig
> > index 5976eb33535f..d76c7d812656 100644
> > --- a/fs/Kconfig
> > +++ b/fs/Kconfig
> > @@ -268,6 +268,13 @@ config HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON
> >         to enable optimizing vmemmap pages of HugeTLB by default. It can then
> >         be disabled on the command line via hugetlb_free_vmemmap=off.
> >
> > +config ARCH_HAS_SPECIAL_HUGETLB_HGM

Nit: would have preferred just ARCH_HAS_HUGETLB_HGM, as ARCH implies
arch-specific.

> > +     bool
> > +
> > +config HUGETLB_HIGH_GRANULARITY_MAPPING
> > +     def_bool ARCH_WANT_GENERAL_HUGETLB || ARCH_HAS_SPECIAL_HUGETLB_HGM

Nit: would have preferred to go with either HGM _or_
HIGH_GRANULARITY_MAPPING (or whatever new name comes up), rather than
both, for consistency's sake.

> > +     depends on HUGETLB_PAGE
> > +
> >   config MEMFD_CREATE
> >       def_bool TMPFS || HUGETLBFS
> >
