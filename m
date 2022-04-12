Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BBBC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 09:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352342AbiDLJmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 05:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388441AbiDLJWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:22:12 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E23B46B12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:28:40 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l7so30367224ejn.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9pLWiODOOZL178tpEqwofl1D5ualPXQ/vBRW34AkTuA=;
        b=NLdpRY6W7VSJdqN39swR+EnBSwHzc9yMPP1ohdf7r0qw+XUE7KvlliFNmr3MeKW3kt
         dvSzsH6RjuFfwZdsXywZafFmY615056s45UlxPo/DLsKb5GaLPPZQEVhKS67laqmN5dc
         zRoMg6letP7zOsScx2XLGC7wQDLnxbTQ79cm2PXG0qGPW0cPqHMUqnWBkrRzm6xHdNPQ
         IiPiUPT8luzGcJtxkW3d7Qr0D7Z/VPvvg+zkMl5hO/TDGjU7eeAHYipDJz3TxtiGRU9o
         MqQO5b9mHqr9UPU7do3V8AI5C/eHpwhSBraqDS7m3soKgWke88QHaSrEZHEpKn3WsWfi
         sfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9pLWiODOOZL178tpEqwofl1D5ualPXQ/vBRW34AkTuA=;
        b=50asldSq1IH6XTp0QTN19c6e9KH6CIDIM9v9bR/hizuVWokis+mS9i2g7P6RXU/8LU
         19+d/t+Pl3EDuifUk1J9PLSlDe6+xkbVhJVEVHUApmH1tTGO98QEpXydMba4PMdXdLB0
         7CJxXGH9sVDP/rjBgNzRzgYjEvuvoU3Drfm4RY6KmsEZkvmmgv9KsW+f91ykAQXyKBoq
         yzLZYy3der8O2jxuUj/gaiWw+VJOFhlqs713TWWhuMA7zSJhzFvJ6n0qFnW2XGUwNdvL
         AmggL20CqCIzpP4wwOv0RHsoM6hmtAWjfyMDFXT8JkD1CqRc6/g6VcYxUtZBw8h4Urat
         heUg==
X-Gm-Message-State: AOAM531LzMBDRQmPxmN7OuwVW7xW3bkuuOrsgWkAIC1YDS4NxMVKCtOv
        BLOrLfdh2KQwn7ap7ZBMQOUOMPjNRHvC0401UeBrgQ==
X-Google-Smtp-Source: ABdhPJxg+bgJzY8ifzgACdhMELmjNhIE8OEjtXI7cTUfeZE1bYvbbpw+kl1uin2SHTd4z5vkUunyd3PCDRmh10FCRgk=
X-Received: by 2002:a17:907:97cf:b0:6df:846f:ad0a with SMTP id
 js15-20020a17090797cf00b006df846fad0amr34382832ejc.286.1649752118772; Tue, 12
 Apr 2022 01:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220411063324.98542-1-andrei.lalaev@emlid.com> <CAHp75VfyxspOScEt1qffshdrDYuQp50O5HFbr2cUV7MYsg=JdQ@mail.gmail.com>
In-Reply-To: <CAHp75VfyxspOScEt1qffshdrDYuQp50O5HFbr2cUV7MYsg=JdQ@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 12 Apr 2022 10:28:27 +0200
Message-ID: <CAMRc=MfakYvQUW4NLWCrm5yVA185X4t__aB3r4-9xTh8YJaq8g@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: of: fix bounds check for valid mask
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andrei Lalaev <andrei.lalaev@emlid.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 2:17 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Apr 11, 2022 at 12:57 PM Andrei Lalaev <andrei.lalaev@emlid.com> wrote:
> >
> > Use "greater" instead of "greater or equal" when performs bounds check
> > to make sure that GPIOS are in available range. Previous implementation
>
> the available
>
> > skipped ranges which include last GPIO in range.
>
> the last
>
> Should it have a Fixes tag?
>
> OTOH, the current implementation suggests that we have start,end
> rather than start,count. What does documentation tell about it? Does
> it need to be fixed?
>
> --
> With Best Regards,
> Andy Shevchenko

Thanks Andy, I rushed this one. Backing it out.

Bart
