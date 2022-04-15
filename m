Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1615C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Apr 2022 01:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243585AbiDOBT4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 21:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbiDOBTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 21:19:53 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 335C79027F;
        Thu, 14 Apr 2022 18:17:27 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 15 Apr 2022 10:17:26 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id A23162058443;
        Fri, 15 Apr 2022 10:17:26 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 15 Apr 2022 10:17:26 +0900
Received: from [10.212.183.90] (unknown [10.212.183.90])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id A9E54B62B7;
        Fri, 15 Apr 2022 10:17:25 +0900 (JST)
Subject: Re: [PATCH] dt-bindings: interrrupt-controller: uniphier-aidet: Use
 unevaluatedProperties
To:     Rob Herring <robh@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1649317664-21391-1-git-send-email-hayashi.kunihiko@socionext.com>
 <Ylcf0QOBAne6fKQr@robh.at.kernel.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <2005f406-0117-b0eb-cc4b-2a921cf6528c@socionext.com>
Date:   Fri, 15 Apr 2022 10:17:25 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <Ylcf0QOBAne6fKQr@robh.at.kernel.org>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2022/04/14 4:09, Rob Herring wrote:
> On Thu, Apr 07, 2022 at 04:47:44PM +0900, Kunihiko Hayashi wrote:
>> This refers common bindings, so this is preferred for
>> unevaluatedProperties instead of additionalProperties.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   .../bindings/interrupt-controller/socionext,uniphier-aidet.yaml | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git
> a/Documentation/devicetree/bindings/interrupt-controller/socionext,uniphie
> r-aidet.yaml
> b/Documentation/devicetree/bindings/interrupt-controller/socionext,uniphie
> r-aidet.yaml
>> index f89ebde76dab..77f2d58a9c3f 100644
>> ---
> a/Documentation/devicetree/bindings/interrupt-controller/socionext,uniphie
> r-aidet.yaml
>> +++
> b/Documentation/devicetree/bindings/interrupt-controller/socionext,uniphie
> r-aidet.yaml
>> @@ -49,7 +49,7 @@ required:
>>     - interrupt-controller
>>     - '#interrupt-cells'
>>   
>> -additionalProperties: false
>> +unevaluatedProperties: false
> 
> As mentioned elsewhere, not necessary here.

Yes, I withdraw this patch for the same reason.

Thank you,

---
Best Regards
Kunihiko Hayashi
