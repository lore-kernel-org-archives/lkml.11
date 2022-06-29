Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4CDCCA47C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jun 2022 10:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbiF2Kij (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jun 2022 06:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbiF2Kie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:38:34 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07F035DE3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 03:38:32 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z19so21528708edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 03:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=r45V0Osa4ktJ5A5yr5DwTpxzu54dyl24lYeE/uXw+Vo=;
        b=k5KHDhE/nzJ3O1bzXBo5NFfJbE+tf92vNlaGXFP2RI89oqOs55oPznUY3eHmPX3Rax
         w1H4nr7UBuXagI8gcJlgB1ilP5JEksGR8I3c970Q3xnSdcyNSGqWrlyO5u0gwcQmryrT
         LMr+rdV77jqMZ8l0lj6c2pIR1KrMaIM4OtHm+98Atd/92Rn5ORU1bFQuCAvvGIqp70on
         7IhkCJWSsj4uIPwuYx+LqIIPCZY7EhBufL1lhLWkxvs3vOCmOcRuCIcg8O8QwQSqBoa7
         RGDjlybGl2bC+3RHecXtDiz3RUvjMz+M2JS2SNdnZAfX5QPebXAH9hqyVOma/rrbSZtY
         auoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=r45V0Osa4ktJ5A5yr5DwTpxzu54dyl24lYeE/uXw+Vo=;
        b=EAiJFLSpZjJd1hfs2p/I46uAkR0+2xEposRAbCG/NP0/rGLG17850U4dmw60xBYt61
         RDqxA0K+EmMFDW80Vfq4JWqCvxrjawQhtLHgBtgJUdre4u9ykxt4xqYboQnnBzTBCm+V
         0Sf+L7IMftS4Z7/P02RrFJ9D4/o6WamB6wWdo2gkIzfER6dDWZJCY/j6tlLU9kBsrB6b
         rZP1VPrLFVfgsEDghimx823DG+l+xstyuF7nycsR4gY9Lt6BY6mxldBqpaGig86FR3YW
         PQ0CHhEcc88I+S7wrGhnoIbiL5/3f/yMNN3VUx/fz2Rtz4eM/LZ5PKEdhlLjmZ++y2Yd
         Iuuw==
X-Gm-Message-State: AJIora+9McK9Jhz7vKPBTc+Vxn3tC1vuVD+SN1m2xpAbCxqixeQZZw2r
        mk53RU8D8u6uw/UDkZ7PTiv65Q==
X-Google-Smtp-Source: AGRyM1tTSmJRvfcX1fT1lXKKPWC631meyWzsFbbOiFi5fPYcGa7h8Jox0+p1wLn6LPuEYe7hv78wTQ==
X-Received: by 2002:a05:6402:492:b0:437:4b50:d616 with SMTP id k18-20020a056402049200b004374b50d616mr3210794edv.43.1656499111359;
        Wed, 29 Jun 2022 03:38:31 -0700 (PDT)
Received: from [192.168.0.184] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id lo17-20020a170906fa1100b0072696b3a327sm4827592ejb.187.2022.06.29.03.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 03:38:30 -0700 (PDT)
Message-ID: <0a81edca-00bb-ba58-3ec2-a36099697f59@linaro.org>
Date:   Wed, 29 Jun 2022 12:38:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: realtek,otto-wdt: add RTL9310
Content-Language: en-US
To:     Sander Vanheule <sander@svanheule.net>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
References: <84d873d7dd375cd2392f89fa6bd9e0fe5dda4e1c.1656356377.git.sander@svanheule.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <84d873d7dd375cd2392f89fa6bd9e0fe5dda4e1c.1656356377.git.sander@svanheule.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2022 21:00, Sander Vanheule wrote:
> Add the realtek,rtl9310-wdt compatible to the Realtek Otto watchdog
> binding.
> 
> Signed-off-by: Sander Vanheule <sander@svanheule.net>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
