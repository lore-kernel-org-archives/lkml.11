Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13FDC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 02:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242036AbiC3CkP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Mar 2022 22:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242028AbiC3CkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 22:40:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7BBB11C0F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 19:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648607900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0CM6n2cjBcYLkco5zRMxY738qqHj9I2QKT+KjQJ9qIc=;
        b=QzwFuvijxGgaw635BmJKerSs/ngs9GDBJe7gY8m57yqRo0+VOjmHfXKwYaFLhVmpdS8Wox
        79DcUV+EqBXOda9VGAxnVGBVXAAB0A2pMvUQ/bD6CixgI2YJl/VhLFkBeAdQyvauGip37s
        mTD5/rabwHnj/jeH9E8+2kWjrfoTyPE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-53-kEXbseuZPIaYmyvI74jAlw-1; Tue, 29 Mar 2022 22:38:19 -0400
X-MC-Unique: kEXbseuZPIaYmyvI74jAlw-1
Received: by mail-lf1-f72.google.com with SMTP id n2-20020a0565120ac200b0044a2c76f7e1so5926781lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 19:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0CM6n2cjBcYLkco5zRMxY738qqHj9I2QKT+KjQJ9qIc=;
        b=3w2S/2mr91qPn1k6nCcLaGP3M+yatc7+x37YZgcQHBxjNNJvtdZTiSiqWz7cZpMUDv
         eaWSnAEsXGcx1eOJDpXEQvbULaCElA3ZfxjY81jru53KZPg6jZRBJCmnl+TSThgWYRdL
         cx1449k8pv5H0O4wU8aw7AJNpHxmwN4ORSeTeRYC8WDnjagRJXizNheUmXHSGKyrCAPV
         XQ0rZYBXQgqmKcbuEDEGu7MsAXDRPqy33dneIPD21V4e+Q8jV0W4SA4dNBIUJfrJzXwF
         MVpRmFcvjgIlLq5o5jkGNPaNvMtzqDkDjypObptBka2ub0DUIGKckXVcqsfRvm+ETw4l
         4Orw==
X-Gm-Message-State: AOAM530bJ7iNS9XhTLtFAnpNnrJ3g5a3tFTlLoLCowMJxgUkeYABuZdo
        vs3H9qlfwEnxTWNIVg0iWEiUy//Dcyh4ts54+Q8nclBwR2WUBvF9RaaMH9nOy69Eaink+GwBktm
        DA0cquNa0cEC5iF05dJ9+mkttcaXqUrLzwkY8Csmf
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id p21-20020a056512139500b00446d38279a5mr5055796lfa.210.1648607897758;
        Tue, 29 Mar 2022 19:38:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsMNgPxQtJuVUUXSLLElqIoKTC9ua0/HO5bb6Fcre9c9W6UgWFNe6erYd0w1IGxGq19QreWNW8eV3nM3kpN4Y=
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id
 p21-20020a056512139500b00446d38279a5mr5055782lfa.210.1648607897557; Tue, 29
 Mar 2022 19:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220325050947-mutt-send-email-mst@kernel.org>
 <CACGkMEvioAVMmB+ab2xXB2YPECtwi1J55u8mRRk9-JAjFSZ8vg@mail.gmail.com>
 <20220325060659-mutt-send-email-mst@kernel.org> <CACGkMEu4mRfNbJXJtAFzhyd55fD7phUDKnVtYW0aqRnQmT_bYw@mail.gmail.com>
 <20220328015757-mutt-send-email-mst@kernel.org> <CACGkMEu+fax6YYwhfbc1yoSxv6o1FTQyrOheVTmUfqGvmbAEfA@mail.gmail.com>
 <20220328062452-mutt-send-email-mst@kernel.org> <87fsn1f96e.ffs@tglx>
 <20220329100859-mutt-send-email-mst@kernel.org> <87v8vweie2.ffs@tglx> <20220329175426-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220329175426-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 30 Mar 2022 10:38:06 +0800
Message-ID: <CACGkMEv2j2cJkSFfxTmaRxJ+SH6actSCZsALjvvDUPgg0h-KeA@mail.gmail.com>
Subject: Re:
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Keir Fraser <keirf@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 6:04 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Mar 29, 2022 at 08:13:57PM +0200, Thomas Gleixner wrote:
> > On Tue, Mar 29 2022 at 10:37, Michael S. Tsirkin wrote:
> > > On Tue, Mar 29, 2022 at 10:35:21AM +0200, Thomas Gleixner wrote:
> > > We are trying to fix the driver since at the moment it does not
> > > have the dev->ok flag at all.
> > >
> > > And I suspect virtio is not alone in that.
> > > So it would have been nice if there was a standard flag
> > > replacing the driver-specific dev->ok above, and ideally
> > > would also handle the case of an interrupt triggering
> > > too early by deferring the interrupt until the flag is set.
> > >
> > > And in fact, it does kind of exist: IRQF_NO_AUTOEN, and you would call
> > > enable_irq instead of dev->ok = true, except
> > > - it doesn't work with affinity managed IRQs
> > > - it does not work with shared IRQs
> > >
> > > So using dev->ok as you propose above seems better at this point.
> >
> > Unless there is a big enough amount of drivers which could make use of a
> > generic mechanism for that.
> >
> > >> If any driver does this in the wrong order, then the driver is
> > >> broken.
> > >
> > > I agree, however:
> > > $ git grep synchronize_irq `git grep -l request_irq drivers/net/`|wc -l
> > > 113
> > > $ git grep -l request_irq drivers/net/|wc -l
> > > 397
> > >
> > > I suspect there are more drivers which in theory need the
> > > synchronize_irq dance but in practice do not execute it.
> >
> > That really depends on when the driver requests the interrupt, when
> > it actually enables the interrupt in the device itself
>
> This last point does not matter since we are talking about protecting
> against buggy/malicious devices. They can inject the interrupt anyway
> even if driver did not configure it.
>
> > and how the
> > interrupt service routine works.
> >
> > So just doing that grep dance does not tell much. You really have to do
> > a case by case analysis.
> >
> > Thanks,
> >
> >         tglx
>
>
> I agree. In fact, at least for network the standard approach is to
> request interrupts in the open call, virtio net is unusual
> in doing it in probe. We should consider changing that.
> Jason?

This probably works only for virtio-net and it looks like not trivial
since we don't have a specific core API to request interrupts.

Thanks

>
> --
> MST
>

