Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E0FC25B0C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Aug 2022 15:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbiHKPDz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Aug 2022 11:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbiHKPDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:03:51 -0400
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9BA2C665;
        Thu, 11 Aug 2022 08:03:51 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id d1so13538610qvs.0;
        Thu, 11 Aug 2022 08:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=2b6Oow0p1Gi6gERi73kxRG3MvSeEsCXxIuq9tTMaffA=;
        b=DtnlCkgBWm/otrFX5e6/JHNUTFDsG7o+E3ED9IXHOT7HRti9nVNQEw1/n6EBfMV+mV
         xpSOztsrEJfmTjd5gDCO0XKDsDE3mcI/JhkVfxKM2ljTDm1VM7kXR3jPXSTZj7ytf6fs
         jac8OzIa1C74/StQXlJM4pxRXeGl9RMkdkFBMuYXqMgX8uRRoQHOyDRRxyFaoWAgCJwB
         g+RpLAGlLQsLfHp5J3Zzz/XE35vFqwLvfsf3hFwZxF0gSdP9DZFMgneS3r+Rc3uvVM68
         yVPjUpyTl1GQzv2GTm9uCWKgnBeMwiy8Sb7J+1Z2L9wRXE56P8AdVcN1RxbEwn/BA3xs
         qipA==
X-Gm-Message-State: ACgBeo0krDej7TB3/lhtPzQilibhjzzNbSxqcKXirtF+E+RVUg8UhDqY
        rui2m8pKo4ovQVufvpQEA/pKoEkFsk8akaot
X-Google-Smtp-Source: AA6agR4g1FQ7c4PinDoR22h6eu0Hoi3WVCW8U7nKECMNWtPm9oYWKpflP5avgGC09Mdv59JLrmebYg==
X-Received: by 2002:a05:6214:2265:b0:474:8865:7ba2 with SMTP id gs5-20020a056214226500b0047488657ba2mr28339686qvb.98.1660230230132;
        Thu, 11 Aug 2022 08:03:50 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id h9-20020a05622a170900b0034359fc348fsm1759450qtk.73.2022.08.11.08.03.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 08:03:49 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-32a17d3bba2so52941777b3.9;
        Thu, 11 Aug 2022 08:03:49 -0700 (PDT)
X-Received: by 2002:a81:b812:0:b0:328:68e4:c886 with SMTP id
 v18-20020a81b812000000b0032868e4c886mr32412237ywe.502.1660230228733; Thu, 11
 Aug 2022 08:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220722141506.20171-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220722141506.20171-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220722141506.20171-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 11 Aug 2022 17:03:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWD=QPqL6AcKw=Xx2GhVhNFw1EY=wqp+DxA71AQRACnmw@mail.gmail.com>
Message-ID: <CAMuHMdWD=QPqL6AcKw=Xx2GhVhNFw1EY=wqp+DxA71AQRACnmw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: soc: renesas: renesas,rzg2l-sysc:
 Document RZ/Five SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 4:15 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Document RZ/Five (R9A07G043) SYSC bindings. The SYSC block found on the
> RZ/Five SoC is almost identical to one found on the RZ/G2UL (and alike)
> SoC's. "renesas,r9a07g043-sysc" compatible string will be used on the
> RZ/Five SoC so to make this clear, update the comment to include RZ/Five
> SoC.
>
> The SYSC block on RZ/Five has no interrupts to the core so to accommodate
> this SoC make interrupts{,-names} properties optional.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2:
> * Dropped "renesas,r9a07g043-rzfive-sysc" compatible string
> * Made interrupts{,-names} properties optional

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.1.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
