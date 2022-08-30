Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AECC0502C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Aug 2022 07:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiH3HQw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Aug 2022 03:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH3HQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:16:48 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC4A67442;
        Tue, 30 Aug 2022 00:16:48 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id c20so7880697qtw.8;
        Tue, 30 Aug 2022 00:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=hbfMWbJBfBTtap4GWkn344FiWXI5cQK869u8DvT8sKM=;
        b=LQ5XP93PhZb7xmLEDoIwn058EjsUhDiTwW592EJa9pGlo4atdeCPPW/wIHvHdzP66J
         QIdv+shWpTGDTdV4BtAES3/Lx9dQoK/F6lbSxRdgYpJmDwUkPhIbT3buyCOOYUgLOOTh
         hVm9WMimMXVk73WT7NMFuS76J3ehfLPn5udL94HNaGyA2yw3cQ0HAwHRq6BiRVCv/goa
         nQTR1lfQcGycZ4qNcSXmXfYyWD1Ih8gs8ixe3nPpdZMImQIqQl/ypiguBeIWvfv6ShXK
         mIWd/+KXFfbXlvBWsfPGKouzCctHpdcWRsqA4kumW5W0Lz+fV7bKLkRiBDMa5xD8ULo/
         hYtw==
X-Gm-Message-State: ACgBeo3lviP2AB048vrubD2siEre/1o//S8zoYLVaudHRv1uu1uQZ24I
        rT61zG5UGPvNyz45RNaqm2UgyT4k9BojgQ==
X-Google-Smtp-Source: AA6agR5DsovEqpiUM/z35D73uGu6TTj5lZXXpDEIsP1D8F8q1m2WCZRkUEXgl/Xpy+H9/SCyhqidbg==
X-Received: by 2002:ac8:5c52:0:b0:343:3dc7:db0d with SMTP id j18-20020ac85c52000000b003433dc7db0dmr13674240qtj.179.1661843806969;
        Tue, 30 Aug 2022 00:16:46 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id u187-20020a3760c4000000b006bb9e4b96e6sm7449212qkb.24.2022.08.30.00.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 00:16:46 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-3413ad0640dso96155137b3.13;
        Tue, 30 Aug 2022 00:16:46 -0700 (PDT)
X-Received: by 2002:a81:83c8:0:b0:341:4b7b:3d9e with SMTP id
 t191-20020a8183c8000000b003414b7b3d9emr4513475ywf.47.1661843806284; Tue, 30
 Aug 2022 00:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220829215128.5983-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220829215128.5983-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 30 Aug 2022 09:16:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVr8s3xYdRZOixm1CmYjQWPGqW5uG1DHSZAzrACm6tB+A@mail.gmail.com>
Message-ID: <CAMuHMdVr8s3xYdRZOixm1CmYjQWPGqW5uG1DHSZAzrACm6tB+A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: Drop clock-names property from RPC node
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 11:51 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> With 'unevaluatedProperties' support implemented, there's a number of
> warnings when running dtbs_check:
>
> arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2-ex-idk-1110wr.dtb: spi@ee200000: Unevaluated properties are not allowed ('clock-names' was unexpected)
>         From schema: Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
>
> The main problem is that SoC DTSI's are including clock-names, whereas the
> renesas,rpc-if.yaml has 'unevaluatedProperties: false'. So just drop
> clock-names property from the SoC DTSI's.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.1.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
