Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B64DC433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Feb 2022 19:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiB1T6H (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Feb 2022 14:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiB1T6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 14:58:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C543A24F22;
        Mon, 28 Feb 2022 11:57:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C10DB81640;
        Mon, 28 Feb 2022 19:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25560C340F6;
        Mon, 28 Feb 2022 19:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646078238;
        bh=l5lLRt3vCYUiYaHyAaMI2kjZl93YQn92cFQDfwENYYc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A+gHE8ynvFySBYElIx1otyPFay0rvpFhk4R1i6htEBIkpbViL67XeFlpxC7qfYbHC
         adswbY2ndvA7R9wHtzVEWBSybHRfV5Q/ly9l/ZATgaJoT3A9sKgDm3SknViMkBoIJd
         7/on6FPbfEWACJEm4mpTOM9DUpVHmapxKlWaNFvgDDO/L+ym4S6n/5jy4CWn6PkcbS
         4nSNTijVu3T4ROd+izGeTRDoRluGibDsghw0N1qSo14dnoohCFcFtYM/bTm/AccsTF
         GfP3q7gJfxJrQrZThcj9lDaRu3p7ka0wTNNYRQvyIZwQ/HXaTl1Seb8jWcRBhdOBmE
         kj/WoGxs6rm3A==
Received: by mail-ed1-f51.google.com with SMTP id s24so19156970edr.5;
        Mon, 28 Feb 2022 11:57:18 -0800 (PST)
X-Gm-Message-State: AOAM5319XaVM0A7f8sQn/HKx41xXNvQYbNFQDw7lg3hNK+qpygzmYrMK
        ywT0kvqXlGMM4SzKTnfrvmvXgWtXQ4xIBx7GAg==
X-Google-Smtp-Source: ABdhPJxu9XPcGWgUlPnfAVpPTPRsS8IAALKfEklJS+km7TveFGDFfTWE5+3j5LJ6ScmR5br0jvLWLJoTEZjDJKHIAzg=
X-Received: by 2002:aa7:ce92:0:b0:40f:b89c:18fe with SMTP id
 y18-20020aa7ce92000000b0040fb89c18femr21239364edv.67.1646078236360; Mon, 28
 Feb 2022 11:57:16 -0800 (PST)
MIME-Version: 1.0
References: <cover.1643360652.git.geert@linux-m68k.org>
In-Reply-To: <cover.1643360652.git.geert@linux-m68k.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 28 Feb 2022 13:57:04 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ=hikc1RAFkdV-uGWTVyHKp8z+=NEtTm-WZzc9h3Lxew@mail.gmail.com>
Message-ID: <CAL_JsqJ=hikc1RAFkdV-uGWTVyHKp8z+=NEtTm-WZzc9h3Lxew@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] dt-bindings: timer: sifive, clint: Miscellaneous improvements
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup.patel@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 3:07 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
>         Hi all,
>
> This patch series contains two improvements for the SiFive CLINT DT
> bindings.
>
> Changes compared to v3[1]:
>   - Use architectural maximum instead of practical maximum of 10,
>   - Add Reviewed-by (this time for real ;-).
>
> Changes compared to v2[2]:
>   - Add Acked-by, Reviewed-by.
>
> Changes compared to v1[3]:
>   - Split in two patches,
>   - Improve patch description and document limit rationale.
>
> Thanks!
>
> [1] https://lore.kernel.org/r/cover.1639744468.git.geert@linux-m68k.org/
> [2] https://lore.kernel.org/r/cover.1639662093.git.geert@linux-m68k.org
> [3] https://lore.kernel.org/r/20211125152317.162958-1-geert@linux-m68k.org
>
> Geert Uytterhoeven (2):
>   dt-bindings: timer: sifive,clint: Fix number of interrupts
>   dt-bindings: timer: sifive,clint: Group interrupt tuples
>
>  .../devicetree/bindings/timer/sifive,clint.yaml          | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

As these have not been picked up yet, I've applied them.

Rob
