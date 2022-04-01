Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6945FC433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Apr 2022 14:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbiDAOfw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Apr 2022 10:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347399AbiDAOcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 10:32:31 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D5E1EC613
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 07:28:55 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b24so3150281edu.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 07:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1adJU3bhpcLZT1nUnce0EbLAPPbeXtcoClCStkyt9oM=;
        b=VZ39SYrJ6PEuCxfqeqF/rIXuHwNzeIMR4RSC49UzVjrWCxHsx0BHlKRiOJeA1aqUBh
         na4Lqb60PW31/7aJkHlKz9+Z08pkCtFhMyaXwX8Iy9jpon6g4s2pKRT0RCBleow+tdtW
         QEiPis/ejow0d2ueveCIyUc4iwSnr38jDYFT1GE4dFhiPG2Udvvm/zmLMNbKxlfnEv9T
         xXEkatWlkg9mzdM+9/XY5ee1SCfy1wGgdgcSrCJTna7dFOWET+ne5lUiyS7OR2YiKL05
         F4AECbU5SrJABBKxCxYd09Lp7o/CQMl/NRSvMaytCitplDniftvzBoHs8IuJsmG2EI/r
         5AOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1adJU3bhpcLZT1nUnce0EbLAPPbeXtcoClCStkyt9oM=;
        b=M+VwyLUt0sf2wqiFUEOQ0gy73SrUU/S3jkSXbCrspmZcTzQWDpPbRHbgEDmNqEdAAq
         6br7AnkeAgSAdYqg2vWdHbMfLKLjjmWJ0PFya+YAYGvJTo1/7aC3TcRAoR9+H/IUu/kO
         1WR2DF6iQ67FA0htlF3FCcn0ai3iGwWHjailZJJRck/9DZcnJmhR2bTvjlm+/LXqzSGJ
         KcU00z3rk8HYF1+6VXKlT02YFDPCxarqwT3/ddrLCwV8nZjkQTTszKOaFJu+Gh83k+ZL
         CiPhnKkiNmtwL49EluxwYKAPdA5oVyKNuNkVqGUywH/SHYEHoH5BbqHO3e9jGr1mDyEK
         uiHQ==
X-Gm-Message-State: AOAM5325sQPtsNeDcKPXWy1fOAtPj/a1yy6hgsfYpwB/6L0H0QJTqfQL
        7Tnt2FjL8Lu2J9H0gwVurpUbGw==
X-Google-Smtp-Source: ABdhPJwzpAYQRuMQgEMzKTOmbEnykgFo3n9w7xJ0j1Au8dBsZfXNwd8pz6gGo426T8lHlCYDUd4yPw==
X-Received: by 2002:a05:6402:2681:b0:419:4564:1bd4 with SMTP id w1-20020a056402268100b0041945641bd4mr21552795edd.358.1648823333577;
        Fri, 01 Apr 2022 07:28:53 -0700 (PDT)
Received: from [192.168.0.170] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id f17-20020a056402355100b0041925e80963sm1285501edd.41.2022.04.01.07.28.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 07:28:53 -0700 (PDT)
Message-ID: <67df9824-898c-192f-7baf-a1f05936f0ab@linaro.org>
Date:   Fri, 1 Apr 2022 16:28:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] spi: dt-bindings: qcom,spi-geni-qcom: convert to
 dtschema
Content-Language: en-US
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
References: <20220331160248.716234-1-krzysztof.kozlowski@linaro.org>
 <20220331175817.GA91341@9a2d8922b8f1>
 <ddc12aab-3cff-16a1-9ec9-a246240f9521@linaro.org>
 <20220401135224.GA40286@9a2d8922b8f1>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220401135224.GA40286@9a2d8922b8f1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2022 15:52, Kuldeep Singh wrote:
> On Thu, Mar 31, 2022 at 09:40:08PM +0200, Krzysztof Kozlowski wrote:
>> On 31/03/2022 19:58, Kuldeep Singh wrote:
>>> On Thu, Mar 31, 2022 at 06:02:47PM +0200, Krzysztof Kozlowski wrote:
>>>> Convert the GENI based Qualcomm Universal Peripheral (QUP) Serial
>>>> Peripheral Interface (SPI) bindings to DT Schema.
>>>>
>>>> The original bindings in TXT were not complete, so add during conversion
>>>> properties already used in DTS and/or in the driver: reg-names, dmas,
>>>> interconnects, operating points and power-domains.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> [...]
> 
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  reg-names:
>>>> +    const: se
>>>
>>> Why reg-names is required?
>>> Reg contain max 1 value, we can skip reg-names like other users.
>>>
>>> Also, "se" is used as clock name and using it again for reg-names?
>>> I think this is wrong and reg-names shouldn't be documented.
>>
>> reg-names are not required. If you ask why they are documented? As I
>> wrote in commit msg - bindings were not fully updated to DTSes being used.
> 
> Hi Krzysztof,
> 
> Power-domains, operating-points etc. makes sense, but reg-names?
> 
> With quick search, sm8150.dtsi is the only user of reg-names. Moreover,
> there is no reference in driver to incorporate it.
> Driver(drivers/spi/spi-geni-qcom.c) looks for "se" as clock name and not
> as reg-name. If there's one, kindly help in pointing out.
> 
> It seems you are adding reg-names because some DT is using it and no
> other reason. And with no reference even in driver, that's surely not a
> way to go ahead as you have been advising the same in past.

I don't mind dropping it.

Best regards,
Krzysztof
