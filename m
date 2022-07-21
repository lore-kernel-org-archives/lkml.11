Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFFCC43334
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jul 2022 10:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbiGUKld (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jul 2022 06:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbiGUKl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:41:27 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EA543318;
        Thu, 21 Jul 2022 03:41:26 -0700 (PDT)
Received: by mail-qk1-f173.google.com with SMTP id c3so964256qko.1;
        Thu, 21 Jul 2022 03:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZM0L7KaMSxOM/wakTGUefF7pMc1InjFxOidEaSTgOKI=;
        b=5/vWHP0YgkkeSz7qTFJfpYuH2LoHiLZJP6MdOopIAt5vo+Sg9nhCkIgnxESjjptK+y
         lToFbhyKh+USPj+p+vbM7ylhsEl77EjfKclVOLt5iCG/wgdgUy7EQOuFVyZnBwZYkJ6B
         /m6+NyV9iJPFuQ0CGomMD+FiFbfIRrQGBsKgAtHYUc2yBJ1sy5vPaOCCcXp6HQXk1bb7
         kThOGhNo4R+jgI3ssbErP9XhQ4GgutlpSxcFOjtvUZ7Xc4m3Fqap4UzMi1rH1hc0bryH
         cebNOA18NIVWVwQMSnS0XjiqVx2HPzC9rMQBje5jBDhrN25NNT2lxy62nGpWnWaagfsu
         Hvhw==
X-Gm-Message-State: AJIora80fqbKAVEdL+UVxutHiLk4Fl+UFc16PMtpolBria7WcwkdvdVa
        fJANk/oJr8zIdYAeozhZvl4Qxbv1Hq22OA==
X-Google-Smtp-Source: AGRyM1tOeA+Gw7DZiFWRPKJOoA0ezpkitpRciKFcRBWGRCDfdmj6aVKFQ1LYFlWpb0lOf8R04zFU7g==
X-Received: by 2002:a37:ac17:0:b0:6b5:d5e4:61bc with SMTP id e23-20020a37ac17000000b006b5d5e461bcmr18810281qkm.707.1658400085857;
        Thu, 21 Jul 2022 03:41:25 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id i21-20020a05620a405500b006b5f4b7b088sm1194610qko.108.2022.07.21.03.41.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 03:41:25 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id c131so2057048ybf.9;
        Thu, 21 Jul 2022 03:41:25 -0700 (PDT)
X-Received: by 2002:a25:aacc:0:b0:66f:f1ca:409c with SMTP id
 t70-20020a25aacc000000b0066ff1ca409cmr29824052ybi.36.1658400085177; Thu, 21
 Jul 2022 03:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220718195651.7711-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220718195651.7711-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220718195651.7711-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Jul 2022 12:41:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUNifDMjBj5gkUUir-HYbn-gtx=2e-QkFTNYj_sHNc4RA@mail.gmail.com>
Message-ID: <CAMuHMdUNifDMjBj5gkUUir-HYbn-gtx=2e-QkFTNYj_sHNc4RA@mail.gmail.com>
Subject: Re: [PATCH 2/5] arm64: dts: renesas: r9a07g044: Update pinctrl node
 to handle GPIO interrupts
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

On Mon, Jul 18, 2022 at 9:57 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add required  properties in pinctrl node to handle GPIO interrupts.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.21.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
