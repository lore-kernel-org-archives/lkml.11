Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E547C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Apr 2022 16:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346303AbiDRQc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Apr 2022 12:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346358AbiDRQcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:32:35 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392F71AF0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:29:55 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id r18so17432832ljp.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ACTXoCAAPWGoVloJ2EChe4T7s6GZlY4X8j8GihvZ3tM=;
        b=HF3T4mfkjpsmLehz1/tS7TVpSB651oSEXAy9LFxM4Cc9sKtBkSNUWdU5q9rLIK9OCA
         ftRLlsNgVBJ1J5Arabq5Ye+bmKzq8fA12+fAebj2cN/HTx7C8gpPtTmJgQud/DKw02TJ
         3s327PHRVZNqD3QT158Yh44wswuruCrG4HB8xB+xig2UmEYPDaxpvzeeFmmBIJ1nk5qZ
         1n7htO0T+PdZiuX87JGBYvKlnH4mmhtm2oMwwFJZI23zVzqNcGog9KbrCjOa+Uhteb+b
         KPzV8lX4IAfbFxA9f0F5+7FDG1tP+aPixIwk2fVHETOQqDTXjQ9Eg7Te6yN9eIQkNf1e
         wf7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ACTXoCAAPWGoVloJ2EChe4T7s6GZlY4X8j8GihvZ3tM=;
        b=hInIzRW+4MBtN1XYmghRvJDKylQYGpb4H2Tve9qliYRFWUVQZYuOHj09Kb06PMVMwJ
         uFrmtYxT2e0ZpxBVvrPpBYUtc8iXY7fEMRpHHvl+1TXDVoArJ7rJMqvSUv6v/NC3JH6E
         ZeXq00a2SiC+xsZU3VU82Kd0OKBIw5GVlwVPqKNs+F/zv/kZqqLbwSWXShb9ATih/ZOf
         S9Qc8/mzqsw6IS3IEZ4xBWfFjfPr30LbfRrxuy8DnD4MAbXsOcb3UATVCHWOpV4sbwgK
         ecMw26KFi78fq4NiR7dHkK3NyOmnLzp86A8NsmyTTi/U+rApDtzx8LsES5RVTJ53Y1z3
         CNrg==
X-Gm-Message-State: AOAM532JnKfQqh0bczmW64Ki31DQBkpt5yVSbiL0GFJtQQCV7x9qegcn
        7Ll1tX4RFgHZQgOXH6+IDVH8pv/oM1RweHYPlZJj+A==
X-Google-Smtp-Source: ABdhPJyvuiGgXGN0OEytNZ0J/MDCq8oEDCWzgeniVmVsLwc3DBFKVnJYqd47PNLkmyfkgyMU4S5hwbn9gH67w6uScyE=
X-Received: by 2002:a2e:8e93:0:b0:24d:ab45:4053 with SMTP id
 z19-20020a2e8e93000000b0024dab454053mr7630884ljk.231.1650299393165; Mon, 18
 Apr 2022 09:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220325233125.413634-1-vipinsh@google.com> <CALzav=e6W2VSp=btmqTpQJ=3bH+Bw3D8sLApkTTvMMKAnw_LAw@mail.gmail.com>
 <CAHVum0dOfJ5HuscNq0tA6BnUJK34v4CPCTkD4piHc7FObZOsng@mail.gmail.com>
 <b754fa0a-4f9e-1ea5-6c77-f2410b7f8456@redhat.com> <CAHVum0d=WoqxZ4vUYY37jeQL1yLdiwbYjPSPFAa1meM5LUBDQQ@mail.gmail.com>
In-Reply-To: <CAHVum0d=WoqxZ4vUYY37jeQL1yLdiwbYjPSPFAa1meM5LUBDQQ@mail.gmail.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Mon, 18 Apr 2022 09:29:16 -0700
Message-ID: <CAHVum0eF=CmqXabrJS7rsVxhQLKA7v8iG1SjThcEJ=_zAUhRsg@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/mmu: Speed up slot_rmap_walk_next for sparsely
 populated rmaps
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     David Matlack <dmatlack@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 8, 2022 at 12:31 PM Vipin Sharma <vipinsh@google.com> wrote:
>
> On Sun, Mar 27, 2022 at 3:41 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > On 3/26/22 01:31, Vipin Sharma wrote:
> > >>> -static void slot_rmap_walk_next(struct slot_rmap_walk_iterator *iterator)
> > >>> +static noinline void
> > >>
> > >> What is the reason to add noinline?
> > >
> > > My understanding is that since this method is called from
> > > __always_inline methods, noinline will avoid gcc inlining the
> > > slot_rmap_walk_next in those functions and generate smaller code.
> > >
> >
> > Iterators are written in such a way that it's way more beneficial to
> > inline them.  After inlining, compilers replace the aggregates (in this
> > case, struct slot_rmap_walk_iterator) with one variable per field and
> > that in turn enables a lot of optimizations, so the iterators should
> > actually be always_inline if anything.
> >
> > For the same reason I'd guess the effect on the generated code should be
> > small (next time please include the output of "size mmu.o"), but should
> > still be there.  I'll do a quick check of the generated code and apply
> > the patch.
> >
> > Paolo
> >
>
> Let me know if you are still planning to modify the current patch by
> removing "noinline" and merge or if you prefer a v2 without noinline.

Hi Paolo,

Any update on this patch?

Thanks
Vipin
