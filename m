Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBE5C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 17:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349323AbiC3Rdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 13:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiC3Rdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:33:32 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3799F4E397
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:31:45 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r23so25318644edb.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uWiJ5wTJBkRDVa3V3iSD71hMD+u7SGSGGNU1kaA3NHc=;
        b=XbBkG/7QzLtqfCbO6qoOQnqerS4luZZqZXqgQ3TMMUZFnF7nLZ4Tbl/J0UDSfCY8X7
         bh46UvW84TSsUdYMtNyV8sgAvQEOFKSwgTaUWl9v6KHNr4GUQ9UvB5baZbHsdPxnqFc0
         IUWTOrHLPYlb7wc8lDZko39nRKTiPdyDvaTyKT1oMjjLG8ohzoW0tC9zqzb+AR3O/wlz
         kZdYEMxKC29kqqKfNOAaczKjsBXg64EcVpb6yQbxTRUPbNluZmLPjJIV3usEC4gjcVpV
         wxdfjIAC6SrRZbnb63U8CwI32A6026p4utgOEZIfxUXZt/Jg9fZI7grMdFf3YqSIjBqF
         82zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uWiJ5wTJBkRDVa3V3iSD71hMD+u7SGSGGNU1kaA3NHc=;
        b=zkW3KD9UA4BSDz6QJ7XsmnFIQQTkNfz6TJUCuIgkKnMQXTRw0bnoae3/Xy6pTwEWyb
         gEgTLuUavyigEek4X9WuhcQrHWVNNCeCpIBJs0jPzAeMK6gIWhrn+NHF75O++nFni4+y
         buDNfBTeDYuHfMw2mgkrpfoYHrTb3Rq7UeVTZDu4Fajsv57rBfUW8SdRX82R2PbzNN8I
         pUfPdO/sZ7WQ0g7RWnatCrSGD8pDTxCUYHwwH4ZRzPa47IaDZcKQnGEIB9A3yXvSgDn/
         4EoA+yJBjDZlbNUkYxLxpFWmBfGYzYNYSuJCIgaISjoM3BObWCSgCwwZCEMuqNefVuPp
         vM7Q==
X-Gm-Message-State: AOAM530qOSWX9zFQB6d+iLBYuEeiOxmmHKPxYHZVNnfFxEizRv1TpjCz
        af7vviiKrFQyeupiDVRAtVUeJg==
X-Google-Smtp-Source: ABdhPJxfwO0A3/xw6jH/adNr0SESqdJ1bKu546BerqB4579YQ4KeyvjUiaoDmCqu5B77TuPrIJd/mw==
X-Received: by 2002:aa7:db94:0:b0:410:f0e8:c39e with SMTP id u20-20020aa7db94000000b00410f0e8c39emr11902523edt.14.1648661503756;
        Wed, 30 Mar 2022 10:31:43 -0700 (PDT)
Received: from [192.168.0.164] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id v10-20020a170906380a00b006a68610908asm8465966ejc.24.2022.03.30.10.31.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 10:31:42 -0700 (PDT)
Message-ID: <a7635001-3b3d-cc3c-c1bb-c081ee86288d@linaro.org>
Date:   Wed, 30 Mar 2022 19:31:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v1 1/3] dt-bindings: clock: convert
 rockchip,rv1108-cru.txt to YAML
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de,
        zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220330131608.30040-1-jbx6244@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220330131608.30040-1-jbx6244@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2022 15:16, Johan Jonker wrote:
> Convert rockchip,rv1108-cru.txt to YAML.
> 
> Changes against original bindings:
>   Add clocks and clock-names because the device has to have
>   at least one input clock.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../bindings/clock/rockchip,rv1108-cru.txt    | 59 ---------------
>  .../bindings/clock/rockchip,rv1108-cru.yaml   | 75 +++++++++++++++++++
>  2 files changed, 75 insertions(+), 59 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rv1108-cru.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rv1108-cru.yaml
> 
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
