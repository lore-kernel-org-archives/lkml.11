Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5E8C433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Apr 2022 04:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbiDMEQB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Apr 2022 00:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiDMEP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 00:15:59 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E0F2715F;
        Tue, 12 Apr 2022 21:13:39 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id v77so1539698ybi.12;
        Tue, 12 Apr 2022 21:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TQZLuJZfVE6AxMD6sl1ogZmXMPpifJ9LjvcfCPk5gpA=;
        b=lrN+91GSWIJC4APIhsSUC/ra8rARAubHf391ZU7pYuOqQTYezME6bu1IA/zC8HPMZW
         2RpsRXBfwAO9DNvLukOn8jMjBm8HxhPEwNUpuckx7z+A9n7+/9bhaBGMep0OQYiq0JiZ
         4l63kozmfiMWXJbLoirtvWNX60H+WYHV0knublmN0YW8fNZKMpVDZbql8gk4LuZAU636
         17KbH76QlC1euhHVDEoYmXdzQK2Dbfw1SauFXKb3oGMPYSZnugr4ZO2JJ/obTLmKA6eg
         iFSTzllfaBmN90xAJMqM/M7ruMPjm0MGprZc/20iEYvHnZvQKKvDKtjnG3fSCnvV0CSJ
         Iw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TQZLuJZfVE6AxMD6sl1ogZmXMPpifJ9LjvcfCPk5gpA=;
        b=HtISaSYvXf3VyyOISq0QZSIG33KqqWH1SCMp5NKU73Zo9L1ACRgmMDUXI6dwc59iV/
         EpVJM6ZO8AZGfW6aRLv6luDplKfAVLPejg9lSi28CarTJ1rzYqZ4cJF/L8oqyn6yTt4p
         hjPzFwlcn1YNwoC38rc39spPSx3+Rmdkkn8z3/d1QmZO0mHFn1IHS1+4OHnESwIYJL7Q
         H2TVPCWcgHwfjKYVpyZBB8ifvYjeansBRBLqPzW9wuVH2eIZCeW+nKhjeM9f1+zpACWJ
         c9e3s7iwMyGt/6i06UmvNok8THCsgy9eFx1RnwNt4xG5Jeh6yXj87dPoLMZa09qk8bKZ
         EhBw==
X-Gm-Message-State: AOAM5325w5kHGfGE8gBGJhX4rJV5FR7AXbRQj9vBW07NzXruKqzRF05p
        aPjGX8xDUX3Vuhe1DFBztZVNtNmH2LL4sbq+YB4=
X-Google-Smtp-Source: ABdhPJweacgi/V++Q/6Dy+PJgp7VQy7yrfH6uF3rT+11RcDhm0wdKdBquw6jOTj4yuFz6mRfVy5l2KZxItlLW1xP/tg=
X-Received: by 2002:a05:6902:1206:b0:641:bc56:7444 with SMTP id
 s6-20020a056902120600b00641bc567444mr3151395ybu.376.1649823218905; Tue, 12
 Apr 2022 21:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220330132152.4568-1-jiangshanlai@gmail.com> <20220330132152.4568-3-jiangshanlai@gmail.com>
 <YlXvtMqWpyM9Bjox@google.com>
In-Reply-To: <YlXvtMqWpyM9Bjox@google.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Wed, 13 Apr 2022 12:13:27 +0800
Message-ID: <CAJhGHyBNK=t1M2QQBq2qea4gW3yqvqKNG0QX=HRvjM=eHY6w6w@mail.gmail.com>
Subject: Re: [RFC PATCH V3 2/4] KVM: X86: Introduce role.glevel for level
 expanded pagetable
To:     Sean Christopherson <seanjc@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 5:31 AM Sean Christopherson <seanjc@google.com> wrote:

> >  union kvm_mmu_page_role {
> >       u32 word;
> > @@ -331,7 +331,8 @@ union kvm_mmu_page_role {
> >               unsigned smap_andnot_wp:1;
> >               unsigned ad_disabled:1;
> >               unsigned guest_mode:1;
> > -             unsigned :6;
> > +             unsigned glevel:4;
>
> We don't need 4 bits for this.  Crossing our fingers that we never had to shadow
> a 2-level guest with a 6-level host, we can do:
>
>                 unsigned passthrough_delta:2;

We can save the bits in the future when we need more bits so I didn't
hesitate to use 4 bits since glevel gives simple code. ^_^

I think the name passthrough_delta is more informative and glevel
is used only for comparison so passthrough_delta can also be
simple.  I will apply your suggestion.


Thanks
Lai
