Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FA6C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Mar 2022 01:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352211AbiCaBCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346065AbiCaBCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 21:02:04 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6783365D10;
        Wed, 30 Mar 2022 18:00:18 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id e4so23845966oif.2;
        Wed, 30 Mar 2022 18:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MA12qnKm1ceMQI3Fku8u66b+ikv0ibJvyYHXba44Nq8=;
        b=U07Mn0D+6UH6qqY6lMvvO+Z22kBhnneLOWC0zkc61EpAbaDzrQszQ8SFtd4JG7hFPA
         beilO7wepZAbhLQBrSaSqXvKpYQ+2A4NypRwqvrSK+2bEMCM0HJ79rcCdY8McXf4+JQB
         ZiNnl2Q5O6hc45wYPDpOEHl8rZZWdWYEPmEzJ0LYqEn4gP9toU4ONP8B5xLbJ6scFi/L
         p0Sf1AoX0BeYl0K06yN1tvPVIvmaAAIIO/7kIfZm0gONqK4YT2YSzuQRl6SPZ26lvGbe
         +aRxBXdENBppgNuCjW1jrKcxr6MqeheDXXz5GbKFwjzgt8mPWmldDGH+XAr8iSILHeJ2
         HY0g==
X-Gm-Message-State: AOAM5326xyKpuE07jQL/avrr1K327SDF9ytVayZXtkIPLbEJb3f5+3lU
        U3/fFUxDTR25K7EmCR4IYKOR2Sk9Iw==
X-Google-Smtp-Source: ABdhPJxE68EL8aL8GTYB+UYnBt/e2Dr9E24iTCHNTEL6ZagdmVa1T4AzTMpCaLD/ziMuzcoHKH1Qnw==
X-Received: by 2002:a05:6808:55:b0:2ec:a4ae:fdde with SMTP id v21-20020a056808005500b002eca4aefddemr1547529oic.106.1648688417736;
        Wed, 30 Mar 2022 18:00:17 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 38-20020a9d0da9000000b005cb437ac0e2sm11538034ots.44.2022.03.30.18.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 18:00:17 -0700 (PDT)
Received: (nullmailer pid 4000825 invoked by uid 1000);
        Thu, 31 Mar 2022 01:00:16 -0000
Date:   Wed, 30 Mar 2022 20:00:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-renesas-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: power: renesas,apmu: Fix cpus property
 limits
Message-ID: <YkT9IFHc1k3uiUW+@robh.at.kernel.org>
References: <9ece1a07bbcb95abc9d80e6a6ecc95806a294a11.1648645279.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ece1a07bbcb95abc9d80e6a6ecc95806a294a11.1648645279.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2022 15:04:16 +0200, Geert Uytterhoeven wrote:
> "make dtbs_check":
> 
>     arch/arm/boot/dts/r8a7791-koelsch.dtb: apmu@e6152000: cpus:0: [6, 7] is too long
> 	    From schema: Documentation/devicetree/bindings/power/renesas,apmu.yaml
> 
> Correct the minimum and maximum number of CPUs controlled by a single
> APMU instance.
> 
> Fixes: 39bd2b6a3783b899 ("dt-bindings: Improve phandle-array schemas")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/power/renesas,apmu.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Applied, thanks!
