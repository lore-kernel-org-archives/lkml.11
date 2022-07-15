Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D536EC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jul 2022 10:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbiGOK6f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jul 2022 06:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbiGOK63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 06:58:29 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEFC85FA0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 03:58:28 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id q9so709300qkc.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 03:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xrkua+hfhIJ1CptLiiW8VOQJd1B+fpeDVj5Tjr/dofs=;
        b=BHHWXE7yzvIrkwAiDh17ZGCqeGQFeNqeHvd//+ttsFgRZ4GLPvde/KzT+HS7rq6ITx
         iEZE5yYJLtxXnn4+V95NS6eUXB79H2PsJ6VZnPwVYR5c6r9tBhtLo/lomr3CSN8LRP3b
         ALPFVKbGy7ZeQrb19v77EAJQsQtFpDWdtT0UJcT1bEY89an7unVZC/2tieFpkc3ruzK8
         fZdQc0PhxvdIhaGjcyfZi6hs8wTWWpXL7Wk/UB2NCqNixZMBbkFwNqDkeNHdOkGyOu7f
         q9/rLrJHpQbtyvFnUZ1by05domduMxRpO/G17J1lGOoFLnFTCqgaK27P3O/AYKqhxDBr
         UlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xrkua+hfhIJ1CptLiiW8VOQJd1B+fpeDVj5Tjr/dofs=;
        b=J+3wRBM8HvPHMoIobkWNa++sCm6Nsg61ZMhtdT9hHVm9qoJWoTX3JEBHiEGXryih6o
         P6R3TuWtNc9a9wC+MhOFd0zAfGQ97t5CX8oaGmzYlPjGs3Kvh/jRgjgejpa1j4NBJFmB
         brNNr8HALE7O4W8AkmmKyARRfIV8+o3zX90iM75zdy74Hg/RoMeeAAgGGb4PGsLf2CAC
         ibwfXZp1lkI7cHJ9gDhpYswYCFCHYvHJab+b9fZPfDXSh6Yj1FKXndlRQmPd23NQ+WZa
         CPYiRcY5fmnO+t0481S1dguZBBKNr3apLOpcDNtmMQGx6SO4lPJx+7UqupDSd7BSUHaZ
         hn1Q==
X-Gm-Message-State: AJIora9uCR6UJNW2i8PypY2+tkcFU5jZkNORDdusSs6+xcM7F0AvAArG
        LurTg40CXHuZ5/ITlLi/+vcRz//wGomIGIL6/5+8xw==
X-Google-Smtp-Source: AGRyM1uijUcLj5+a/BYNrAa8fgEmFUIYN4MUFnBaE0lKHKhRYLZiK1talPBo/631iAIRmSK/KhcM02/MpYf+knlvyW0=
X-Received: by 2002:a05:620a:288c:b0:6b3:9d1:dbf1 with SMTP id
 j12-20020a05620a288c00b006b309d1dbf1mr8804100qkp.593.1657882707457; Fri, 15
 Jul 2022 03:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220714124333.27643-1-johan+linaro@kernel.org> <20220714124333.27643-30-johan+linaro@kernel.org>
In-Reply-To: <20220714124333.27643-30-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 15 Jul 2022 13:58:16 +0300
Message-ID: <CAA8EJpokYBLWxqpeHDbDDGpkZPWf+zGHnQp2HhKX6gP+Laz89A@mail.gmail.com>
Subject: Re: [PATCH v3 29/30] phy: qcom-qmp-pcie-msm8996: drop reset lane suffix
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jul 2022 at 15:44, Johan Hovold <johan+linaro@kernel.org> wrote:
>
> The lane reset is defined in the "lane" node so there's no need to keep
> adding a redundant lane-number suffix to the reset name.
>
> Update driver to support the new binding where the "lane" reset name has
> been deprecated by instead requesting the reset by index.
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)



-- 
With best wishes
Dmitry
