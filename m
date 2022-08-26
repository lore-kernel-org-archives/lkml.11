Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF75ECAAD7
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Aug 2022 08:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245184AbiHZIHB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Aug 2022 04:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244376AbiHZIG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:06:59 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D87BD4754
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:06:57 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id og21so1718475ejc.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=EFxNeR78FI3l0OC7HZl6P9i468zpQHaQ3saZGSwaod0=;
        b=uFWdeiGlLmROCVF+abK6O/n+PsbMttVes6THDJ8y2LAohfjd6WA5TiVYxHj9GMiEz/
         /o2V0PIbRDule0ccYIFRdZqGaS9X6IIiTK5sAY+4lr1s+PApBmbeMsf7OoMrRngJUAci
         edcD4w4NCdSLmcDx6yybnDfSf6SiGAgoLVS/GZvRyKoMrkMjOKtyciatt+Ty2YNT8HGU
         W2ZfCiIBS5BvuTIcEt6NeCnP+KlL1qfENeyWPlxMhtoJQoctwMLSzjoreyHbpHL1pS28
         rkXNjwvoCskyZQU3peT9/0ORJnwuJxAG5hncEAo/N+YUhHmm+S22atJYioIyqr7giWqe
         M0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=EFxNeR78FI3l0OC7HZl6P9i468zpQHaQ3saZGSwaod0=;
        b=Ly1niXUPDy3BfbpqmDizUNuUzxKS9fVrY9RbxYC7sLIZLZQFzMWJCQKqXGeqQx1zwo
         KP8lZSU4I35tRc0P1ghYoJ2JczKyQ6R+BNV7c5ijTphVSXfJNpC6p9G4bd85H+cg/tSf
         UE2UTpK52PRZ65gJfgeaqHzJ3HBsgLX5w787F24QzGj/ackEfVzsrF5ALTzSsbq7nLT3
         yUcYHrq4vTc9TmSNvi/6S1MFykfwDXKU70oDXCOvYc+VBQaD2kYg/468bdj29lzUJXgV
         /QzWvYcVAn2c+DpsHEN01orcPXinVjJqzPuu9DqHa2VVUDbiI5oOo8MDwD35xhjDHmgq
         KFiw==
X-Gm-Message-State: ACgBeo1CDjFzAZE9x8QYVhOpLZCiLkQBh9sHiRycYEdMu6ilkQ1FhdHX
        1Z26Iey3dLaPg5aJKh54pnKQSiehA1uNkYDTUGZwIg==
X-Google-Smtp-Source: AA6agR7jN7XyheMHhzyh7YMEy8KcA8oU9ydIho7xiM2GGzQ4ny4ssMEayxNW/Er2QZsizb6/p3b/jGMLqTYIWr3h2tY=
X-Received: by 2002:a17:906:478f:b0:73d:7919:b23 with SMTP id
 cw15-20020a170906478f00b0073d79190b23mr4413839ejc.690.1661501216423; Fri, 26
 Aug 2022 01:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220816133016.77553-1-krzysztof.kozlowski@linaro.org> <20220816133016.77553-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220816133016.77553-2-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 26 Aug 2022 10:06:45 +0200
Message-ID: <CACRpkdYDAY-OA=YJU4J=-16PNmYb9LdnowFoMSbhQHKqNWxmVA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: pinctrl: samsung: stop using bindings
 header with constants
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 3:30 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> The bindings header with pin controller register values is being
> deprecated and DTS already switched to a DTS-local header.
>
> Do not reference the bindings header in schema and replace the defines
> with raw values.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Looks good to me:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

I expect this to come to me with some pull request later.

Yours,
Linus Walleij
