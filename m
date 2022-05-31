Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CC4C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 May 2022 21:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348032AbiEaVar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 May 2022 17:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346692AbiEaVap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 17:30:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FD39D4D5;
        Tue, 31 May 2022 14:30:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A47B61309;
        Tue, 31 May 2022 21:30:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CABC3411C;
        Tue, 31 May 2022 21:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654032644;
        bh=dgKMOmPer7iKgCojd4nmuoUy3ULtSG1a8CWjkVRT/cU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WbRj7VYpyKzOjUQhYUviEB++FiWhTF5EDaAV86pQjN84wbUrnCUWGi5pbw+O8hG6G
         dT9Zp3V6WViklchFXMiuZehiAw52rFGB90NixQ93WpDBUPjNjRzAEza/8ZAk05u3ds
         gVDI17kNkuwAXOrlqmohzaFE1qjfXuJWzXx5wxLxmWY5MYoWnnq4PyWDeFkyoNGbmO
         gm9HYXDmQCKqy+/WVFzdzPRyr+D4v4LCiSNZFgxoMepcTx/IOJb/4MRTiAF/Vjl1DC
         B/BxHm15J0ySVGEVbs+4cfsl5xVW0cZEWVaSgEH4vrb6Rrjn7LwZ/uhEGA3/Qkjp/3
         Wa4t3rbgNVOiA==
Received: by mail-vs1-f54.google.com with SMTP id w10so14906983vsa.4;
        Tue, 31 May 2022 14:30:43 -0700 (PDT)
X-Gm-Message-State: AOAM532V6h3hfhzhyUUX6Bh/GdSDGv7b/NRK/TfoJ9n+y1GaaCfLpLen
        7v746VC5xN/wAMmI2Ye3JmL5Yyd8aopzyBrwZQ==
X-Google-Smtp-Source: ABdhPJwrsIDv4UJc5u6xTXBY/96ny0Alz0jVz/mRjD3IguJf2tCd0IZV0fcDQUb1XVM49IQ34zyFkt+/6Dy0JwDc6ic=
X-Received: by 2002:a67:c118:0:b0:337:96d2:d624 with SMTP id
 d24-20020a67c118000000b0033796d2d624mr19823826vsj.26.1654032643023; Tue, 31
 May 2022 14:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220531211018.2287964-1-robh@kernel.org>
In-Reply-To: <20220531211018.2287964-1-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 31 May 2022 16:30:31 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKnBHfvi9iec2sgoEs6sLUgxnPY0gzxaO+bevzO3DjcmQ@mail.gmail.com>
Message-ID: <CAL_JsqKnBHfvi9iec2sgoEs6sLUgxnPY0gzxaO+bevzO3DjcmQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: net/dsa: Add spi-peripheral-props.yaml references
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Marek Vasut <marex@denx.de>
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 4:10 PM Rob Herring <robh@kernel.org> wrote:
>
> SPI peripheral device bindings need to reference spi-peripheral-props.yaml
> in order to use various SPI controller specific properties. Otherwise,
> the unevaluatedProperties check will reject any controller specific
> properties.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
>  - Also add references in nxp,sja1105.yaml and brcm,b53.yaml as
>    pointed out by Vladimir Oltean

Sigh, a bit too quick on this one. v3 coming.

Rob
