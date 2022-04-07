Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABB6C433FE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Apr 2022 18:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346821AbiDGSXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Apr 2022 14:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbiDGSX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 14:23:28 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6B014FB92;
        Thu,  7 Apr 2022 11:21:27 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id e189so6482999oia.8;
        Thu, 07 Apr 2022 11:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZUuPSTjprXcNKfHzz7Qs6snhyaATcmWPUoU1Mkt9TqE=;
        b=PSpFrJdTKG6d76MSNzRPeUe7Sde17JDZyVWanVuhOVK6G3PPu3nwD0pFBlhdYtJbao
         Vk1917gZ9ue7U9xQmu1MmGOxazvDawUsFO2AOUYUvV8MZrysyiR2xDToL7aNBjVyF4Lx
         Ts/vzThIS7W/9baI4LoosSuUx9PVDLJqEmApGQ3X//y7zf85miQdIiKasclbkqYpkTre
         1DH8f22Vk45abq4+ynz20u730NGHHHQ4a4o/eKoXRRaRG53Lh14GYhTRFp49eaiklnSQ
         nzBRmg+FTjbbyV5Xz692tlcBZYcW4IyGds3Fh9yYwHqYzP8P0BlVZiJyMNrs+RcKHKnA
         ZCxA==
X-Gm-Message-State: AOAM533CECPaBelGBGgD3TTa5jt5koHSlVfsxsfJHaJMGEylxpuK5q05
        4jF2VYb536Y1GirDhWCMMw==
X-Google-Smtp-Source: ABdhPJzQ3QKekxOUT9F9yPRhqnVy0KNHkDXdjNZeiEbzCTGOSGHeI4SuJc+WaERnqIJopniAaB0DrA==
X-Received: by 2002:a05:6808:1202:b0:2f9:c7b4:fd56 with SMTP id a2-20020a056808120200b002f9c7b4fd56mr351609oil.55.1649355686314;
        Thu, 07 Apr 2022 11:21:26 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u22-20020a4ae696000000b0032158ab4ce9sm7507715oot.26.2022.04.07.11.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 11:21:26 -0700 (PDT)
Received: (nullmailer pid 1732024 invoked by uid 1000);
        Thu, 07 Apr 2022 18:21:25 -0000
Date:   Thu, 7 Apr 2022 13:21:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mtd: jedec,spi-nor: remove unneeded
 properties
Message-ID: <Yk8rpUXmfmULMVjr@robh.at.kernel.org>
References: <20220407142004.292782-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407142004.292782-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 04:20:04PM +0200, Krzysztof Kozlowski wrote:
> After conversion the jedec,spi-nor DT schema to reference other schemas
> (SPI and MTD) and use unevaluatedProperties, several properties are
> redundant.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/mtd/jedec,spi-nor.yaml        | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> index 4abfb4cfc157..708e7f88fd92 100644
> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> @@ -50,10 +50,6 @@ properties:
>      minItems: 1
>      maxItems: 2
>  
> -  spi-max-frequency: true
> -  spi-rx-bus-width: true
> -  spi-tx-bus-width: true
> -
>    m25p,fast-read:
>      type: boolean
>      description:
> @@ -74,14 +70,9 @@ properties:
>        be used on such systems, to denote the absence of a reliable reset
>        mechanism.
>  
> -  label: true
> -
>    partitions:
>      type: object
>  
> -  '#address-cells': true
> -  '#size-cells': true

These are needed for 'partition' nodes.

> -
>  patternProperties:
>    # Note: use 'partitions' node for new users
>    '^partition@':
> @@ -99,8 +90,6 @@ examples:
>          #size-cells = <0>;
>  
>          flash@0 {
> -            #address-cells = <1>;
> -            #size-cells = <1>;
>              compatible = "spansion,m25p80", "jedec,spi-nor";
>              reg = <0>;
>              spi-max-frequency = <40000000>;
> -- 
> 2.32.0
> 
> 
