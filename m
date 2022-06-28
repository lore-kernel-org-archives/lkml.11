Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3820C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 20:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiF1UTe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jun 2022 16:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiF1UTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:19:19 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267AB2734;
        Tue, 28 Jun 2022 13:14:41 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id m13so14071705ioj.0;
        Tue, 28 Jun 2022 13:14:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jAL0QILA2tAkx38BgMHOGJB4MN9lHb5Y2jmfZHJxycI=;
        b=vNzCz97SR5FWfkTcvREIpcjaRLFgQIZPiRTtaF4TrornsuQw6mybRGqVmcps2F+GoE
         M74Pvpyg90jqaCK6FAuy9u3AuAzxgoeCR3rNa7JhL4Fw5ckGwJ6pBHzN49RwOmFWoX5B
         mtdsl0o2/NFMuYC2q1xZzYnUqcy6qlRDvbGfg8roacqluEtwR6lnOh3etx4kVTpUrIJc
         wygK59NdIRll5KnuIDF+tiV/Unqi8RW58jZMm4lr0ep6t3fQzO7SFL7EGYpTyhiPh7wy
         Wzb35VCoG0SLCp7vel07k0oq9LMpxjvmo7s1I2yQrxY5DizTToWUApllLnjGWjlOqVRK
         l8mA==
X-Gm-Message-State: AJIora+C/Fsn2IMucoWhQgbHooQyMPz//KjK616lXLYzgi5rodgP3GS8
        oxFxq4dT0DU+GaTRSxH0TA==
X-Google-Smtp-Source: AGRyM1sryxduiTNQfUHxFS9uPh5IoPlLVa1PLmyUZozgPSpPRW3vdX65d02yyFgdV5ZccJtewsxl7Q==
X-Received: by 2002:a05:6638:dc3:b0:333:ef3c:ba02 with SMTP id m3-20020a0566380dc300b00333ef3cba02mr12315679jaj.245.1656447280311;
        Tue, 28 Jun 2022 13:14:40 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id v17-20020a92c6d1000000b002d52f2f5a97sm6197525ilm.35.2022.06.28.13.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 13:14:40 -0700 (PDT)
Received: (nullmailer pid 905362 invoked by uid 1000);
        Tue, 28 Jun 2022 20:14:38 -0000
Date:   Tue, 28 Jun 2022 14:14:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: arm/juno: Drop erroneous 'mbox-name' property
Message-ID: <20220628201438.GC694214-robh@kernel.org>
References: <20220610213308.2288094-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610213308.2288094-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 03:33:07PM -0600, Rob Herring wrote:
> The 'mbox-name' property in the Juno mailbox node is undocumented and
> unused. It's the consumer side of the mailbox binding that have
> 'mbox-names' properties.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm64/boot/dts/arm/juno-scmi.dtsi | 1 -
>  1 file changed, 1 deletion(-)

Ping!

> 
> diff --git a/arch/arm64/boot/dts/arm/juno-scmi.dtsi b/arch/arm64/boot/dts/arm/juno-scmi.dtsi
> index 4135d62e44a2..ec85cd2c733c 100644
> --- a/arch/arm64/boot/dts/arm/juno-scmi.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-scmi.dtsi
> @@ -187,7 +187,6 @@ &gpu {
>  &mailbox {
>  	compatible = "arm,mhu-doorbell", "arm,primecell";
>  	#mbox-cells = <2>;
> -	mbox-name = "ARM-MHU";
>  };
>  
>  &smmu_etr {
> -- 
> 2.34.1
> 
