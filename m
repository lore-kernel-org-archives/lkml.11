Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20045C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Feb 2022 00:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiBQA0d (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Feb 2022 19:26:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiBQA02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 19:26:28 -0500
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B882AA3A5;
        Wed, 16 Feb 2022 16:26:15 -0800 (PST)
Received: by mail-il1-f176.google.com with SMTP id h11so1099013ilq.9;
        Wed, 16 Feb 2022 16:26:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C6PzgH9pozHS/vASy5sehliUW75Ia88kd3NPde72uEc=;
        b=5zzTwB0R6IsUZvu36sYkg/9lG8zUzjb50r8Mu7yi7Ms/c98cr9Rmfy1Slqtcgm2ri+
         TVHVUP0h0m5wUUr0kziZH4er7lNst3BEy5DQLQVs+WRLRz78pdwmJMRVU6BHVWlo8i7M
         DbMbV9OJaKYy/wAIcql6M7wbnglZbMnNYm+vVpV0cVugWcacsFfuhtMOFPGbPoLqA9dM
         4WdX22VaXq/Xu+4LcwTyJHrzpEE3cwKnBRJWD1SYP3QpcAeRn7uImb47re31eEZeV0fP
         UBOarostp1D8gFYIuejoy0IRA8/cHWpHK4NQ0TRON5XQiPo59FgIkpKSaWW8LRPnEobx
         +2Mw==
X-Gm-Message-State: AOAM532flFGVy9CNfiTodbSv9pCeaJLW+naCJ0cY+iakPSMQPsj19Pr6
        /H14miQrpgVrhG3G2fH74w==
X-Google-Smtp-Source: ABdhPJxgFrm4Lh1Md07b/SJUVFX/T7aLxRNb8EIC+WQXPrLXe9qa/iqyaQg4aFNR6a8/a7QCdkLncQ==
X-Received: by 2002:a05:6e02:1b04:b0:2ba:7f04:f117 with SMTP id i4-20020a056e021b0400b002ba7f04f117mr264481ilv.74.1645057574745;
        Wed, 16 Feb 2022 16:26:14 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id k9sm909544ilv.31.2022.02.16.16.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 16:26:14 -0800 (PST)
Received: (nullmailer pid 1967160 invoked by uid 1000);
        Thu, 17 Feb 2022 00:26:12 -0000
Date:   Wed, 16 Feb 2022 18:26:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: arm: at91: add Kontron's new KSwitches
Message-ID: <Yg2WJE170FDvALn8@robh.at.kernel.org>
References: <20220210131817.484922-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210131817.484922-1-michael@walle.cc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2022 14:18:17 +0100, Michael Walle wrote:
> The Kontron KSwitch D10 MMT series ethernet switches features a LAN9668
> SoC with either 8 copper ports or 6 copper port and two SFP cages.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> changes since v1:
>  - just use one entry with an enum, thanks Krzysztof
> 
>  Documentation/devicetree/bindings/arm/atmel-at91.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
