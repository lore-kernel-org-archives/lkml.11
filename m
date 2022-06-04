Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF5BC43334
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jun 2022 02:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350231AbiFDCRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jun 2022 22:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349089AbiFDCRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 22:17:06 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A870620BCD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 19:17:05 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id q21so19100667ejm.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 19:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kb8hf9iiCnweQzsHtq7rRtVY2qH/dt001UC5BeN8J94=;
        b=CwQRZCwkz5kyFLw5k7ZR9IaPEV6O2bN8jguHTOc4YTgrGhFcB3A5zzitkzfmsGXiBf
         jaSuxfWlGlbShuhKTS06NRhuLEzhW5zfUXu8wUIR5GCEPhnB7/9TdKw3D+8L6s3hGYa1
         Bdju9qhYviI7FLD0l1G//Mrh0VJVRcBdr5RZbrbjAQmSyJ9maZHfaudFX95639ivk3ME
         aSakK8sLmg7tL8Hlrva7xucdTm1E8ex0TQPr9mQODR/MeQ6giU9+p9rvSMACIoshJRff
         29lUXeDMffXYgQf5kvKJGXazPwp5wZMsxF9wuVL01OWuklD5ehSH/Zo2dRuCEYNBKywR
         zH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kb8hf9iiCnweQzsHtq7rRtVY2qH/dt001UC5BeN8J94=;
        b=hdl8RDNo4Km8iNeu0OhodpyBbPnnduwtW8US3QyWk4hF8zfUMZ3TJOSqvhaayFB4ND
         fr75dB10hl3NlAS3/CLi/0hOZx0GmwT1A7SBHtRQLf+TgUMW+cPsEsgnehdArdNRhyBC
         v06CLFH+3b7kZa4gx+7ztesz/ohbV2lkGUmQCQyEupF9IcpdwTQ8dlX5QaVGICtSs8xP
         CNzC+zr50V6KxevcU9cwlTeOJrl7K5sKs0KlJ7kZgz0BsrxkBvDRNldLh66LkhZQgwjZ
         9U00HjgKEkbIxrSSeS9LU+8aiQoVBGs9abxzqFonRUThnozvyLrW285Kz8tcdP2X0+tL
         ma3w==
X-Gm-Message-State: AOAM533etJ7S0291y23qGs8byn5Tkd6d0MfSWLbQEltqLjLOyW7rcsRu
        lA8Edn0rXOgE7X+7A6Zu+g0uyjfVrxjKiGziOQE=
X-Google-Smtp-Source: ABdhPJxob8cxmg3uW5k2pkmwONStUpDE/IbpZcJGHRtW6W1jCv16hQyXUb5xsqMeLckkcJzrb8BLa10M56yblGE5xHQ=
X-Received: by 2002:a17:907:c1a:b0:706:ca1d:af05 with SMTP id
 ga26-20020a1709070c1a00b00706ca1daf05mr11443465ejc.174.1654309024203; Fri, 03
 Jun 2022 19:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220602073259.25669-1-nashuiliang@gmail.com> <20220604000312.69f42c92e932152da256c2bb@kernel.org>
In-Reply-To: <20220604000312.69f42c92e932152da256c2bb@kernel.org>
From:   chuang <nashuiliang@gmail.com>
Date:   Sat, 4 Jun 2022 10:16:52 +0800
Message-ID: <CACueBy42VUp=4-nMRfAERmLxEwXkc0tGqWQk935oqLeJ51OU5A@mail.gmail.com>
Subject: Re: [PATCH] kprobes: Rollback kprobe flags on failed arm_kprobe
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jingren Zhou <zhoujingren@didiglobal.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your quick reply.
I'm very, very sorry for sending multiple emails. I am submitting a
patch for the first time.

On Fri, Jun 3, 2022 at 11:03 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> This should go to stable, so add below tag. (No need to CC to stable)
>
> Fixes: 12310e343755 ("kprobes: Propagate error from arm_kprobe_ftrace()")
> Cc: stable@vger.kernel.org

Thanks for your kind reminder.

>
> And could you also update this patch as below?
>
> > ---
> >  kernel/kprobes.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index f214f8c088ed..96c75e23113c 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -2422,8 +2422,10 @@ int enable_kprobe(struct kprobe *kp)
> >       if (!kprobes_all_disarmed && kprobe_disabled(p)) {
> >               p->flags &= ~KPROBE_FLAG_DISABLED;
> >               ret = arm_kprobe(p);
> > -             if (ret)
> > +             if (ret) {
> >                       p->flags |= KPROBE_FLAG_DISABLED;
>
> Here, can you add a check?
>
>         if (p != kp)
>
> > +                     kp->flags |= KPROBE_FLAG_DISABLED;

Well, I also thought about it. This already covers conditions `p ==
kp` and `p != kp`:
---
                       kp->flags |= KPROBE_FLAG_DISABLED;
---

When p is equal to kp, `kp->flags` is assigned to KPROBE_FLAG_DISABLED twice.
However, if you add a check that p is not equal to kp, this makes the
code read more clearly. Anything is OK, what is your suggestion?

>
> Thus is is clear that this is corresponding to
> ---
>         if (p != kp)
>                 kp->flags &= ~KPROBE_FLAG_DISABLED;
> ---
>
> Thank you,
>
> > +             }
> >       }
> >  out:
> >       mutex_unlock(&kprobe_mutex);
> > --
> > 2.34.1
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

Have a wonderful day!
