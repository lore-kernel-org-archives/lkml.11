Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1578C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 08:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241524AbiF1Iaf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jun 2022 04:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239316AbiF1Iad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:30:33 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59B925EBA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:30:31 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-31bf327d4b5so19563427b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e5Z/hG8NSQiNO2xEelBjBj++4NPTXkLY1E3WsIfZuUI=;
        b=cFOT1JeSSqICBH1zsjVCn1t4/wd9526VEQ9A7gSgpYHLbvn2rhoMbjLoeB6tj9iewe
         AdkecZgznE2OlgxJVBf+K5LIK1jfo3uTZjJciW4QBx7tGdAVy7sfhelYyFvIhLEXle4R
         193RO7PBOkJT0a4ggra0cRHnp3jrtgdKbvlZVn0I7gWyBW3YaGmstvc/iD3877IBDudl
         +zN4eg8tCA6O+k1W488D2HRbGUFsjC3CM5hc883woRtiCTjyeZgDj4oddUM02NRy8pyX
         KN9M8thFWr4NWu3KWX05nx8tgySBNRE4e6GipfTrsvuW/F2A/30OvVYyI6IqG2eQ25dJ
         Yjkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e5Z/hG8NSQiNO2xEelBjBj++4NPTXkLY1E3WsIfZuUI=;
        b=5kWjKp8kKSca03Ho4gQSHw8TvJ1sXMK59g/8gORVxTvSzRTXuiZh/FnbwiVgmDgZd0
         FjKzmQBDgrHBMfB4LIelX1GQ04ipScu4bAX/pTplEJ3FMlXd6xHUOUipxr73mNBnbDb5
         VYyJx8qTsGlm8cKBzQuFcbVrHe9lwQaQNfBkn79vwNRcTtkH42ZCRBi9zmoZrkZojGQG
         pZ5Uq1Ldd7mr4ZeaaOCt0DJm9Upgby3b84J+qMPiahg7qSlVJQJlhz8D/NI1dsh6H9fZ
         A4Eev7N+i/81E4JTVayVPSQCjxoyDdNIct8HlWXfML339+OqKUXA4nmuHnnjr8CEPOKZ
         dDNQ==
X-Gm-Message-State: AJIora9FvtGn4jxirIZxq17uxdBLPMUG1oi6qkH5Qfa4a/Jpl1Copdt2
        0/r8Pj4ZzjdE7HVbUY6TgU9oY7VShzFQVo8y2gr3Cg==
X-Google-Smtp-Source: AGRyM1uKl2WU9AxFxQXaBRZSVk2Jbhtzgz+hPFdf2a+y8B4wMh0z4Qb4XsuZBsPg7IrlqHvLAYY5VnUpxXIbYIjzF14=
X-Received: by 2002:a0d:eace:0:b0:317:87ac:b3a8 with SMTP id
 t197-20020a0deace000000b0031787acb3a8mr20429857ywe.126.1656405031018; Tue, 28
 Jun 2022 01:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <1655462819-28801-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
In-Reply-To: <1655462819-28801-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Jun 2022 10:30:19 +0200
Message-ID: <CACRpkdbgFaPxE+ZtSBPLdOeM_vj_qgf__Mk1Yb4KSWrzpup2Ug@mail.gmail.com>
Subject: Re: [PATCH 0/4] pinctrl: pinctrl-zynqmp: Add tri-state configuration support
To:     Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        git@xilinx.com, saikrishna12468@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 12:47 PM Sai Krishna Potthuri
<lakshmi.sai.krishna.potthuri@xilinx.com> wrote:

> This series update the Xilinx firmware, ZynqMP dt-binding and ZynqMP
> pinctrl driver to handle 'output-enable' and 'bias-high-impedance'
> configurations. As part of these configurations, ZynqMP pinctrl driver
> takes care of pin tri-state setting.
> Also fix the kernel doc warning in ZynqMP pinctrl driver.
>
> Note: Resending the series as i see this series didn't went out due
> to some issue with my mail client. Please ignore if this series is
> already received.
>
> Sai Krishna Potthuri (4):
>   firmware: xilinx: Add configuration values for tri-state
>   dt-bindings: pinctrl-zynqmp: Add output-enable configuration
>   pinctrl: pinctrl-zynqmp: Add support for output-enable and
>     bias-high-impedance
>   pinctrl: pinctrl-zynqmp: Fix kernel-doc warning

Excellent work, patches applied!

Yours,
Linus Walleij
