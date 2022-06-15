Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BADC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jun 2022 08:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346762AbiFOI7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jun 2022 04:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346671AbiFOI67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 04:58:59 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C504BF49;
        Wed, 15 Jun 2022 01:58:58 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id 15so8235395qki.6;
        Wed, 15 Jun 2022 01:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YP6kMN3mskDVqyDhBOXdWopbBBdScUpfy2GBkGqTXE8=;
        b=dAOhQNKH29tjrfJ4yGXkKiXcXiFJc+/hCwVjtD5o+0w/9CxwAc5zwk1BotLpl4eSWz
         Kc5+gqz29JOJVoCQiyxqGupRUk2rTfOD0G5gtooa/XARdovoArpjtkMAAhYsl3zpbCdm
         9p83/wuA4rqTnCsNjzCkASd+3QJgv/dUgaNJBwoLXYMKUjJiBt5xUxTwlF8/kynxXi5V
         ggfoTN+eZ62IF881UgSfUkZywR39BGiNJb7ynFbGT80qevgwAN+z/fBUk5D6hFsujDTI
         SvAMvWg0uCnGUo7PK51EV8UAMDSE/aQdZzlUgRQrhk7zlMoOkMdfAvkqlr7K/LOly+Nc
         RHVw==
X-Gm-Message-State: AOAM531XmRtQmiU8L8zKBt+dAfaoR66WT8FpWuYmfELUpCr41W2WWi4M
        49+vpIBwWNwxODevupWqbHq1f+8pL47Hfw==
X-Google-Smtp-Source: ABdhPJyXhr1go9kJUT02HT4wqventqe/PmZRPsqIFPH5dF5W+KX/+Das3roidgFYVA0F7ByTma70jw==
X-Received: by 2002:a37:6290:0:b0:6a6:7d23:5eb7 with SMTP id w138-20020a376290000000b006a67d235eb7mr7277999qkb.642.1655283537449;
        Wed, 15 Jun 2022 01:58:57 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id bs7-20020ac86f07000000b00304ee3372dfsm8859458qtb.45.2022.06.15.01.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 01:58:57 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-2ef5380669cso54055857b3.9;
        Wed, 15 Jun 2022 01:58:57 -0700 (PDT)
X-Received: by 2002:a81:6157:0:b0:30c:7e4d:b28e with SMTP id
 v84-20020a816157000000b0030c7e4db28emr10249141ywb.502.1655283536818; Wed, 15
 Jun 2022 01:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220614095109.8175-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220614095109.8175-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Jun 2022 10:58:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUt7L7Cw_PaF0pph3CgPcMbPFTHmKXG8Zt+RPcvL_Lcgg@mail.gmail.com>
Message-ID: <CAMuHMdUt7L7Cw_PaF0pph3CgPcMbPFTHmKXG8Zt+RPcvL_Lcgg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: renesas: r8a779f0: Add HSCIF nodes
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linh Phung <linh.phung.jy@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 11:51 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> From: Linh Phung <linh.phung.jy@renesas.com>
>
> Extracted from a bigger patch in the BSP, rebased and DMA
> properties added.
>
> Signed-off-by: Linh Phung <linh.phung.jy@renesas.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Change since v1: include all HSCIF

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.20.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
