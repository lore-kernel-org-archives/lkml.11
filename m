Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76A6C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Feb 2022 15:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbiBPPvB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Feb 2022 10:51:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235781AbiBPPuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:50:50 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF74E2A796A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 07:50:37 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id p9so4132110wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 07:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hliIdd752PVyrplihGKCvTCkvfLt0yHXLtglCy+GWyU=;
        b=czP0AYbrLj85n4nJXQpyPUVWsaUiVbzsWOeQeC8FFdNtW8R2iTdOROaBqa5QP3NRxm
         XW32Q1P3CDIS4eRDLcyCCyhQvwOJeJVNxaokZSs73N6I8vXuoDVCLPLU+Eei9I1FZkzI
         SYyD07vaKzrq82JBN1KtclP7RyPv7WFTSMF3DNoVf3Ws7ZnBcny+zM4kEBDrBmciixq5
         O2Nx14octwS/7ABes15MXLUdISBz6KHx27WTZ7dxIFnMeJaCjA4W+St55du4SntWtFQ2
         2pqJpRQC0uxairq0BIRW6kyLhdAHJrcaYBcnrBDgdf974+bftDIXBUh/yfo/AABYRlnk
         +qWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hliIdd752PVyrplihGKCvTCkvfLt0yHXLtglCy+GWyU=;
        b=nuKyUuBvVIqEVuO66bEJUe0GBQVcb3nbiH7JPWGbvw3qYaMKfuc03CFVj0IG41CFhc
         gV93myuAabX/BOtTKgXFcftgdil4sWPMzvO6z+kQXmXgdetTrUEcVKBlBVwUm23W+r4j
         6kd+JG3mS0n1twq6o1tkL9h0BS+US4uERv/UWTigrr/yRTbSD/ExNrAhYmBlJGpyL6zH
         DXWSQNuV15S7fPVK34NavDbgFKV/JfzpuRLhOOt4oVyDMit6zcVVkDtP4nuV1gZxF4kF
         RFQUQrQNDlbW2CVi9xnGXyrU2u3R5E7f+eyo3ITxO47s36Hb9r/LNHVoBkk68uBhv0mx
         kdFA==
X-Gm-Message-State: AOAM532YvOU2TIJnlcq5TKhGzAxgvej83dbidgKW5XK50ZNtd1bZgA0q
        +Z50JKIeV0phR7ja7Z164Rs2bKPZ8TwtaxfPXtw1ucHDt6guyA==
X-Google-Smtp-Source: ABdhPJxwRV9174mD3gl49gYRGGXMejExK2a5uLPXlChYmfaxta/eWmfJSbEJsak1HASA+hJbmEG4J0OkIWIQrRalU8M=
X-Received: by 2002:adf:fe43:0:b0:1e4:a213:b876 with SMTP id
 m3-20020adffe43000000b001e4a213b876mr2831720wrs.513.1645026636090; Wed, 16
 Feb 2022 07:50:36 -0800 (PST)
MIME-Version: 1.0
References: <CAPcxDJ7nriZEJHF6dMPR7tQ+dGuueyRjw1NC+4CbjxiAT_S+ZA@mail.gmail.com>
 <20220208150945.266978-1-juew@google.com> <Ygwka++3eipjQzB2@zn.tnic>
 <YgwnqTc8FGG3orcE@agluck-desk3.sc.intel.com> <YgzRsfWOmqkNiNI7@zn.tnic>
In-Reply-To: <YgzRsfWOmqkNiNI7@zn.tnic>
From:   Jue Wang <juew@google.com>
Date:   Wed, 16 Feb 2022 07:50:24 -0800
Message-ID: <CAPcxDJ4=iknzYbN=b2oQxvJyODkQ_MWEj1wkKEuGwf4HQ3aPZA@mail.gmail.com>
Subject: Re: [PATCH] x86/mce: Add workaround for SKX/CLX/CPX spurious machine checks
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 2:28 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Feb 15, 2022 at 02:22:33PM -0800, Luck, Tony wrote:
> > This early in do_machine check we don't know whether this was from
> > a over enthusistic REP;MOVS fetch, or a "normal" machine check.
> > I don't think there is an easy way to tell the difference.
>
> That's what I am wondering: whether we can compare the buffers REP;
> MOVS was accessing and determine whether the access was out of bounds.
> Something ala _ASM_EXTABLE_ as it is done in arch/x86/lib/copy_mc_64.S,
> for example, which will land us in fixup_exception().
>
> Now there we'd need to know the range the thing was copying which should
> be in pt_regs and the address the MCE reported. If latter is not in the
> former range, we say ignore.

This is a great idea.

My slight reservation is that this suggests all use cases of "REP; MOVS*" must
take the _ASM_EXTABLE_ form, which is not possible; considering
"REP; MOVS*" can be exercised from any user space program.

>
> There's even some blurb about "recovering from fast-string exceptions"
> over copy_mc_enhanced_fast_string...
>
> Hmmm?
If there is a way to get all users of "REP; MOVS*" to use
copy_mc_enhanced_fast_string, this could work. I am not sure this is possible.

>
> > The first check:
> >
> >       if ((mcgstatus & MCG_STATUS_LMCES)
> >
> > is for "is this a local machine check"? So no broadcast sync
> > needed. But that needs a comment.
>
> Yap.
Updated in the latest patch sent.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
