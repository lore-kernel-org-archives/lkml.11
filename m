Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0362CCA487
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jun 2022 01:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390506AbiFHBur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 21:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381172AbiFGWcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 18:32:19 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC81B201A5;
        Tue,  7 Jun 2022 12:25:22 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id p8so13369694qtx.9;
        Tue, 07 Jun 2022 12:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uBxZMfLmxooTlhIsANMOdaw7k3DLxucyW3hJMGAkzw8=;
        b=GxgUQqLjRfKADsbmeWRGZc+NkCa5HHiHR7gfskTEvypoM1S55g/IwDpxoPowJki43K
         BBZdoA3+qKceSL0UHVjILR7BLa3pzCFk16jEfIow1lHB/AYyA1LQle2hLHJuy1b1o8za
         hXMxiVq3spsQ7VlL9AoqyVTSwhDtcD7dpu5kqHLPphFk0GcBYZlYQZschK0YZd4hbcR6
         OIzGNL9YFT81xBmNRRbeI6S6ZsHqhPZKcbSFOaefOC2Th8EgpeZKCgszskFzQZz0Ts/u
         T8lUm4b1qFcKcDq/5IqiKhk7SKXInNIwDs8dd+0WA6Hh+WqE4wfHdLF8/9+VAkk6I7lL
         fUxQ==
X-Gm-Message-State: AOAM5304Y3tq6Map/COFMRiTjDe2oTt3PF3IjloXkLF7jXKI/aaEpkjT
        gocQJPPgYgx6T+CZh4oZnaaIUYUKR3/wSg==
X-Google-Smtp-Source: ABdhPJzBPO3Z/iRat8MaMhx7WmlB6aiDML7Y6+EzvsxDCY/7ToS8zfyqUyVQZA5hQABmz0Pi4r5jAw==
X-Received: by 2002:ac8:5b87:0:b0:2f8:ab4:a050 with SMTP id a7-20020ac85b87000000b002f80ab4a050mr24743447qta.183.1654629921471;
        Tue, 07 Jun 2022 12:25:21 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id cc17-20020a05622a411100b00304ef50af9fsm3896005qtb.2.2022.06.07.12.25.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 12:25:21 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id a30so14008101ybj.3;
        Tue, 07 Jun 2022 12:25:20 -0700 (PDT)
X-Received: by 2002:a25:d748:0:b0:65c:6b00:55af with SMTP id
 o69-20020a25d748000000b0065c6b0055afmr30535822ybg.365.1654629920488; Tue, 07
 Jun 2022 12:25:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1654529011.git.mchehab@kernel.org> <1906a4d935eab57c10ce09358eae02175ce4abb7.1654529011.git.mchehab@kernel.org>
In-Reply-To: <1906a4d935eab57c10ce09358eae02175ce4abb7.1654529011.git.mchehab@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Jun 2022 21:25:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXeO5emvLMpMOBygfHeBE+knzceVNPbigYka0bjxxx=zw@mail.gmail.com>
Message-ID: <CAMuHMdXeO5emvLMpMOBygfHeBE+knzceVNPbigYka0bjxxx=zw@mail.gmail.com>
Subject: Re: [PATCH 01/23] dt-bindings: mfd: bd9571mwv: update
 rohm,bd9571mwv.yaml reference
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 6, 2022 at 5:25 PM Mauro Carvalho Chehab <mchehab@kernel.org> wrote:
> Changeset 983b62975e90 ("dt-bindings: mfd: bd9571mwv: Convert to json-schema")
> renamed: Documentation/devicetree/bindings/mfd/bd9571mwv.txt
> to: Documentation/devicetree/bindings/mfd/rohm,bd9571mwv.yaml.
>
> Update its cross-reference accordingly.
>
> Fixes: 983b62975e90 ("dt-bindings: mfd: bd9571mwv: Convert to json-schema")
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Mea culpa
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
