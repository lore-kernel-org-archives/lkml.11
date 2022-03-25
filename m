Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BDCC433FE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 12:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344616AbiCYMJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 08:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346793AbiCYMJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:09:41 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DAE6563;
        Fri, 25 Mar 2022 05:08:07 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id y10so8979136edv.7;
        Fri, 25 Mar 2022 05:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=b6iLhHro7kUOfY74FDg49eYd66M0VSueSP9JBgp7E0o=;
        b=6XfsnAsms0ONOdZDI/1UXW8dSUHbCFuxuCxXKOy1LZiZco3j//O2FAir5MUR0CckOf
         +u5LrwBHNQVrY7lHTzGNQELrXtgFwH2EREYxAlEOfkcueAZzLx3qSPzoc2irjSOKcl1T
         5BvSR8wXKrV92e/yZrWv8qP8UYi7ej8cHtLRD46io1kAPUe6EQM+WCUE7JT0kAf5Ukp1
         mEx3XKjqigY+KfM8fTC9Ku5v2hv2epNDwIN9wByFdvaV5zuluLwpLjcxArEQiI3s6SjK
         gMxzHw7101n189HDJwnVbKXavJx/17ZJFj+WdXdslZYG8xtxe5ytqaKpPhaFA06DV/1/
         B7eg==
X-Gm-Message-State: AOAM530LK9eQ5uJJYtSUqZiLPlmUJu9aOpNopK5oP6xAZKOw1F4ULS7o
        lrN2+5SSnKGIQxOQMikvROo=
X-Google-Smtp-Source: ABdhPJwKOAzzNPCen4oyPlN4ID736q0SuL/B1Zy1q8K8/75AKeWUd3gS6TR2tal50ctRSPp/hCPxEg==
X-Received: by 2002:a05:6402:2707:b0:419:5b7d:fd21 with SMTP id y7-20020a056402270700b004195b7dfd21mr12872378edd.51.1648210085836;
        Fri, 25 Mar 2022 05:08:05 -0700 (PDT)
Received: from [192.168.0.159] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id r22-20020a17090638d600b006d584aaa9c9sm2239691ejd.133.2022.03.25.05.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 05:08:05 -0700 (PDT)
Message-ID: <597e4bfb-383d-0f3b-dce8-ffc12f543b46@kernel.org>
Date:   Fri, 25 Mar 2022 13:08:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/3] dt-bindings: mtd: ti,elm: Add support for AM64 ELM
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>, miquel.raynal@bootlin.com,
        robh+dt@kernel.org
Cc:     richard@nod.at, vigneshr@ti.com, kishon@ti.com, nm@ti.com,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220323111851.4699-1-rogerq@kernel.org>
 <20220323111851.4699-3-rogerq@kernel.org>
 <a222efb1-4f95-d65d-919b-ed55c5448c9a@kernel.org>
 <abcbe390-45a8-6183-56a8-f9f751e84f49@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <abcbe390-45a8-6183-56a8-f9f751e84f49@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2022 13:05, Roger Quadros wrote:
> 
> 
> On 24/03/2022 20:26, Krzysztof Kozlowski wrote:
>> On 23/03/2022 12:18, Roger Quadros wrote:
>>> TI's AM64 SoC has the Error Locator Module. Add compatible and
>>> related properties to support ELM on AM64 SoC.
>>>
>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>>> ---
>>>  .../devicetree/bindings/mtd/ti,elm.yaml       | 27 ++++++++++++++++++-
>>>  1 file changed, 26 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mtd/ti,elm.yaml b/Documentation/devicetree/bindings/mtd/ti,elm.yaml
>>> index 24ed0fb84204..bc01d35ce605 100644
>>> --- a/Documentation/devicetree/bindings/mtd/ti,elm.yaml
>>> +++ b/Documentation/devicetree/bindings/mtd/ti,elm.yaml
>>> @@ -17,7 +17,9 @@ description:
>>>  properties:
>>>    compatible:
>>>      items:
>>> -      - const: ti,am3352-elm
>>> +      - enum:
>>> +          - ti,am3352-elm
>>> +          - ti,am64-elm
>>>  
>>>    reg:
>>>      maxItems: 1
>>> @@ -25,6 +27,17 @@ properties:
>>>    interrupts:
>>>      maxItems: 1
>>>  
>>> +  clocks:
>>> +    maxItems: 1
>>> +    description: Functional clock.
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: fck
>>> +
>>> +  power-domains:
>>> +    maxItems: 1
>>> +
>>>    ti,hwmods:
>>>      description:
>>>        Name of the HWMOD associated with ELM. This is for legacy
>>> @@ -37,6 +50,18 @@ required:
>>>    - reg
>>>    - interrupts
>>>  
>>> +allOf:
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            const: ti,am64-elm
>>> +    then:
>>> +      required:
>>> +        - clocks
>>> +        - clock-names
>>> +        - power-domains
>>
>> Are these new properties also valid for am3352?
> 
> No they are not required for am3352-elm. Only required for K3 based platforms like AM64.
> 

I understand they are not required, but I asked if they are valid. IOW,
whether ELM in am3352 also is part of power domain and has clock input?

Best regards,
Krzysztof
