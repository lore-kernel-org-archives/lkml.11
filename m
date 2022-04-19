Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60BFC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Apr 2022 22:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358256AbiDSWn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Apr 2022 18:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358253AbiDSWnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 18:43:25 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C631C1BEA8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 15:40:39 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2ebf4b91212so265377b3.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 15:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/b2WbchJKMIG7OLkhvKci/yGaZfbKG5zXqIPhc0xmR0=;
        b=Tt68ItjSM/LAp3E41Jog8JtRpHi8d3dz0w7VxFHGbIGW0coAayZVgW+uNFaU40QSYB
         RsyQDZ5WB1RdpbFj9bnLuB3uBYQuekkcV2YsDqMKmmbniLcX7lL0GM2JWqqjFBWk07e/
         oj26cXfa1ekeVewaAhTStvCnPv2Vfj8pO23xJzyJViUwALqTPc1reSR3b4+Q2YG04JpY
         +/FqmFJ/SC/BlughesaZcUBbJFtsgt7X7+cIMgRHjonDxLKn3+QT3Qhcdzhl3JY+/d83
         dv0ATGFYp5vzYhpRBcS5Bh4SieRgna2e0VfbWFcpS4bYYwsQFpMnqDL6pgzutxom/bys
         3DVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/b2WbchJKMIG7OLkhvKci/yGaZfbKG5zXqIPhc0xmR0=;
        b=nS6kKAFvgYjWa75nkniIZIoTGn8iPDbtAS+fsWqWgKANRodcaR4ljPjs6imcxoCVPH
         THYmQfL3ESilxD0f1auWJx4W3UpHyCUx/n9piSvqeppy9/CyK20n/Sx3kUTLPypiDXgL
         UoUb3Nw/SRbhEd1VzE2o+iFmKavH8YKrTtNN6f1D0gTaE+DYtm2ikwntkjZ9Vf7a0bjR
         Gq9gvTe7VNbkQ6TYEkmbwkzZGd/XJ+ksD1+yTL+ryeCbHcMXAkwPW4x7/aznrwe6Jc1h
         e6FjjXTmc79GozVu5RHXGkWQdtslCC5LIG0TJqrwqFtgUFQBoSwFissSEhnGh589EO1v
         vWmw==
X-Gm-Message-State: AOAM532I/TMr9cXukqBG2p0OgcICR1gQOvEKY1pO+F6WLgIoYAeRI+E9
        e1bvn32JAURkMi7Easo8WUqi480Eu2JPVVdBqTSt3Q==
X-Google-Smtp-Source: ABdhPJxBvWoEuALS1rZ+F1VO+n+79HViIlGOhO/TPJsJqyRQp0aw9SbnBM6F0FKiFmwkzlvdYO6WDRlljl0Ty2m1AiU=
X-Received: by 2002:a81:6d14:0:b0:2eb:fbdf:639 with SMTP id
 i20-20020a816d14000000b002ebfbdf0639mr18226715ywc.126.1650408038984; Tue, 19
 Apr 2022 15:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220327160813.2978637-1-fparent@baylibre.com>
In-Reply-To: <20220327160813.2978637-1-fparent@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 20 Apr 2022 00:40:27 +0200
Message-ID: <CACRpkdZUVDOL7LzqhaZbq6JA8MxAAqER++c7eCJGY8c5s7Z-CA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: mt8195: enable driver on mtk platforms
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2022 at 6:08 PM Fabien Parent <fparent@baylibre.com> wrote:

> Set the pinctrl driver as built-in by default if
> ARM64 and ARCH_MEDIATEK are enabled.
>
> Fixes: 6cf5e9ef362a ("pinctrl: add pinctrl driver on mt8195")
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Patch applied!

Yours,
Linus Walleij
