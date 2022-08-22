Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580B7C28D13
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Aug 2022 23:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238878AbiHVXzp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Aug 2022 19:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbiHVXza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 19:55:30 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927E25244B
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 16:55:29 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 73so10792880pgb.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 16:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=DFTMwRMyUNoCzrFPNgv8ys2sausHJWIL+AVipPkABmQ=;
        b=pPXvEGUI2VVm2HNlQxfpHcnrXYcJgzeHJTf7JpKE/wdALSKlCu9YYcVhUAGsfZpScZ
         i9iP794rArn60DEO4jMtrdrUcMErGSJM446/bWhL9vi7A/UwlCkwKludVGEnXrzO87r1
         Co+7SrNFnTykekPmtGF5ZBQpC5L6GhdFwFm8aorbXnpf2EGs/l0sK2ylX/3ZXJ6gipny
         GeMoEkhxWLFEyf0Y/UvfVwCgYm4YjNYHAfsssXUXoZJpgwDp9oG/LYzLujlxpXsrvVnA
         s6bmtvrGo/bEdeoQZH/kWe28TF7znSGb1rwZCpVe/nIPI6GLm1L0/XsaGAbeW0wfwbhf
         hFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=DFTMwRMyUNoCzrFPNgv8ys2sausHJWIL+AVipPkABmQ=;
        b=SYzUqfVXVYtYTDvXSM1T7aGb0jReX/so0fcQrjKM9DcWSPyN7CWpq/4ggPMpEds+Fd
         rXEgr3F3ws4u9smmG7l+u7/PkNpXIq77oJYxKc+zwIhlA4gz3khrOSbcNvaW41BTq+X5
         Cbkf874VCaSDQtbUQzICZIrzhHFbP3hYVQ01NViD/nyQjwtc9gKinSvesFjyO6xFjf/G
         2jONyh7qA9gKRhIoXbQq5+aCrZdSj+u9SowQjeiO3Kisv6qLW5JpMaizC9+nVgnMGKGM
         wNACwkHzRKIUW7DRAeC1NeKsSyGvxVCRx8PZVXGNdGT/s8KyeBdQY8of3zAc5GoPHmM0
         uxSA==
X-Gm-Message-State: ACgBeo2u2UJDBb9VOS8+M7qaP9jKJJXii6zSdvL6hQNDX1VydELqTZvj
        kW+TDpzouZA1agegHy+bEbGmK1DNyNTAgfc14nvbxw==
X-Google-Smtp-Source: AA6agR5XWgTreuL6vUHoqkUxeJovrT87P7dSwSTMZGZnrNAYhvm5I/5xf+Upjjd90DSd7Zt9KHx/GtqIBhIbJzerO6E=
X-Received: by 2002:a65:5941:0:b0:41d:a203:c043 with SMTP id
 g1-20020a655941000000b0041da203c043mr18451145pgu.483.1661212528790; Mon, 22
 Aug 2022 16:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220810152033.946942-1-pgonda@google.com> <20220810152033.946942-11-pgonda@google.com>
 <CAGtprH-emXA_5dwwdb4noOC-cuy3BTGT8UbKRkPD8j2gjBSu+Q@mail.gmail.com> <Yv/mcxPsJGZYV2tU@google.com>
In-Reply-To: <Yv/mcxPsJGZYV2tU@google.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Mon, 22 Aug 2022 16:55:17 -0700
Message-ID: <CAGtprH9yKvuaF5yruh3BupQe4BxDGiBQk3ExtY2m39yP-tppsg@mail.gmail.com>
Subject: Re: [V3 10/11] KVM: selftests: Add ucall pool based implementation
To:     Sean Christopherson <seanjc@google.com>
Cc:     Peter Gonda <pgonda@google.com>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Marc Orr <marcorr@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Mingwei Zhang <mizhang@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, andrew.jones@linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 12:37 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Fri, Aug 19, 2022, Vishal Annapurve wrote:
> > On Wed, Aug 10, 2022 at 8:20 AM Peter Gonda <pgonda@google.com> wrote:
> > >  void ucall(uint64_t cmd, int nargs, ...)
> > >  {
> > > -       struct ucall uc = {};
> > > +       struct ucall *uc;
> > > +       struct ucall tmp = {};
> >
> > This steps seems to result in generating instructions that need SSE
> > support on x86:
> > struct ucall tmp = {};
> >    movaps %xmm0,0x20(%rsp)
> >    movaps %xmm0,0x30(%rsp)
> >    movaps %xmm0,0x40(%rsp)
> >    movaps %xmm0,0x50(%rsp)
> >
> > This initialization will need proper compilation flags to generate
> > instructions according to VM configuration.
>
> Can you be more specific as to why generating SSE instructiions is problematic?
> The compiler emitting fancy instructions for struct initialization is not out of
> the ordinary.

When executing these instructions, I was hitting #GP in the guest VM.
CR4/CPUID settings seem to allow a VM to execute instructions that
need SSE support enabled (which I was doubting earlier). After some
more digging, it looks like the compiler is not able to ensure that
operands for such instructions are 16 byte aligned as required by the
hardware. There is a bug discussing this same issue:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=40838.

Adding -mstackrealign seems to help avoid running into #GP and things
seem to work normally. Though I am not sure if SSE instruction
execution is reliable from guest VM within selftests and so was
suggesting usage of "-mno-sse" or equivalent flags.
