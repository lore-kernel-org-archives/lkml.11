Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E366C00140
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Aug 2022 07:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbiHBHmX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Aug 2022 03:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236029AbiHBHmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:42:20 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7341112D3C
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 00:42:15 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id m9so14722692ljp.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 00:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=o5WT951efioFvjHX5Y/JBauyEq0vD0syAAhtkc7s5HI=;
        b=Wv5NGHpcdzjPVEWqNx3GLzKeS1YyPXndg/9+gcFNVedR/9xWd++F5DTwnJZKxfyTOV
         r4PJbWP6b/1qye5RMSybJDB4ueE6qu1Tx8fZu8KALN0S+nZ2M5z4sC16VVrpu7tQt+r2
         b+PESIXzmYPfy7ciWmxlTqq7eQI95hZOVU7A5UPAAqmyboCCulGhfdXfl0viUOVDWgb9
         p3zsiAbs5DJniMYgAh1UV5EkBMGkuFcfMJW5g8FegWSHlJpTd48Hh8yyKp9oXSKjm/2U
         VdiYDtmuAX6mtA07zTA32ELDedwV5u5LkrWRh7I4r0kzLyCmrykgLEAUEYsWvY72460N
         0m3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=o5WT951efioFvjHX5Y/JBauyEq0vD0syAAhtkc7s5HI=;
        b=5YFtT5x4bR5+4IDvdgTRcf4iG9TYom4mHYsEBme4iFGBwD0gI1BA7zTH4CgtJhLNj+
         S/jFAzuXSV6qH6AvucX/KmCUaRvkZJE5tWh88Z5tTSNvYZuSncwfleeh1BLDnmiEJCEA
         zjIWTD+Pykat3nzp9Knq2nOFvupF7fcHF8RNKSmVGZgBO7wlhqgWGMle5zft1+jzxtjY
         J6ClKgMdeB/4CHjweHzERuPnr/wgp1VJK/xsQVyI8x42OjSC8wrMLKLGvd0vKZpS0Lps
         k2wNIr2FO6JqRDnF7brR4dG/U20JGBPZmH35ZUv6bgcYlYAgA3GCzuD5K9BMSS4cEkrP
         R9Sw==
X-Gm-Message-State: ACgBeo0RN6V/Mc7NTLS8UxdUqckPtVnVcY0NFNWRDnhBnRz49yj4XLVH
        L27mpYX3Fh90cD/WSPURIo3UYg==
X-Google-Smtp-Source: AA6agR5e+rTyQ6OsIS10zzg+Mg2mLYgHPo/J/2tvX3TKXEUzjzdrE4b3pBvcuRp1pz68MNYHQHcujQ==
X-Received: by 2002:a2e:8044:0:b0:25e:4df9:b831 with SMTP id p4-20020a2e8044000000b0025e4df9b831mr2956147ljg.7.1659426133854;
        Tue, 02 Aug 2022 00:42:13 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id bi27-20020a05651c231b00b0025e4bb17187sm772655ljb.132.2022.08.02.00.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 00:42:13 -0700 (PDT)
Message-ID: <d8e3870b-d180-faaa-873e-ed11ed73d8dd@linaro.org>
Date:   Tue, 2 Aug 2022 09:42:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: sdm845-xiaomi-beryllium: rename
 to sdm845-xiaomi-beryllium-tianma.dts
Content-Language: en-US
To:     Joel Selvaraj <joel.selvaraj@outlook.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20220801112512.209047-1-joel.selvaraj@outlook.com>
 <BY5PR02MB700963FB9273AA8FEDDC5899EA9A9@BY5PR02MB7009.namprd02.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <BY5PR02MB700963FB9273AA8FEDDC5899EA9A9@BY5PR02MB7009.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2022 13:25, Joel Selvaraj wrote:
> There are two panel variants of Xiaomi Poco F1. Tianma and EBBG panel.
> The existing sdm845-xiaomi-beryllium.dts supports the Tianma panel variant.
> Thus, rename it to sdm845-xiaomi-beryllium-tianma.dts to be more specific.
> 
> Signed-off-by: Joel Selvaraj <joel.selvaraj@outlook.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
