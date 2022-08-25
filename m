Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6247C28D13
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Aug 2022 13:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242545AbiHYNWK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Aug 2022 09:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242460AbiHYNWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:22:08 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E579498D21;
        Thu, 25 Aug 2022 06:22:06 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id h204-20020a1c21d5000000b003a5b467c3abso2674055wmh.5;
        Thu, 25 Aug 2022 06:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=LjNH+rDqugavNJp3hfKsPFFkZZAo40JmydtK1bPNImg=;
        b=IBdWEMzcIojQZhI6OxSv036EP2WxO8Z5sdu1IsUfKrxTEe4fRKdC71m3L6wNR0n2BH
         p+44qjioNE2OML0H/G8/uxcmc1JPx2xSNQqDyRCMGpuPQHpx8YZUENODrvw2fskG3qMQ
         IgarLHEEsN/R93RwIag0s2En4aArQPmZhZu11nGTjYo0ed59bL1cYvnXQmGbpjE6f5bd
         wWNTJFlpl0VxSr7uniTQ12erkIG0f+P2S2zy9V24DJZ99vpEG6ahP6xlhlbuM3yOEk0K
         jNuEdxfN2rVyar9PSEkFNmVtzup41r2moXkXAxcy/a+kRkjS/uKMyxJH4EqZQcTep5oB
         5HUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=LjNH+rDqugavNJp3hfKsPFFkZZAo40JmydtK1bPNImg=;
        b=tTCLJnks5G0SXj2QuH7/sDeZx/gNteRcq8nkHEiNYcqbJHsc1RoB5T2ZRZFFi34xAy
         j6ss6ihymbMJr5X5xFmKiFYaXxXqWkUnNvbh/woFOr6EXRto1+dWgeYKzFSVgMwLinEl
         0JQQOPJNrqttrk9RUg/iBXuFNVdwdba0CCdbu3qlyUQ7N6a9vgEmTv38o0V64xLuMr7v
         MmjwiTNGPUWIhqSbwdH2HDv9GfvN32sCNgdoWOViF+Mf4peLYmzO14QH7I9f5Ikq09Hj
         0DEWrKnglAuUD/R3TshEpYWKz8HcA2FPbhrnPcP1k980WlBGBU6tSOaVUfXaJfmyVGup
         +hbg==
X-Gm-Message-State: ACgBeo1aGVlW+/soCpwqq4rNQTfBwg7+4DOjICHX/RklPBJVt8eBHv0m
        c8YFyHIEDFBFPZa6GFKstJA=
X-Google-Smtp-Source: AA6agR7l+54/fC4VeqRxOTYKdGD9z1iXyk9d6Zeg/VujSTEWSl+r+eiSo8RmJd+yuHHXLVr7pwZS/A==
X-Received: by 2002:a1c:4c11:0:b0:3a5:4d01:54be with SMTP id z17-20020a1c4c11000000b003a54d0154bemr8559682wmf.32.1661433725318;
        Thu, 25 Aug 2022 06:22:05 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id m10-20020a5d56ca000000b002207cec45cesm23191455wrw.81.2022.08.25.06.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 06:22:04 -0700 (PDT)
Message-ID: <f07cf9b9-aec9-2564-03c6-bf2f0acf897c@gmail.com>
Date:   Thu, 25 Aug 2022 15:22:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] dt-bindings: soc: mediatek: pwrap: add compatible for
 mt8188
Content-Language: en-US
To:     Sen Chu <sen.chu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Hui Liu <hui.liu@mediatek.com>
References: <20220726104242.24839-1-sen.chu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220726104242.24839-1-sen.chu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/07/2022 12:42, Sen Chu wrote:
> Add dt-binding documentation of pwrap for Mediatek MT8188
> 
> Signed-off-by: Sen Chu <sen.chu@mediatek.com>

Applied, thanks!


Matthias

> ---
>   Documentation/devicetree/bindings/soc/mediatek/pwrap.txt | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
> index 0581dbda4828..d24e2bc444be 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
> +++ b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
> @@ -28,6 +28,7 @@ Required properties in pwrap device node.
>   	"mediatek,mt8173-pwrap" for MT8173 SoCs
>   	"mediatek,mt8183-pwrap" for MT8183 SoCs
>   	"mediatek,mt8186-pwrap" for MT8186 SoCs
> +	"mediatek,mt8188-pwrap", "mediatek,mt8195-pwrap" for MT8188 SoCs
>   	"mediatek,mt8195-pwrap" for MT8195 SoCs
>   	"mediatek,mt8516-pwrap" for MT8516 SoCs
>   - interrupts: IRQ for pwrap in SOC
