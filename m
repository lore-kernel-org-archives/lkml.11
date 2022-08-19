Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF88C32773
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Aug 2022 13:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349400AbiHSNoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Aug 2022 09:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiHSNok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 09:44:40 -0400
Received: from mail-sz.amlogic.com (mail-sz.amlogic.com [211.162.65.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE42CD7B2;
        Fri, 19 Aug 2022 06:44:39 -0700 (PDT)
Received: from [10.18.93.143] (10.18.93.143) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.2507.6; Fri, 19 Aug 2022
 21:44:33 +0800
Message-ID: <81452c8a-623c-3668-2411-fd7c39dc4280@amlogic.com>
Date:   Fri, 19 Aug 2022 21:44:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v5 3/4] dt-binding: perf: Add Amlogic DDR PMU
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <devicetree@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chris Healy <cphealy@gmail.com>
References: <20220817113423.2088581-1-jiucheng.xu@amlogic.com>
 <20220817113423.2088581-3-jiucheng.xu@amlogic.com>
 <0a10f55c-1e91-de8d-74c1-e2778841b7fc@linaro.org>
From:   Jiucheng Xu <jiucheng.xu@amlogic.com>
In-Reply-To: <0a10f55c-1e91-de8d-74c1-e2778841b7fc@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.93.143]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/8/18 16:25, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
>
> On 17/08/2022 14:34, Jiucheng Xu wrote:
>> Add binding documentation for the Amlogic G12 series DDR
>> performance monitor unit.
>>
>> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
> (...)
>
>> +
>> +  interrupts:
>> +    items:
>> +      - description: The IRQ of the inside timer timeout.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    pmu {
>> +        #address-cells=<2>;
>> +        #size-cells=<2>;
>> +
>> +        pmu@ff638000 {
>> +
> No need for blank line.
>
>> +            compatible = "amlogic,g12a-ddr-pmu";
>> +            reg = <0x0 0xff638000 0x0 0x100>,
>> +                  <0x0 0xff638c00 0x0 0x100>;
>> +            interrupts = <GIC_SPI 52 IRQ_TYPE_EDGE_RISING>;
>> +        };
>> +    };
> With above fixed:
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks for your valuable comments and I learn a lot from them.

One more question, do you mean after modify the above two places

I could resubmit V6 as the final patch which include your reviewed tag?

>
>
> Best regards,
> Krzysztof
>
-- 
Thanks,
Jiucheng

