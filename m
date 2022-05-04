Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8ABC433FE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 May 2022 15:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352158AbiEDPTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 May 2022 11:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352112AbiEDPTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:19:42 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8837243AE4
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 08:15:58 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u3so2484703wrg.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 08:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1ryHoF3GX29l2BbumSx4LLa3+CSQ3y1WeeuUCuu7Qa0=;
        b=Hcb/GxMIWz+LONYPEzve61zizt92isYqwX/yrmvvmtjTOdN26bELSBXrfCatavY/i9
         zO0Oqvr3zwHUj40hzHgmV8SEvusTerF2fNSIN7KHYATj3tSBtZU9Rif2P38pyjfg33cd
         guYC+H53g+0lZzxOYl2ZNspXpcMIslsrmSObD8wYTFb1O/eopStRxiyOYSwA/8OgzD+k
         V7sIdiAaHrWrvBt2P+ESUMSARxGs2dG9a4B21L0sBP4/Luc29Q7Sxew/ri0Na2lHqyal
         v6xDIUSvDBbq8ATjzHHHiiwFmojz0DUAr7kKlOmFsDxI3cr5ZK9CETnQMIPp5lWlFDTb
         Aa/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1ryHoF3GX29l2BbumSx4LLa3+CSQ3y1WeeuUCuu7Qa0=;
        b=qF5Gx7KB2S4lAf4M10NfwR9NxiXexi+pCf0UejizSKspHaIfSsMh9GZ9Q5Lxe2Gfgg
         OTBYTNjfECkDUocnV6785kUj6+SJhN713Hx7Ur+fpJlBGCVcAn82QK6lHp6Nz0vmnUon
         8/fdL74hyg1/HxrEv7nHIkhKVlCCNy7+kWSCGbx/6RjLMzC6RtdVdrbe0sP+yGHo3+/j
         pCy8rg2dxLRB30Y8SjAKWgCYSo+Wl7uewhlwXqw5LR9SuMz+GHOcTFOMg7twyXSjImX9
         c747wbnccUqg/vPwI/65ikwgWHPIiXvLRvKi0cxKpR2GDdCR5O/jxbAjqVgIluI9kAZW
         NiKQ==
X-Gm-Message-State: AOAM530heqJwJb+8x++MqDlRNe17ViOUtxTB1qAeItH4SWNF+YQ76R4Q
        WMJ9HHQDn8n9OPP6E61RHc5QQQ==
X-Google-Smtp-Source: ABdhPJybnL0RWDbmurfP0kvKpvO+WERTEmjRBhnccgIeENQnFqTbkIhbjnxVsk2LUs7nrd7EyXVXoQ==
X-Received: by 2002:a05:6000:1814:b0:20a:cb21:8781 with SMTP id m20-20020a056000181400b0020acb218781mr16683539wrh.488.1651677357085;
        Wed, 04 May 2022 08:15:57 -0700 (PDT)
Received: from [192.168.0.215] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id j30-20020adfb31e000000b0020c5253d8bfsm11578357wrd.11.2022.05.04.08.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 08:15:56 -0700 (PDT)
Message-ID: <8aef897f-fff0-526e-62d0-6a92c301eb08@linaro.org>
Date:   Wed, 4 May 2022 17:15:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: sx9324: Add CS idle/sleep mode
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
References: <20220503193937.3794477-1-swboyd@chromium.org>
 <20220503193937.3794477-2-swboyd@chromium.org>
 <faaa4ab4-8190-3cff-998e-3b6a6d3ce27c@linaro.org>
 <YnKVzvAITXAHqSiX@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YnKVzvAITXAHqSiX@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2022 17:03, Rob Herring wrote:
>>>  
>>> +  semtech,cs-idle-sleep:
>>> +    description:
>>> +      State of CS pins during sleep mode and idle time.
>>> +    enum:
>>> +      - hi-z
>>> +      - gnd
>>> +      - vdd
>>
>> You need a ref to type (string).
> 
> Actually, it can be implicit for single strings.

Is this a generic preference?


Best regards,
Krzysztof
