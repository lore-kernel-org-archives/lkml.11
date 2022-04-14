Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CE5C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 07:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240427AbiDNHjK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 03:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240459AbiDNHjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 03:39:04 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DE356C02
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 00:36:39 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id b24so5222195edu.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 00:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gy7AkBu7bAXBU0y3wAkFQ5PlduSnOoydEHQ9dHG0xqU=;
        b=zBKde8JUkVKVlpgHIy6ft1h9KyiEPQ8x3AXpkjobSHYAeGM6icbkw3E6IJ1RH6dqmM
         3KH6n20js6DSceg0j8p74wH7vBnBBOOPIZ29lWuNsWblzEdgYYFgW8WWqEJ7eISN9/z/
         ZNN1dLcvHHLV/cUhush3kMfQD/DqN/h1GsdB6f0mFFDPVNVh+yHYdl+Gifg2owlbDZ/l
         FiMC88SMJ8AyjGlVrPi77bCa8VKocDQ6I/n9+FbXZM/TepmI2WEIG1Tl+OZsdD8d/cTQ
         9YuFRB4IdpJ0gYAoXG6G8zGJ24xVlIrm/w2Od6J8laEpvkVhBYghr3EA7yRwIXftchCS
         U5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gy7AkBu7bAXBU0y3wAkFQ5PlduSnOoydEHQ9dHG0xqU=;
        b=2IGJJK1NtIpYokb67WgYRJ4Sw+f+UOgucviemfmhcanp2L8XRujsvbxSm6EO6rEBnR
         WFYSMwAU9m6lKIesJlFTqTQ0uf12vbeQiFeySlLZVwS0qXEQdquOfBW1Spoof40gd6y5
         +jMrhIpe3DqqxAunz0dXYRfAHjEPiWfwowluQLCbapRKwVNyB2KDKlKMqHrOenX5oXpU
         jRY++ZP7yrZHJf8N5AksuNEiHlmzXrt+TSGET7xangKevK48QyAyW70rEY4VmPYcOsdX
         5XgO/ze6Fjwmv6mDu84Ba1lPjclOoD3Uws8VA+vwVcIT1yOHFPlbZAJ/FPuXLjNnztGp
         +ciA==
X-Gm-Message-State: AOAM5326rbpnbxhoME1R36abJsg8pTzR0cmaUZ27BQ8m15C5vj5a5J+T
        uHG/xObLaVY4dbPHy68t7SuGLvpUDhRRO/5p
X-Google-Smtp-Source: ABdhPJxVkieNFrCUgPtdH8sa6eUkB8QCY/095ocDDMYsh57rFUNDZ8O3DDoHtABO6gVaXsAwHX4/fA==
X-Received: by 2002:a50:cc82:0:b0:41d:5fca:10c3 with SMTP id q2-20020a50cc82000000b0041d5fca10c3mr1563726edi.373.1649921798496;
        Thu, 14 Apr 2022 00:36:38 -0700 (PDT)
Received: from [192.168.0.209] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id k22-20020a508ad6000000b00420bd71e06bsm653456edk.79.2022.04.14.00.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 00:36:38 -0700 (PDT)
Message-ID: <34a14968-e939-3e22-9385-e31be1a96bbd@linaro.org>
Date:   Thu, 14 Apr 2022 09:36:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: dmaengine: qcom: gpi: add compatible for
 sc7280
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220414064216.1182177-1-vkoul@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220414064216.1182177-1-vkoul@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2022 08:42, Vinod Koul wrote:
> Document the compatible for GPI DMA controller on SC7280 SoC
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
>  1 file changed, 1 insertion(+)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
