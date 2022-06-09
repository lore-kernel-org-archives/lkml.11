Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFE6C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jun 2022 22:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbiFIWL2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jun 2022 18:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiFIWLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 18:11:24 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028041DA7F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 15:11:23 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id e5so6227146wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 15:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=InjL74e+G90ZxHkv8wOPoRjvtkmrCI8/zFa+GegrWrs=;
        b=ZZ8Pi5On3BCsTOPysE3hM6XnnDucvZsZ0t/ef7wkpsRg8lN4Df2vn+K+Vo563wBfbl
         UoItTQW5DUWNtuO1hm+hjoXsIUr33oQkeHCIIXk4jUJm0z2AFkkcKQ+oc63iIDC3QkQP
         fSYvUToL2vsacT6stkdK7JTQtlcItWEs5nt9WANRz4cQSqXVGwJH66iLEirchtjLm4LM
         DRfhfzeHvWlmGDqVgEFfHiUftWWixFr6digktG25QTfp7eakexLJ6MYV2vt0tNTRUXuo
         QMh6lWAraDLRyEqPbeCsxEc8jeP8qK9L1MU22uG1iRWItFND0ap49cEM3iPT1IOp5InB
         c8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=InjL74e+G90ZxHkv8wOPoRjvtkmrCI8/zFa+GegrWrs=;
        b=CqvI5JtoeXTUp36kxslcN9hNbXfzCwAvLwCVZtBaxDjMscyjpUWDsiAskMAaGLq9MX
         lY3Xwzd+CyvlHmugEpd/VUQ7YrDuy7wE9ZTBwbXtxgRYidD34FCZJJmqrP2puJ90qYLu
         vOX1PxfPW3yOU2H+7lIl1rF15SBFKQAdp4ewA7M5hI1ngt+DqYZMRhChrkSHujUCVKn4
         1SaQP1vgQQCG/mvz+8bwd6v4uPjv00i6xzIWeyDHMi+PjS/wr4+VkuoYqaNM9ycDK1Xm
         5z2L/FcZv5AOwiAAFX2tgxmAF/20dXNVDucshTuDPVEal2O8vIa78lwurb49M6FhiFej
         7ZLA==
X-Gm-Message-State: AOAM531v7YwgFnenX1Iie1c5RyMuMtltc8TlKoZiJHU+TkK0Hj7D6JeM
        NBH4o0gOPVNva6NzvWNXVB2+/mnrl0/GhOIqMxyMwA==
X-Google-Smtp-Source: ABdhPJz5c1e9+2oQkV6XjK2Ycf7s16aY52v1eiy6DzzvjdPdlELuaZ+jCSVlSpyHhiU80AGroldiHhcBwBe+Ts442Bo=
X-Received: by 2002:a7b:c392:0:b0:39c:4d27:e698 with SMTP id
 s18-20020a7bc392000000b0039c4d27e698mr5397998wmj.57.1654812681381; Thu, 09
 Jun 2022 15:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220608095623.22327-1-tmaimon77@gmail.com> <20220608095623.22327-11-tmaimon77@gmail.com>
 <3aa70c91-d6d7-e2eb-9c45-a1fb0a5751ca@linaro.org> <CAP6Zq1iCJO3AzHnG7RSQ1pyVwayxs+X3iVM4U=6j2k0EgR7psg@mail.gmail.com>
In-Reply-To: <CAP6Zq1iCJO3AzHnG7RSQ1pyVwayxs+X3iVM4U=6j2k0EgR7psg@mail.gmail.com>
From:   Benjamin Fair <benjaminfair@google.com>
Date:   Thu, 9 Jun 2022 15:10:45 -0700
Message-ID: <CADKL2t523rdOnm=iUNXcw06Soq3NjbJEsEiPwCXdSx3Np-rNDQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/20] ARM: dts: nuvoton: add reset syscon property
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Vinod Koul <vkoul@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Robert Hancock <robert.hancock@calian.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomer,

On Thu, 9 Jun 2022 at 14:30, Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Hi Krzysztof,
>
> Thanks for your comments
>
> On Wed, 8 Jun 2022 at 13:07, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 08/06/2022 11:56, Tomer Maimon wrote:
> > > Add nuvoton,sysgcr syscon property to the reset
> > > node to handle the general control registers.
> >
> > Wrong wrapping.
> it will be very helpful if you could point me what wrong wrapped in
> the commit message, is it the explanation or the header? or something
> else?

The commit message body should be wrapped at 72 chars. You can fit
more on the first line if you reflow:

Add nuvoton,sysgcr syscon property to the reset node to handle the
general control registers.

> >
> > Best regards,
> > Krzysztof
>
> Best regards,
>
> Tomer
