Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44926C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 12:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358373AbiCYMH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 08:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353633AbiCYMHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:07:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E68ABD89C;
        Fri, 25 Mar 2022 05:05:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18535B827E2;
        Fri, 25 Mar 2022 12:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902E7C340E9;
        Fri, 25 Mar 2022 12:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648209949;
        bh=8biOsG1UjYHozi8trXJdFkrk1DRVUtsbnVzo/j5Fz10=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KYIuJRJzKiofL6B2kt+ucSk6KAxvgbwPsyrAQGM/NEZFbjXmtVRIp0/qf/bvdo1qU
         B8BNDUWZrVVCFIQ0/PYORpx2UiLpHGnnu2mX+snvw+gP5Vuyg17ubiP79Mx5ejXpmp
         Ha3TZrbp7gqoXO1K1fxMqJGhmdjfEWYFfeDsQ17kFZAejdITSVhDezagbiM0fYz1lG
         jQLNar8ZrW2j70mu7nZFjN6ZM6wilmS5ujwQbMx6BlesyXc07vRNlZn1tDc8kdS339
         mx2AfOJrzrtjmKOxXZJjGzG/TMi3FXoH7aCKQRPnPaFEwMoXbCbDA/d9fGRG+UkFUd
         sfD+p35QEKSuA==
Message-ID: <abcbe390-45a8-6183-56a8-f9f751e84f49@kernel.org>
Date:   Fri, 25 Mar 2022 14:05:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/3] dt-bindings: mtd: ti,elm: Add support for AM64 ELM
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>, miquel.raynal@bootlin.com,
        robh+dt@kernel.org
Cc:     richard@nod.at, vigneshr@ti.com, kishon@ti.com, nm@ti.com,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220323111851.4699-1-rogerq@kernel.org>
 <20220323111851.4699-3-rogerq@kernel.org>
 <a222efb1-4f95-d65d-919b-ed55c5448c9a@kernel.org>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <a222efb1-4f95-d65d-919b-ed55c5448c9a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/03/2022 20:26, Krzysztof Kozlowski wrote:
> On 23/03/2022 12:18, Roger Quadros wrote:
>> TI's AM64 SoC has the Error Locator Module. Add compatible and
>> related properties to support ELM on AM64 SoC.
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  .../devicetree/bindings/mtd/ti,elm.yaml       | 27 ++++++++++++++++++-
>>  1 file changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/ti,elm.yaml b/Documentation/devicetree/bindings/mtd/ti,elm.yaml
>> index 24ed0fb84204..bc01d35ce605 100644
>> --- a/Documentation/devicetree/bindings/mtd/ti,elm.yaml
>> +++ b/Documentation/devicetree/bindings/mtd/ti,elm.yaml
>> @@ -17,7 +17,9 @@ description:
>>  properties:
>>    compatible:
>>      items:
>> -      - const: ti,am3352-elm
>> +      - enum:
>> +          - ti,am3352-elm
>> +          - ti,am64-elm
>>  
>>    reg:
>>      maxItems: 1
>> @@ -25,6 +27,17 @@ properties:
>>    interrupts:
>>      maxItems: 1
>>  
>> +  clocks:
>> +    maxItems: 1
>> +    description: Functional clock.
>> +
>> +  clock-names:
>> +    items:
>> +      - const: fck
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +
>>    ti,hwmods:
>>      description:
>>        Name of the HWMOD associated with ELM. This is for legacy
>> @@ -37,6 +50,18 @@ required:
>>    - reg
>>    - interrupts
>>  
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: ti,am64-elm
>> +    then:
>> +      required:
>> +        - clocks
>> +        - clock-names
>> +        - power-domains
> 
> Are these new properties also valid for am3352?

No they are not required for am3352-elm. Only required for K3 based platforms like AM64.

> 
>> +
>>  additionalProperties: false
>>  
>>  examples:
> 
> 
> Best regards,
> Krzysztof

cheers,
-roger
