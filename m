Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29569C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 11:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238543AbiBNL1t (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 06:27:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351298AbiBNL1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:27:16 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D42B2A4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:03:28 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id u1so12421133wrg.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=voOHTKZ6Kq7fuf3k40Bt/Cg/FVDuPGywOM97VgEuJp0=;
        b=xQB++bCcyZbYqGDxBMh+9AA7pbNWpiqOKO9eayXEWdhL54V9ZKRkHXGVx2ePd0kik2
         xWb4Wi5W6Kx4oDF/BjbZs0XPY+sSzfA4n7lGd3AoUhlWMrx7+h1ZjHC0wH7BTbD3vnG4
         G2PedixbbYUCGYRxVhkZ9VErAhM7CV/dy+WQhVO6qLx6+jXGvRPhqcuTg6FxqXRFPO0P
         SNaX2DwSF5G5ctwDcj973qnp1mK46X033LzKDyvwuGSQO7O1esGmOLK02lbuXaVXYtja
         fNH4HCfy1cs2OUDSPDHarllyk3/WwyM3kM/ROslSdb2Lh5nj2X8V1d3UzaNo7I4rBY+a
         3Bqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=voOHTKZ6Kq7fuf3k40Bt/Cg/FVDuPGywOM97VgEuJp0=;
        b=wdoAdEF8iiA5vaHj0LvFYhWAs+OVIV7gsVSu4fLPKDv9aSEztyLMg+il59qcEQS2wo
         FNORF+UWxYv8vm8wDQcBIwPWYTVZlCBlkDAwZAQiBIlMl3wyoeFbvimnuOgDxhcbefGv
         r4+w57NPwztWnpM/94Q9IFMXALSxGEGIifHOl7nZi78t96bLRUvVt0MpZeqaV57vxx9L
         wbGIii52TnrugPNF7puKOnryXkOqQztqKKzkB7rm8y4xyEmIVCaFSkbPGrcg9pIick9R
         WWlq7a11Mq/pShjLQvMRDlPeSuZ4ajiKAIxmc6EgV7jyIx+qO04yDGQ3MHT3IS3gsSGk
         K1/w==
X-Gm-Message-State: AOAM5335Y7j2b8LvNi64u7VQ70YXkwZbNh+vD/vRg3s1d8Y2lo4KzoBG
        yrimEHrTrO5vMgqFj3xGBV0RqA==
X-Google-Smtp-Source: ABdhPJyQGzvtUz4bb1kLHT2DVtQZlLvPUFqTZLzT4FocxEGsX88hVqvn2hnq4Ye2Kn+jy3pQYRsf6Q==
X-Received: by 2002:adf:8010:: with SMTP id 16mr10234280wrk.708.1644836606869;
        Mon, 14 Feb 2022 03:03:26 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id u11sm26861096wrt.108.2022.02.14.03.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 03:03:26 -0800 (PST)
Message-ID: <c23da7e0-6881-1911-ecf1-ff515e71424e@linaro.org>
Date:   Mon, 14 Feb 2022 11:03:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] nvmem: meson-mx-efuse: replace unnecessary
 devm_kstrdup()
Content-Language: en-US
To:     xkernel.wang@foxmail.com, martin.blumenstingl@googlemail.com,
        narmstrong@baylibre.com, khilman@baylibre.com
Cc:     jbrunet@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <tencent_0589E3FF08A4905922F78BC38602361C5505@qq.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <tencent_0589E3FF08A4905922F78BC38602361C5505@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/01/2022 02:56, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> Replace unnecessary devm_kstrdup() so to avoid redundant memory allocation.
> 
> Suggested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>

Applied thanks,

--srini
> ---
> Changelogs:
> Simplify the patch to replace unnecessary devm_kstrdup().
>   drivers/nvmem/meson-mx-efuse.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/nvmem/meson-mx-efuse.c b/drivers/nvmem/meson-mx-efuse.c
> index 07c9f38..13eb143 100644
> --- a/drivers/nvmem/meson-mx-efuse.c
> +++ b/drivers/nvmem/meson-mx-efuse.c
> @@ -209,8 +209,7 @@ static int meson_mx_efuse_probe(struct platform_device *pdev)
>   	if (IS_ERR(efuse->base))
>   		return PTR_ERR(efuse->base);
>   
> -	efuse->config.name = devm_kstrdup(&pdev->dev, drvdata->name,
> -					  GFP_KERNEL);
> +	efuse->config.name = drvdata->name;
>   	efuse->config.owner = THIS_MODULE;
>   	efuse->config.dev = &pdev->dev;
>   	efuse->config.priv = efuse;
