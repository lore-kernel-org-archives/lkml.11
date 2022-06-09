Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4ECCCA473
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jun 2022 09:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240825AbiFIJTT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jun 2022 05:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiFIJTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:19:16 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84441F2FE;
        Thu,  9 Jun 2022 02:19:15 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id y15so16714975qtx.4;
        Thu, 09 Jun 2022 02:19:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zLBQ/1iNltaWLswe/a2+FpHCpp5bwmu+I0N93NCsVa0=;
        b=hCB5P60uwqvEHwrii49UW2qAEnxCznKQZYaKAC5atg3eZGOj7aCsy7e5F2J8/wj1DE
         8SihwBMe2O4b8lMmdhnfyU054iGEacy6LaF8cPTXdXuIIB4cXKnPnlKAQghSpXhhsBRi
         e7SAHj0dKpgDXstUMJjRI3lkUBL5jkj+9iRMZkoyoV2g8exNba7ZnP249GDukIWBK5g2
         ODsXvLjQmJcek8VLcWlYHUiyXC8XuUtyn62YFArX3axWqnjbZCs1WVuV6YAOxWwOJEHQ
         IeIc6lGx1/2OC1OsP2fQkhrWqvKP5RFaLuvjQinhdXJPqw7xGx0st/51+mQGQA+bnpqn
         ZYeA==
X-Gm-Message-State: AOAM532kec0vIS4mHnSP6xSK0GGyex41Je+pKoeRruyzOKWcefGIDEDu
        GOcHxmq2Rz1pVHZbQWFcp2Uhg8NxOyAiFg==
X-Google-Smtp-Source: ABdhPJzVlRlMeNTwj9AbZz1pk5P/M1Lu4925n9bpgOJldmE9C3W66Jz0edLrEPK48kT0Y/Iyxw4LXg==
X-Received: by 2002:ac8:5f12:0:b0:305:c3d:c1da with SMTP id x18-20020ac85f12000000b003050c3dc1damr1888749qta.492.1654766354685;
        Thu, 09 Jun 2022 02:19:14 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id hh8-20020a05622a618800b00304f3e320f2sm5731766qtb.4.2022.06.09.02.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 02:19:14 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id g201so12917358ybf.12;
        Thu, 09 Jun 2022 02:19:14 -0700 (PDT)
X-Received: by 2002:a05:6902:120e:b0:634:6f29:6b84 with SMTP id
 s14-20020a056902120e00b006346f296b84mr39923091ybu.604.1654766354021; Thu, 09
 Jun 2022 02:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220525151355.24175-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220525151355.24175-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 9 Jun 2022 11:19:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVhteUVZ0+kaSggEntrwSYtrNEB-CNopPCmdJsRrqkYRg@mail.gmail.com>
Message-ID: <CAMuHMdVhteUVZ0+kaSggEntrwSYtrNEB-CNopPCmdJsRrqkYRg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: r8a779f0: Add thermal support
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linh Phung <linh.phung.jy@renesas.com>,
        Wolfram Sang <wsa@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
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

On Wed, May 25, 2022 at 5:14 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> From: Linh Phung <linh.phung.jy@renesas.com>
>
> Add support for 3 TSC nodes of thermal. The 4th node is for the control
> domain and not for Linux.
>
> Signed-off-by: Linh Phung <linh.phung.jy@renesas.com>
> [wsa: rebased, fixed resource size, removed unused 4th node breaking probe]
> Signed-off-by: Wolfram Sang <wsa@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
