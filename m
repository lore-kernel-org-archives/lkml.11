Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07416C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Mar 2022 08:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235640AbiC0IB5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Mar 2022 04:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbiC0IBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 04:01:51 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919F11114D;
        Sun, 27 Mar 2022 01:00:13 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id u3so16179951wrg.3;
        Sun, 27 Mar 2022 01:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8q2PEyctEYcJQQuX1kcjiYZtUrzQ1TsH7qQAnCPe3ho=;
        b=EXCCdFrwhn0pvwe1hfvAg1MwaewgMCxtmvnEU20IZ05XP8UOgCY9lRdau7zwoyb+1q
         0+F/c+I18j02P+9C1DCRVFCRqX5sTXOtHeH8IcLdFHc1A4EbysQKPut/p2HPCt4/yZEc
         YgGaWAhdRhfafEizjo+dgFCYNS5nUoea+hSjTPMuZaRDa+VjxPDXc1NZFtDRjj1bTFtZ
         FYkDmnjKoRC5WIuB4NtckpVF6Su6evUaLSGsqBqHlCbMElRqGVPKIPwx9erLSl8DE9dX
         jDlv7fcw9PA2xQFh4uf+Ma4D+D0E1mQ0OaQFwCBFfd7Yd55reBfT1HG+RR4mi5lQolma
         xfiA==
X-Gm-Message-State: AOAM530xoHezaXLLqjCgD2opiOqMRbXV1wDJjkLLrmN6kKyIdtHZCJzh
        OuSyaz2FRhHmzB677myOOUiogwKzBaU=
X-Google-Smtp-Source: ABdhPJzTB1G5vWt2XzAl1FM9J93U3f4r1YgUAAVvI8L/4ZAAqbVrbM1adGbma+x2m2UlsfAok7H+rg==
X-Received: by 2002:adf:d1e5:0:b0:205:85f5:656c with SMTP id g5-20020adfd1e5000000b0020585f5656cmr16397217wrd.65.1648368012012;
        Sun, 27 Mar 2022 01:00:12 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id j8-20020a05600c404800b0038cc9c7670bsm8857789wmm.3.2022.03.27.01.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 01:00:11 -0700 (PDT)
Message-ID: <237a1e6a-7e0f-21b6-f8f4-045142f86712@kernel.org>
Date:   Sun, 27 Mar 2022 10:00:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 1/3] dt-bindings: clock: fix some conversion issues for
 rockchip,rk3399-cru.yaml
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220326102712.20906-1-jbx6244@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220326102712.20906-1-jbx6244@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2022 11:27, Johan Jonker wrote:
> With the conversion of rockchip,rk3399-cru.txt some issues were added,
> so fix them:
> 
> Changed:
>   Align the table with external clocks.
>   Remove the original author in 2016 as maintainer.

This requires explanation.

>   Change clocks maxItems.

This requires explanation. There is no maxItems in clocks.

>   Add clock-names.
>   Use clock-controller node name in example.

Why?

>   Remove assigned-xxx.
>   Remove ">" from description.

All this should be around two or three commits, so you need to split
changes which are cleanups to changes affecting functionality (adding
new properties, changing values).

> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../bindings/clock/rockchip,rk3399-cru.yaml   | 32 +++++++------------
>  1 file changed, 11 insertions(+), 21 deletions(-)
> 


Best regards,
Krzysztof
