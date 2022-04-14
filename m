Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C7EC4332F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 01:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239329AbiDNBGI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Apr 2022 21:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiDNBGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 21:06:04 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F80D517F5;
        Wed, 13 Apr 2022 18:03:41 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-de3ca1efbaso3793464fac.9;
        Wed, 13 Apr 2022 18:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bBrh+8KxzroQ2BGwsqtBXZ1ANf1L/scE9GQKJrTog04=;
        b=l7ii/d87lEAHFSR63z87hDvvR277J1DsaMVhCl7FZlFwcemWWvNEHLGaZMDUOqZjzD
         xnArQ6KdTcLdkd8wZYJ/Eu5p7ervYhkBekV7TJyvKtaFZr143n3K9MEwj5PLrKrTvBHi
         eUHn9RpBVmSTJkYmgii9cJEss6bRyaemPnRqBklIpmw1Isa/5T8Hl+yrk5gn5ciCrOpW
         FlMA9D/PJm5NRBoq5Kd1iRkhpA+xslWJUoFFAz27AqJ8y5CyGgSc5jM1W4MKiFlCg2UP
         ReW0FfnUFtyTsgi7BEQg7bIOnbmP4dlZkyREPzvpeE+QCHXsXd+EIALqlQwGdnZ7CoOB
         Yg2Q==
X-Gm-Message-State: AOAM533PPRD0ssaDnu17GYXFi66mBiuXEhdIsqpCGVHgayE+3mfPjmDg
        nhY4jPG1sZ4oE4hbAc+44+YqBVZYdA==
X-Google-Smtp-Source: ABdhPJz3hxThl/Zz97TGBTfkE8Jrnvpedc2e5PEATfNFmSrzVRTWtk/YDlPJVeYP3pdeA64vU3vJtQ==
X-Received: by 2002:a05:6870:3112:b0:ce:c0c9:62b with SMTP id v18-20020a056870311200b000cec0c9062bmr600437oaa.125.1649898220576;
        Wed, 13 Apr 2022 18:03:40 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o2-20020a05687072c200b000d9ae3e1fabsm231690oak.12.2022.04.13.18.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 18:03:40 -0700 (PDT)
Received: (nullmailer pid 93389 invoked by uid 1000);
        Thu, 14 Apr 2022 01:03:39 -0000
Date:   Wed, 13 Apr 2022 20:03:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] regulator: dt-bindings: qcom,rpmh: update maintainers
Message-ID: <Yldy6+lHoYgJT9qq@robh.at.kernel.org>
References: <20220411110253.231745-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411110253.231745-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Apr 2022 13:02:53 +0200, Krzysztof Kozlowski wrote:
> David Collins' email bounces ("Recipient address rejected: undeliverable
> address: No such user here").
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/regulator/qcom,rpmh-regulator.yaml     | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
