Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E836C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 May 2022 20:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241407AbiEXUGR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 16:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241357AbiEXUGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 16:06:13 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1422012090
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 13:06:12 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id i68so14640919qke.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 13:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ym/o0L3Nl69cG1A2Xo5lifLxAYgZkmivMwTbScZGC3I=;
        b=RnI7UYRMhN/m1uMDa0epxjtwUkq/d8vFEjV1+V/JI8i7DG80dyyRWMqMt1anU+rFFL
         42ppoiixx9cPtJEtCRkWdFWPA39J92U89m0UemSsAWVNCOUlQMfYKACbHotgndUOd5rR
         cNt5VB64ib3tGjHELvxQCr9StabUmLCE1xklVQS2Dv6yVyvhK+Po1d6WFJkAQm93Q5D6
         0R4iB9cPAuw1Ui2d8/UOn3xkVfH+PVJYNbkAvz51vsVh4I5hKTJ6P5NCcJTTLdRxA6D7
         Th2l4X73mYo139zkEV3Bn7ckNU7zfwaCzsEPmO7yWXQxWjEp0ELAuIxhy2o8x06GgmR4
         nbuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ym/o0L3Nl69cG1A2Xo5lifLxAYgZkmivMwTbScZGC3I=;
        b=RTPIPp3fvzV9hcscD7CpNWndqWciVnnFgrtPV5lXpd9wf8b6EebK6wHPH2Ln86KLO0
         s1oIGLrwbPij0WSQel2BYOHg9J4OzF/eFOEUhGenu/2B0HeA76eoGSpJRjqP+30q0SUP
         4JLQ4UzcrVWn8jfQ9dHO0chL+PuMFQEx9QvKhhnelj/Bdsn9kWxq5T3h0FaTSys1nVIr
         FQIN/llPK8DR6IDmyeuDT4kG5KyPbUNL/ss8YgMoYZnRB6cEFyZnUNiyrS/pRA7rTa+W
         047id1jKRPNomIkrnxGWIcKxaHI8OyyMqN5zZTYzc+7VLAXLNIeAPm+pJFOQ/XMlxoer
         V1Wg==
X-Gm-Message-State: AOAM533BodJ0/j51jX+9qW9NRFgWoZqq8U31Fe74sRcGb8f4YqFwz034
        HUPKCT+joqljSzbqxzWb2qLmYAqfG+0YweSta3BCXg==
X-Google-Smtp-Source: ABdhPJwN41Y+zVNVnpjyUNnSPEoavriwkRYaeVbyo0ommHqIHzogpFycXag+3ugbHPvs5jk6of2GUQZ3GP8Rcus0tw0=
X-Received: by 2002:a05:620a:1aa1:b0:6a3:8dd8:7173 with SMTP id
 bl33-20020a05620a1aa100b006a38dd87173mr7921272qkb.434.1653422771014; Tue, 24
 May 2022 13:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <4740526.31r3eYUQgx@natalenko.name> <4bd84c983e77486fbc94dfa2a167afaa@AcuMS.aculab.com>
In-Reply-To: <4bd84c983e77486fbc94dfa2a167afaa@AcuMS.aculab.com>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Tue, 24 May 2022 16:05:55 -0400
Message-ID: <CADVnQykt1Lz0m1gfEckHhDLy66xhJvO0F2Z1-yQ=Mgi7gBY5RQ@mail.gmail.com>
Subject: Re: [RFC] tcp_bbr2: use correct 64-bit division
To:     David Laight <David.Laight@aculab.com>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        Yuchung Cheng <ycheng@google.com>,
        Yousuk Seung <ysseung@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Adithya Abraham Philip <abrahamphilip@google.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Konstantin Demin <rockdrilla@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 4:01 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Oleksandr Natalenko
> > Sent: 22 May 2022 23:30
> > To: Neal Cardwell <ncardwell@google.com>
> >
> > Hello Neal.
> >
> > It was reported to me [1] by Konstantin (in Cc) that BBRv2 code suffers from integer division issue on
> > 32 bit systems.
>
> Do any of these divisions ever actually have 64bit operands?
> Even on x86-64 64bit divide is significantly slower than 32bit divide.
>
> It is quite clear that x * 8 / 1000 is the same as x / (1000 / 8).
> So promoting to 64bit cannot be needed.
>
>         David

The sk->sk_pacing_rate can definitely be bigger than 32 bits if the
network path can support more than 34 Gbit/sec  (a pacing rate of 2^32
bytes per sec is roughly 34 Gibt/sec). This definitely happens.

So  this one seems reasonable to me (and is only in debug code, so the
performance is probably fine):
-                (u64)sk->sk_pacing_rate * 8 / 1000,
+                div_u64((u64)sk->sk_pacing_rate * 8, 1000),

For the other two I agree we should rework them to avoid the 64-bit
divide, since we don't need it.

There is similar logic in mainline Linux in tcp_tso_autosize(), which
is currently using "unsigned long" for bytes.

Eric, what do you advise?

thanks,
neal
