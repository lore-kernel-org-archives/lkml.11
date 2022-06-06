Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D8CCCA481
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jun 2022 15:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241024AbiFFPlO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jun 2022 11:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240989AbiFFPlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:41:12 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E198562C5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 08:41:10 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id h23so18648991ejj.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 08:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5bsP623yeVUhI4X2qyWKm7xhZAZBEQqTrR3MfihqiO0=;
        b=pGV3u32GEBOhd7TPDnOWLKJ9oLJuUOxDipMCgJt3EuoZ1rarvWVYq8oK+EU5doKOjK
         SjmxM35Rzb1UHksLLMUZC4DYfUe6w8HvXhq0YtIZ23J8rixxB6XuOgLghu9cBT3X7v+5
         8CKA9/yAOJtmExGP8T4abFpaA3PaM3BnjfL2ukfBwdBbz7233FZ2pQAgim1oO1u4diFw
         Dnf3lFRkKT93piQWB7AwqEXehvglKXOTwbtf2OtFQ4WNsFBDbscEbx8lE2uQE2D7ANLE
         Aeq7piv2zqJSmwRp4PA+HAoVDcvxcdfbrtP0VaTbP7qHmqDopLuXdRpnHi+IPAgVaH8Y
         Tqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5bsP623yeVUhI4X2qyWKm7xhZAZBEQqTrR3MfihqiO0=;
        b=L81RxI3HdZKDMNwa5NFw6z4M/+93HE6shtacn7ZP35OcXQbCca1ZDZTuFF8mUB6mqz
         Aeal4LR3cJrtfhmQ2rrgM8zhdiXubzF5x4HBy1Rc3HpzmvBiEFDLVt6kfDy1heo9zifv
         eQNhp3W5ZmlfVyvwIvvDdbgRCDVXF6H7UhxgWKjg+m7Txdbs1oxKRDgGDO4S35caC+co
         CifY2yngzaD0METxT8mdvbGcYA4RNnPLe4FWfWOte+3i210rgdBwyKZ/mAy1NyOdSwLV
         5P716C26aRQBfhX5TppN+XjT5LtyWOoBsfqBzEpAx7L7tPNzunez67iIgnTEYfTmscE0
         g41A==
X-Gm-Message-State: AOAM530xS+YedEjztxDxsxyCQm4COq0yhK5UQbAeACdfLvo/9Lx3A6Mn
        em7qr8DFVGsmdVUYagYi5MqbZA==
X-Google-Smtp-Source: ABdhPJxPmR5o/ptnO48/LLqqFHYgHv9f2kSvvBI4oOyV4SSHNtCri883LtJ4arOlCN8+RLxPMr+1YQ==
X-Received: by 2002:a17:906:5959:b0:710:c2e8:79f3 with SMTP id g25-20020a170906595900b00710c2e879f3mr11652199ejr.489.1654530069008;
        Mon, 06 Jun 2022 08:41:09 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n16-20020aa7c790000000b0042bced44061sm8728646eds.10.2022.06.06.08.41.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 08:41:08 -0700 (PDT)
Message-ID: <5fe2246f-97db-e7b0-a72e-c8c5ff6b2abe@linaro.org>
Date:   Mon, 6 Jun 2022 17:41:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 06/23] dt-bindings: mmc: exynos-dw-mshc: update
 samsung,pinctrl.yaml reference
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
References: <cover.1654529011.git.mchehab@kernel.org>
 <5c937793dd7aec30da4964b39561072ae184f89b.1654529011.git.mchehab@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5c937793dd7aec30da4964b39561072ae184f89b.1654529011.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2022 17:25, Mauro Carvalho Chehab wrote:
> Changeset af030d83da1d ("dt-bindings: pinctrl: samsung: convert to dtschema")
> renamed: bindings/pinctrl/samsung-pinctrl.txt
> to: bindings/pinctrl/samsung-pinctrl.yaml, splitting it into multiple
> files.
> 
> Update exynos-dw-mshc.txt accordingly.
> 
> Fixes: af030d83da1d ("dt-bindings: pinctrl: samsung: convert to dtschema")
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Commit is okay, but you can also drop it entirely because entire part
will be removed with:
https://lore.kernel.org/all/20220605163710.144210-4-krzysztof.kozlowski@linaro.org/



Best regards,
Krzysztof
