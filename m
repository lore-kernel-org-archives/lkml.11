Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1BFC433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jun 2022 14:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240564AbiFIOj5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jun 2022 10:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbiFIOjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:39:54 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3ECD323889
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 07:39:53 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x5so26406186edi.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 07:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0/u1rMjmJk+0BnOEKh8/bNAIanlTimqw+e3mGvtCQ0s=;
        b=n6rzyKX3xBz7Dxc38xruwgA1s4zAP+LN1QZOTs1g1JEN0BDllMd0FSLVDs2dptrIEL
         OCNd2aP4+AA2ZrMuHU6dJV6fFJiZ26yCw3ItF4A2JZOdF0ZeiCj0jv35QttVoor4LVwg
         eW5NOS53DB6fF+XjyJKWSx9LGQac+aPjL2pY4B0+jbF8ovRd+/LkcB6/jAuDotxYjS0k
         wwrqMWoIMQqj1qsIbw/MIAlNRnGhsZrZMCpCKR+fStZPXx4A2tKaeyP1wcDVcA8ZuLbV
         SfDiN+hNJZcvVaKNcaVXC1kA3EvDJpXKgkyI+W6E+rRY9+lTaaXTibxp8CgMSJMLoEcc
         j0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0/u1rMjmJk+0BnOEKh8/bNAIanlTimqw+e3mGvtCQ0s=;
        b=B2nSDttTydk4oq9AW+5eBdKHPURwO99kzH1vcqUi/KnlxeYS2Ra5YoUqPiV24dnFXs
         kGnJcIMNxEUBcW1lV4+2CeiGiaoLuUQX/VpuD6Na7XZ1jsr+1Q7jTSnHj0j/gxRlMWjj
         4fXnQ+xI9Dl5xdbY5lVpyai1p0Os/01aMBHJKwf2vM2RTzadDMmjlc/+oy8K7gpFfFze
         Z2Ie87+n6/R/sFa2BKn2mqIPiFmYnd0CCEOeP0FRLaMtLf3t9pgmDo5o6TIs6zZD5i52
         uRJaY+U2vlsjs9uB6ZMy8wdeqw3TmPVHpTExsPqI2fYwegDJLGHcKLlEUYD+jAlgK42T
         x98g==
X-Gm-Message-State: AOAM531+2gU87mLRa3a6XO1mhQWY6rKlzrxmvnl8fPmBtBTtIQ/gH3iy
        YiC7Hgbr/JMY/0SZLM1vYOrd568OUb+ODsSWoD6nd2eIYQA=
X-Google-Smtp-Source: ABdhPJw+X02sZwu3KQLH3iUwfx+lVPR7JTkfdLaFJa5enb3gcNbmzAQnt4qP9+nbNc8wWLqcIrUMNYW/ZgioVTV5uzg=
X-Received: by 2002:a05:6402:e0c:b0:42d:7f16:ac2c with SMTP id
 h12-20020a0564020e0c00b0042d7f16ac2cmr45236672edh.328.1654785592329; Thu, 09
 Jun 2022 07:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1654525394.git.william.gray@linaro.org>
In-Reply-To: <cover.1654525394.git.william.gray@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 9 Jun 2022 16:39:41 +0200
Message-ID: <CAMRc=MfoMjFV8EsDeXuHEFjOS2m7r4fW7BqETCDrcjTHVgzDbQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] gpio: Implement and utilize register structures for
 ISA drivers
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 6, 2022 at 4:36 PM William Breathitt Gray
<william.gray@linaro.org> wrote:
>
> The PC104/ISA drivers were updated to use I/O memory accessor calls such
> as ioread8()/iowrite8() in a previous patch series [1]. This
> patchset is a continuation of the effort to improve the code readability
> and reduce magic numbers by implementing and utilizing named register
> data structures.
>
> One of the benefits is that we can now observe more easily similarities
> in devices that share similar interfaces; such as the i8255 interfaces
> used by the 104-DIO-48E, 104-IDI-48, and GPIO-MM drivers -- as well as
> the similar interface used by the 104-IDIO-16 and PCI-IDIO-16 drivers. I
> hope to consolidate some of these code blocks in future patchsets.
>
> [1] https://lore.kernel.org/all/cover.1652201921.git.william.gray@linaro.org/
>
> William Breathitt Gray (5):
>   gpio: 104-dio-48e: Implement and utilize register structures
>   gpio: 104-idi-48: Implement and utilize register structures
>   gpio: 104-idio-16: Implement and utilize register structures
>   gpio: gpio-mm: Implement and utilize register structures
>   gpio: ws16c48: Implement and utilize register structures
>
>  drivers/gpio/gpio-104-dio-48e.c | 157 +++++++++++++++++++++-----------
>  drivers/gpio/gpio-104-idi-48.c  | 128 +++++++++++++-------------
>  drivers/gpio/gpio-104-idio-16.c |  58 ++++++++----
>  drivers/gpio/gpio-gpio-mm.c     | 116 ++++++++++++++---------
>  drivers/gpio/gpio-ws16c48.c     | 119 +++++++++++++++++-------
>  5 files changed, 366 insertions(+), 212 deletions(-)
>
>
> base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
> --
> 2.36.1
>

Hi William,

Unlike the previous patches which were relatively simple, these seem
like there's a lot of space for breakage (even though they're
attempting to do a good thing). Have you tested the code on real
hardware?

Bart
