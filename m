Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B3FC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Apr 2022 19:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238395AbiDMTdp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Apr 2022 15:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236864AbiDMTdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:33:39 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AB876295
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:31:17 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id v4so3660011edl.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=frTEyC0/+CfTIF4PYPNiHQ4Gsfm5fIkYJSxFNrCEuso=;
        b=USSnSZtoD5qwvH/yvxHC79p7rIcFBfYSAwCS/8l+UAOQVYZUKJ+vDuBaAJB/nJmEPx
         g7xJs94b53G9SqzrTEyV7LiPRqY0+FlEUHXsFaG0byJs5XO9935tw+7S/EMAJuTtQhFu
         VjfWoAx3Fgh06C/08DWnLONaqlnuWzNwZGJHbJI9za5M55H9pRP/jioGj6z6SD5mSuf5
         OhqjpbUnqQeW/s2ZVSve+5lCImK8h2qDomy0YIMCtTsk3zqfpMMDy2LoFmTLoUjvNvp4
         WpBvZbIOz7I46fmHuumVjEpqpu1SEQkwedZ3gusL5+0cPXdh1QTDfn/NzBsWi6w2TCm3
         pPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=frTEyC0/+CfTIF4PYPNiHQ4Gsfm5fIkYJSxFNrCEuso=;
        b=ZxKL2J+GvfiVktlxMZOGCLL26Y5IyTJQD0GjyLtaQz8Fr+I1gKtdpGywe4tV5Be8F1
         srmWgsSAcX8p5nZQfmxYVG4U4hMMHUO/8J6UMks0nCWszOO/vgxiDCN7E/tv0HzYs9hr
         3LoJ9+67KaBOCpdXk/joKgQKwF1wRUWPhIAXzsMxy+1YFeIfcnv0RY6xdLTUSHiOa+5Q
         gKKIu6RM/yNI7s4PVz/EkoG2OfhnF//Govf7Z0JlDCZdMGducI5XZENzVkIfuv4fnIBY
         Sz3V2jbbrmwmXRJDI3QVHeMn0ZOkIA8Tsiz1BXccbenLpcHUgbaGChJIjZD9uOxcbOeu
         goJw==
X-Gm-Message-State: AOAM531e8F0qn12b47c89AjqlmBsI3xxYzliyi5h4nD7WPIn1ewh+W/Q
        oWoCxEB8DXZD7Nac1Rl1KE5NfQ==
X-Google-Smtp-Source: ABdhPJxCWuXB+xuTb6sKG9nbhRjhHzVASERrwIqlT8IubgeDh/aIhOShiVtJmLn6LiaKB+HEOkgWow==
X-Received: by 2002:a05:6402:5250:b0:41d:8556:4191 with SMTP id t16-20020a056402525000b0041d85564191mr14027035edd.269.1649878275612;
        Wed, 13 Apr 2022 12:31:15 -0700 (PDT)
Received: from [192.168.0.207] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id e26-20020a50ec9a000000b004193fe50151sm1584782edr.9.2022.04.13.12.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 12:31:15 -0700 (PDT)
Message-ID: <44efe8b6-1712-5b87-f030-2f1328533ee8@linaro.org>
Date:   Wed, 13 Apr 2022 21:31:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 24/33] dt-bindings: crypto: convert rockchip-crypto to
 YAML
Content-Language: en-US
To:     Corentin Labbe <clabbe@baylibre.com>, heiko@sntech.de,
        herbert@gondor.apana.org.au, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220413190713.1427956-1-clabbe@baylibre.com>
 <20220413190713.1427956-25-clabbe@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220413190713.1427956-25-clabbe@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2022 21:07, Corentin Labbe wrote:
> Convert rockchip-crypto to YAML.

Thank you for your patch. There is something to discuss/improve.

> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,rk3288-crypto
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 4
> +
> +  clock-names:
> +    maxItems: 4

This is not needed and dt_bindings_check should complain.

> +    items:
> +      const: aclk
> +      const: hclk
> +      const: sclk
> +      const: apb_pclk
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    maxItems: 1

The same.


Best regards,
Krzysztof
