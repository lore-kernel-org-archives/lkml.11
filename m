Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9689C433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Apr 2022 20:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiDGUuY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Apr 2022 16:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiDGUuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:50:12 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C021639BDA1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 13:42:33 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2eafabbc80aso74654197b3.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 13:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cRs+Utv0bTIZPi+vQmKGar4cBWgLOZK71/Ro9IeVqw4=;
        b=Buk9C9oiM+HkYw7Mv+cJeR/Hls1sxoiGDZ5rZRp+oI3t1Fs/KF09Qh5WGhgevX6+nf
         4hELHaMgJ2GwlPL4ZSE5gHaEDk4yyUWkwbZs5smhYHXlNLd6V/65OehYjua8pGqmQR02
         Bi77bvRucjKjSzA64gTgUhTGuElaLed7eBm4/5WKj6XAe00dl8JWFZeP1xJypdfCb9lq
         9kayZsMTDZNeC+JqVXDxk2wYDF2v46EPRAOETexUjYNGcCCtln+fn6XL+ZKIkOmKzBa+
         7vOfXkhUHLfykdVsGF56kMD6eydE7gsDhkcvaizmoATDZccES6wHbOIhmRq1rxGHsqD2
         mxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cRs+Utv0bTIZPi+vQmKGar4cBWgLOZK71/Ro9IeVqw4=;
        b=Vg1hWePL+gfk6p91idCiT8YtfuXkrAJZzt6HE0WAfhUx1gHexsf8YURkEBaTUd4cis
         tlh827Z/RX3xDYltP1tCjK8gsG9BTKSYU9L88MejtU96Llj4RLSYv1jcdPD3GV/x0PL2
         BqNj1KUL2KvernLSIxoCqnVvSW8XghoQee2s5ZniK+afYa3qUMUP4QkK3iVtrOk4Icqt
         TmWN4n5m+NjYCy2VTrWcPw3rRmVXyQfGliYCnQffSPcp2PT6TaVjKoFQLnxFBgdzmSWl
         vAu0wiVc8TXlC0iH992rYRSdVwMdgIegd9Us7bUT6XCmtXOZJyRjPrpjl4Pe9N/ZMZtb
         cZwg==
X-Gm-Message-State: AOAM5312hLfN9UsbFdyaJ9zrba3TQouvl9WeXoIwSi/Xk3TaXqyzxCuD
        IYzTY7zx0mA2GJDER7yBxiwS4lp/6iOGGJwigi1slg==
X-Google-Smtp-Source: ABdhPJzXoseSIM+fkHPEcykLSfHutPaBoAw5VhzO9y9DZzxiy/OVlWbQjDJ94QLmeRRPVFCO6hnJEVIPsk6RpYLaqYU=
X-Received: by 2002:a81:5dc5:0:b0:2eb:3feb:686c with SMTP id
 r188-20020a815dc5000000b002eb3feb686cmr13733449ywb.268.1649364152378; Thu, 07
 Apr 2022 13:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220405091750.3076973-1-arnd@kernel.org>
In-Reply-To: <20220405091750.3076973-1-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Apr 2022 22:42:20 +0200
Message-ID: <CACRpkdbVHOyq_dt7dtr8htzQqJ0BbL2K4_p1HX97miJJ4qnUnQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] ARM: ARMv5 multiplatform conversions
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hubert Feurstein <hubert.feurstein@contec.at>,
        Lukasz Majewski <lukma@denx.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 5, 2022 at 11:18 AM Arnd Bergmann <arnd@kernel.org> wrote:

These two:

> Arnd Bergmann (12):
>   ARM: rework endianess selection
>   ARM: ixp4xx: enable multiplatform support

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Linus Walleij <linus.walleij@linaro.org>

I booted on the Gateway GW-2348 which has some ethernet,
PCI and compact flash, LED and a button, so I could test a
whole lot of stuff.

However when switching over to multiplatform I needed to severely
overhaul the ixp4xx_defconfig for it to bring the same drivers in as
before, I will send my patch for that which I think need to go in in
tandem with this rework for a smooth transition.

Yours,
Linus Walleij
