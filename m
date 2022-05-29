Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADDAC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 29 May 2022 19:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbiE2TTK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 May 2022 15:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiE2TTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 15:19:07 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD956C0EF;
        Sun, 29 May 2022 12:19:05 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id y13so17302194eje.2;
        Sun, 29 May 2022 12:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wc+EE6uFclfQj0Z++trSIQDhAONqieaeq0cvRbIdEio=;
        b=BlHzcGTrKIpNrIPqJBGVqSC3Fmx0nmtG91acp41+I2sSr3UwjOBg7PTUW2jugiyjOS
         KV8gAeOQp1DF/XZ9Pooh/305TP+Doq4JtQ0i8yC2Av2Uz2LdEKbs+j/83L4p2STY1KYx
         En+nLsDLwEMuFHglSNpbCLREVZyMiC0ZGljmE6AXUHKafD5ej5j3ZPMkpy6pzasMO3IQ
         YFcV65NJBFwWCiRBCdOIGxUgh/6rkm9bY7FuQkIDBQxHwPesIXk/xjTinHFakSnFUihs
         TZY2FgsN57eQPwg+TpyxneWO62ff16jYV2HpwWXkdDu7CPj6cTmh9S5XEfpOm6bfxalB
         r1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wc+EE6uFclfQj0Z++trSIQDhAONqieaeq0cvRbIdEio=;
        b=Szvc/BCyxNM/RQ2RMyY1MfL2vqxd8TRCamsxHd/VE0L4f35hh3hzJzhQDavkOmwVEI
         Mf2MUxZq/ZOGFaL+7t16qWfDVdicFnstV3H7fcFEAgzRb935nRblJJEmDrzN6zcDLXgY
         uIDi+4oi3ZfJ5YgNKjweSdMzsgRC7qUNc2BWU+rL52krVjq2V6KI/8RNYVFMsS/H58DV
         z5ewQVdfwgzDYp6GspnldtVBLcrU30cj++prq0Q59L+I3/yZ/Ar3V4YHh35dOElJYd9z
         IxgozviHg7kGd8UsjxdbVypWiZe2tQWBa++75Nf3Y1KNEZ4M8szUBUFAy55+ghoodO8S
         J7kw==
X-Gm-Message-State: AOAM531sIZZXFBZVV+zJWR6zr4sDC771/XfiNuPbWomvL0OWSUXgTgAG
        i4+oZg8fQXNDnCJUpB4FTrkBTszFxcUgUNRbkZIeNdwvE5U=
X-Google-Smtp-Source: ABdhPJzCykqQ15vSmNqR86SAPkvkeK17qhqbNMfKxY3rcmoGgzF/riVWYcYCENQrz5Q479KG33OuWkNZXm5nuyzqvrU=
X-Received: by 2002:a17:907:7f21:b0:6ff:10b:9cee with SMTP id
 qf33-20020a1709077f2100b006ff010b9ceemr25697803ejc.302.1653851944022; Sun, 29
 May 2022 12:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220526204552.832961-1-krzysztof.kozlowski@linaro.org> <20220526204552.832961-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220526204552.832961-2-krzysztof.kozlowski@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 29 May 2022 21:18:53 +0200
Message-ID: <CAFBinCA=VXjR99AELCnV8nLbt=DinWhcpmKnC1jN0p6Dpx83Dw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: meson: adjust whitespace around '='
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 10:45 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Fix whitespace coding style: use single space instead of tabs or
> multiple spaces around '=' sign in property assignment.  No functional
> changes (same DTB).
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Neil, I have seen that you applied this patch to the v5.20/arm64 branch.
I am not sure if it's supposed to go there. If not: please add my
reviewed-by when moving this patch.


Thank you!
Martin
