Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0EFC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jul 2022 07:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbiGOHgD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jul 2022 03:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbiGOHgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:36:01 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7117BE3B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 00:36:00 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id u15so4772842lji.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 00:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mqhVEUWoJhyGaRXatPdO6jF7+Eft9kIRbLVR6FWlzs8=;
        b=qjvMjtSFhMHa6WnM74siqopulg6O3rjmx3IiBooXy24W/I4PZDNd+xl+uQGyiC1DZb
         lWSfhBY62FfqUJPPAXUjczFT0aIo4m6S8H0G2jRVq8b5ye6HG/pii+GGvDCQtIvh+fnO
         XRT06LG1Jrsu9wN0TpvNrdx+gSWPx6A80gCufY3qCCovtvtHOgGRPlxsaSSmDvfOs+Kx
         8gMkrLffn5LHOlrIxv7+/xe1caZMYMya/z7j91Oec0mGl4cN/XYqMSkWSqkbC9ckT/LP
         CPFq0oj54KUPsoZaR86X2Te9VAE0jtoZgM7Td6AvTmm6RDdgwd5pakE6FUb5ZdfDhFkV
         uNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mqhVEUWoJhyGaRXatPdO6jF7+Eft9kIRbLVR6FWlzs8=;
        b=qQlqlaD02j9h/di/HkmJmbu9GeiNFa8bKTVVp9/BnLMQD+UL84sKthJjV+yV8ySrgU
         X7vI/DJ8zQK4j5ung7A2pN25LfBKwC6YUFJqTjHjtHDCa7vSRIpyDBg2apg8STd1OH5I
         DJ5TDcO4Bzws2OBL+H7sR4He+O8vrt+1ogQZRkXZ/4FdanQmeR84c5TGDo2ap7yZBtYi
         WUWvYT06oDNH5+bmLgw124iFDVzQO8C7U6+hgQzqEYJyZ7raWDCgPZe2PKA/5M9sxD1s
         8soSB3HPcllCQYDGI03YQ3hdLYcgqf3D1UzuR49uf2ADTZRNRN+NWKi2QsAlp7Pg7Pp3
         JMtg==
X-Gm-Message-State: AJIora/By1N9G23gCK6AY7HaeoWGXKL5dOQ9UljKed3fXIX8fMyFCZZB
        AW8AKDDJOxwIeBEWWAq27qqLPQ==
X-Google-Smtp-Source: AGRyM1tOzrr9Yq9VEdfdXk1wmZFGhIc3cdIcL/0dwI8mv3a3rDX0Kkzg3QqLlEmjX7QvHubznwMfXQ==
X-Received: by 2002:a05:651c:1a0a:b0:25d:a17d:9c23 with SMTP id by10-20020a05651c1a0a00b0025da17d9c23mr1419736ljb.480.1657870558571;
        Fri, 15 Jul 2022 00:35:58 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id 3-20020ac25f03000000b004790a4ce3e5sm771300lfq.278.2022.07.15.00.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 00:35:58 -0700 (PDT)
Message-ID: <9f8217f5-7369-0abe-cf8a-d501e163580f@linaro.org>
Date:   Fri, 15 Jul 2022 09:35:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 02/19] dt-bindings: memory: mediatek: Update condition
 for mt8195 smi node
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220714122837.20094-1-tinghan.shen@mediatek.com>
 <20220714122837.20094-3-tinghan.shen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220714122837.20094-3-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2022 14:28, Tinghan Shen wrote:
> The max clock items for the dts node with compatible
> 'mediatek,mt8195-smi-sub-common' should be 3.
> 
> However, the dtbs_check of such node will get following message,
> arch/arm64/boot/dts/mediatek/mt8195-evb.dtb: smi@14010000: clock-names: ['apb', 'smi', 'gals0'] is too long
>          From schema: Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> 
> It's because the 'mediatek,mt8195-smi-sub-common' compatible incorrectly
> matches the 'else' conditions for gen2 HW without gals.
> 
> Rewrite the 'else' condition to specifically identify the compatibles
> that utilizing gen2 HW without gals.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
