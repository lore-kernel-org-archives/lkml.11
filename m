Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4665C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jun 2022 10:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352082AbiFAKbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jun 2022 06:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352078AbiFAKbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:31:37 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D192C5799B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 03:31:35 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id j3so1164992qvn.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 03:31:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=arhHYoJqMFfcMeOXlJMWB+0WDHbBRE6zIU08olykNLU=;
        b=sKMqEY7tQkaz5ncMQAMXzT3dGoluAdvtRDa4sh535JIjLDEVzwMDBYpwsXH3mO6dUM
         GqNfl4SreNO6C+O2OckWvozA8ujplzdit+rtVTWJEYpY3EjJ8BOG5kq6YbYWhQXYvZQT
         m2TgkmrtGAp+vqP0aGbNaQo+rEjreV9waaKSp9FAvsKQuDRCqTz2mnedXtPl/SxJIKPM
         40NJbgyky91b+pOZ9FuNLcTbKZie+rw80mrWJ9ZSdGheNjBck496a6KSzwDWJAwogQ2C
         /o8AqzY/N3rvhkS748UtU+AsxGWqk1G7UoGGr9mPqm+aGWIjjBndSBgqfBZ8YwtiChA+
         Tmcg==
X-Gm-Message-State: AOAM530CgqvIs3T9HXW7ytGKlJrEm/eiFPfdL4jD16hs1hyVTcQzHVMc
        wHZ/fTwxLCKMTYCIBV/a6EqJuLpeP3kuxQ==
X-Google-Smtp-Source: ABdhPJyBqygBiGToUl/apK7D3TUOr8/GSjJuVJQYQGOpEajQXoi9Pmqj0/numLVxRm8AK0Vz4BNCig==
X-Received: by 2002:a05:6214:626:b0:462:43b4:8491 with SMTP id a6-20020a056214062600b0046243b48491mr40073530qvx.110.1654079494707;
        Wed, 01 Jun 2022 03:31:34 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id t25-20020a05622a181900b00304c2c3d598sm830711qtc.19.2022.06.01.03.31.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 03:31:34 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2ec42eae76bso13356457b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 03:31:34 -0700 (PDT)
X-Received: by 2002:a81:6157:0:b0:30c:7e4d:b28e with SMTP id
 v84-20020a816157000000b0030c7e4db28emr13169171ywb.502.1654079494189; Wed, 01
 Jun 2022 03:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220531221102.1112968-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20220531221102.1112968-1-dmitry.osipenko@collabora.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 1 Jun 2022 12:31:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV5oTde6bZEfGoP1vjG=nk_xm5VLibMwrL_VEnFAS7c9g@mail.gmail.com>
Message-ID: <CAMuHMdV5oTde6bZEfGoP1vjG=nk_xm5VLibMwrL_VEnFAS7c9g@mail.gmail.com>
Subject: Re: [PATCH v1] kernel/reboot: Use static handler for register_platform_power_off()
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Wed, Jun 1, 2022 at 12:11 AM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
> The register_platform_power_off() fails on m68k platform due to the
> memory allocation error that happens at a very early boot time when
> memory allocator isn't available yet. Fix it by using a static sys-off
> handler for the platform-level power-off handlers.
>
> Fixes: f0f7e5265b3b ("m68k: Switch to new sys-off handler API")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Thank you, that fixes the issue.
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
