Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2397AC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Apr 2022 12:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378397AbiDTMJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Apr 2022 08:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378395AbiDTMJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 08:09:40 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56BE36B5E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 05:06:53 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id r13so3088015ejd.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 05:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vhp+0ndE0ICnySnfQWzK5OgPfXzG7nhddvg7N0bvrR8=;
        b=h+i/gphVwsRQj1NIlLc2qh40jf4VTap2KZa744ixBxWBjLZ1srE+bOYbGB7feV1/Jy
         3eEDy6S+dlFr/5lukmRPSNNfJV+XkCZCSzVPG+u0t3emjhewWpCP7ptz7yj8UH4rZ4A9
         5DhkyEVRQ7I+b18FQcPBdlyaHfiFkpbkGgtAuH7KG29jy2I0ofG3H+CC/1OfVzstuiFr
         QVyqBmgkeGGtQrxmqOzNrfeSYas98s13obTBwPcjOaml7EZ7/km+edYAeywPxR1bf64S
         ppFSrVZlGYru0BGJQWbDX6lUwkjrkg7b2kglbGdnDTsXBKi74SCX20dXmTYO05G6NfYw
         6oZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vhp+0ndE0ICnySnfQWzK5OgPfXzG7nhddvg7N0bvrR8=;
        b=IpsGM38VBvSe9Y4qjUqxxFGFXH0uwrS1ZMcwV+Y1MVADM2oK5lq1uym8isQRHIgSoQ
         VeYhc0Nev6eJuKONu0reDMTFlwxzviln5GCGE148BXqkiSWBPhmQqVViSht4AG+p++EH
         DQYyyVGKElHZEZ+3t6dawN4r0ypYOmplPD6yCKCUmSqdI03tnkY4Rf0AqQZG2YfJcAC1
         FwzMiGXY1BsTyxGEEUw2U6ly54nTNUmou4xbEemxvfexev9UjbScKKUYi/wH8lxl0v9r
         nzUPRUuDp9xkT/i+tiQGAmIlU5cJXalzkRO1imvI4GmAT6RZWU2oFZUrYke00F9pevff
         vL7Q==
X-Gm-Message-State: AOAM5318hCZxQBV97ADbyfuNUXzqU22aO3EfFZR72DRm89brqlfX/FYM
        LVOhz0/bth22wKN6GZaqhHex/zMlvu+Fdw==
X-Google-Smtp-Source: ABdhPJzs23eyNGxDvDwrPElsXgTnQ4q6A2KbzftDpjqRnuzUC6s46rNyLRvz68VDexw8sqw2dBTC5A==
X-Received: by 2002:a17:906:7945:b0:6e0:19:5f7c with SMTP id l5-20020a170906794500b006e000195f7cmr18800900ejo.458.1650456412297;
        Wed, 20 Apr 2022 05:06:52 -0700 (PDT)
Received: from [192.168.0.225] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id k14-20020a170906128e00b006e4b67514a1sm6749071ejb.179.2022.04.20.05.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 05:06:51 -0700 (PDT)
Message-ID: <d81262d7-9624-7d85-cfcb-e675d32bf86f@linaro.org>
Date:   Wed, 20 Apr 2022 14:06:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: dmaengine: qcom: gpi: Add minItems for
 interrupts
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220414064235.1182195-1-vkoul@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220414064235.1182195-1-vkoul@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2022 08:42, Vinod Koul wrote:
> Add the minItems for interrupts property as well. In the absence of
> this, we get warning if interrupts are less than 13
> 
> arch/arm64/boot/dts/qcom/qrb5165-rb5.dtb:
> dma-controller@800000: interrupts: [[0, 588, 4], [0, 589, 4], [0, 590,
> 4], [0, 591, 4], [0, 592, 4], [0, 593, 4], [0, 594, 4], [0, 595, 4], [0,
>   596, 4], [0, 597, 4]] is too short
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
