Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5401AC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jun 2022 08:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347687AbiFJI1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jun 2022 04:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347708AbiFJI0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:26:48 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDD6195906
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:24:26 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id j8so16103846qtn.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ePiWLMIFFFMTZGAPUYMPtOQbf4rBsBwydN2vOsIC08U=;
        b=nu7ctk4yVyub89JHGQm21Uz1Xev2o2V+S1bb26f4epxYD+G+3+H6Wy62rgmLarNsiZ
         7FWaVxb6WQ/zGnaZjdpeMwLtjxE0SCxnUVeigy8M3KgIq6N+Sd8u0KZt/FKS3ePaKZ+9
         L8DfK0Uv0WYpOKhHftiPGyadEkzKjx1tlvz8Jd9oomH+f8+ts1RV02bcCjUdk6Z5uJL8
         XJW63J9yOelgJojsHIx1qETKrd8o5BTGInFxkxu3admhuPJZaINQ+Bm03lORbOotA6j+
         4jnF3V0aiYSGPXYq1NqeHPeNmdV1YoWK6KwslAW+atFhJY6x2f9Wg+DnB1goQft/IYX0
         /XQg==
X-Gm-Message-State: AOAM530xfoDCYrZ2Jk3vS7/VeoHPfXOLlqAT/5vHMWYdOfFSQhSro7nU
        AZV41auu7jLMyqErjyMYMO5+NP7iH7MtSQ==
X-Google-Smtp-Source: ABdhPJy+kmPATM1NrYpK+8Rz68rgpD7KPTFZs5j5yVNytss03GdqJBlD2ZFD9jEcGtLS0qqWE4ONCw==
X-Received: by 2002:a05:622a:38f:b0:301:43c8:cda4 with SMTP id j15-20020a05622a038f00b0030143c8cda4mr34819392qtx.244.1654849465192;
        Fri, 10 Jun 2022 01:24:25 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id bs32-20020a05620a472000b006a67eb4610fsm2116987qkb.116.2022.06.10.01.24.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 01:24:25 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-31336535373so114245137b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:24:24 -0700 (PDT)
X-Received: by 2002:a81:6157:0:b0:30c:7e4d:b28e with SMTP id
 v84-20020a816157000000b0030c7e4db28emr46912140ywb.502.1654849464556; Fri, 10
 Jun 2022 01:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220610082150.23677-1-wangxiang@cdjrlc.com>
In-Reply-To: <20220610082150.23677-1-wangxiang@cdjrlc.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 10 Jun 2022 10:24:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWCo+_WbpXtA1XJPM=t4LQ=UuO7Pd5nw4i5R7mJaWZmjQ@mail.gmail.com>
Message-ID: <CAMuHMdWCo+_WbpXtA1XJPM=t4LQ=UuO7Pd5nw4i5R7mJaWZmjQ@mail.gmail.com>
Subject: Re: [PATCH] m68k: mac: Fix typo in comment
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     Joshua Thompson <funaho@jurai.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiang,

On Fri, Jun 10, 2022 at 10:22 AM Xiang wangx <wangxiang@cdjrlc.com> wrote:
> Delete the redundant word 'an'.
> Delete the redundant word 'and'.
>
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>

Thanks for your patch!

> --- a/arch/m68k/mac/iop.c
> +++ b/arch/m68k/mac/iop.c
> @@ -25,7 +25,7 @@
>   *               check this.)
>   * 990605 (jmt) - Rearranged things a bit wrt IOP detection; iop_present is
>   *               gone, IOP base addresses are now in an array and the
> - *               globally-visible functions take an IOP number instead of an
> + *               globally-visible functions take an IOP number instead of

OK

>   *               an actual base address.
>   * 990610 (jmt) - Finished the message passing framework and it seems to work.
>   *               Sending _definitely_ works; my adb-bus.c mods can send
> @@ -66,7 +66,7 @@
>   * a shared memory area in the IOP RAM. Each IOP has seven "channels"; each
>   * channel is connected to a specific software driver on the IOP. For example
>   * on the SCC IOP there is one channel for each serial port. Each channel has
> - * an incoming and and outgoing message queue with a depth of one.
> + * an incoming and outgoing message queue with a depth of one.

The second "and" should not be deleted, but replaced by "an".

>   *
>   * A message is 32 bytes plus a state byte for the channel (MSG_IDLE, MSG_NEW,
>   * MSG_RCVD, MSG_COMPLETE). To send a message you copy the message into the

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
