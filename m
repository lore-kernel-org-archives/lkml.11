Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFB4C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 10:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241992AbiF1KDw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jun 2022 06:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344633AbiF1KDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:03:23 -0400
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE42E2E9DF;
        Tue, 28 Jun 2022 03:03:21 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id 59so19241599qvb.3;
        Tue, 28 Jun 2022 03:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y6DnWbrDioxwLTi6qSUpdk3hXp2GMF5P/uW1uFfY/eg=;
        b=hquJL540O1wD1sC/T6E/YgagOwLs7bsYWyNTE1Rr4q5QY+ilwA9uow09mR0lNXvpj+
         RvVwQKHX8hSDlNynXwNFY+dN4MBZOcYO5grAZhGP+TS/1EiIwZfscC7Jt0pd8FyzPuAM
         aWFskvRofV6U3t5Pm9tR7gdF7sy8/ZTyxNfW4QTlcWQSJ+tM2fc1bNu49HZGTMrYfNPp
         rzK1j3h9oaQVJG0CR4O3lbxGNRdTrtUAHBiICJUknP490QFZJIb2uhESKRvBQ3qbzLxR
         4fCnyhQtoP7AcvKZz0IZhJc+89Deu/ssi1de9ramQIVN9kWduVkon/GPZGLQsoPvXaNy
         rguA==
X-Gm-Message-State: AJIora+623Je+7Yl/mqbehDSgEgGxtPyZi9nSK5PHDj4s/U0UWin4e3i
        rCzt2eCuIL7neg0dfTg6BUIFv+Dw9Sw54A==
X-Google-Smtp-Source: AGRyM1tjAeE56/NICnzJHpX+vYgoPokIMvFK9bogMQE3wvPwIqTY12ICt13Dyw1IzVeUDKs65HbwXw==
X-Received: by 2002:a05:622a:1648:b0:305:d833:3aba with SMTP id y8-20020a05622a164800b00305d8333abamr12229650qtj.205.1656410600722;
        Tue, 28 Jun 2022 03:03:20 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id c190-20020ae9edc7000000b006a743b360bcsm10096444qkg.136.2022.06.28.03.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 03:03:20 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-3176d94c236so111558937b3.3;
        Tue, 28 Jun 2022 03:03:19 -0700 (PDT)
X-Received: by 2002:a81:9bcc:0:b0:317:9ff1:5a39 with SMTP id
 s195-20020a819bcc000000b003179ff15a39mr21179091ywg.384.1656410599473; Tue, 28
 Jun 2022 03:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220623083217.26433-1-jslaby@suse.cz> <20220623083217.26433-2-jslaby@suse.cz>
In-Reply-To: <20220623083217.26433-2-jslaby@suse.cz>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Jun 2022 12:03:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUTizh1pC14Uw+gpT3PQHPTTZP+hhRA_vo1Co5ZnNHMBg@mail.gmail.com>
Message-ID: <CAMuHMdUTizh1pC14Uw+gpT3PQHPTTZP+hhRA_vo1Co5ZnNHMBg@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: renesas: rcar-gen4: Fix initconst confusion for cpg_pll_config
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Michael Turquette <mturquette@baylibre.com>, mliska@suse.cz,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 10:32 AM Jiri Slaby <jslaby@suse.cz> wrote:
> From: Andi Kleen <ak@linux.intel.com>
>
> A variable pointing to const isn't const itself. It'd have to contain
> "const" keyword after "*" too. Therefore, cpg_pll_config cannot be put
> to "rodata".  Hence use __initdata instead of __initconst to fix this.
>
> [js] more explanatory commit message.
>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk-for-v5.20.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
