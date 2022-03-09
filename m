Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEABC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 01:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiCIBX7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Mar 2022 20:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbiCIBXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:23:43 -0500
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777D0C7920;
        Tue,  8 Mar 2022 17:22:09 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id y27-20020a4a9c1b000000b0032129651bb0so1161518ooj.2;
        Tue, 08 Mar 2022 17:22:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eX/AjvgUx7dimDDaqYJ1aR1sSqjm7p16ve0NHEEsMvQ=;
        b=8DiXPWtfA6N0nw3LJFI3yF6lCTbtE6bAFW46UWcnVdDC62DsieFCjDy6FTw4nbTiOT
         kMCuww4gSFN5sHqzI56Itbz1FdYeceU9TNMJ/rc8N/rvDe0lRZkS5NjFQDSfdcGruznz
         vycSyxQf2ppuxU1JbQmyHe+chS4iWoBl5SO02J4YUGgjgodHqWgIXGSqlkiRdiNS4U/J
         ztfmHZVsYsLpxkOnDQCfSCDeBQiP9tSkDDxwcyyRC8RGQ37kKRj1caBwRF4AJv5ablGY
         ugYB7PGWK6TPYZswzSwoKAam+nP5ZpxiUjHyd5qceOm8xHDrsDmEpLZ2vyvhL9d2QY22
         FlSw==
X-Gm-Message-State: AOAM532G3JHDQH9Twcx5ZwnrSDP/x5ElXGPphCNKInHWGds9IFQxXUjk
        VM9HznPfxx+mTXeGypZYNmC2S39M/w==
X-Google-Smtp-Source: ABdhPJyozRXy0py67UpvosCIVPTHDhRZ/ISthdID0JeEIDiUNQKdIMRBpJnzpj2yaajNnIL0DActgw==
X-Received: by 2002:a05:6870:32ce:b0:d9:a0ee:44b3 with SMTP id r14-20020a05687032ce00b000d9a0ee44b3mr4390721oac.142.1646788845214;
        Tue, 08 Mar 2022 17:20:45 -0800 (PST)
Received: from rob (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z192-20020a4a49c9000000b003213bf4bf0csm235322ooa.31.2022.03.08.17.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 17:20:44 -0800 (PST)
Received: (nullmailer pid 1709815 invoked by uid 1000);
        Wed, 09 Mar 2022 01:20:43 -0000
Date:   Tue, 8 Mar 2022 18:20:43 -0700
From:   Rob Herring <robh@kernel.org>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Rhodes <drhodes@opensource.cirrus.com>
Subject: Re: [PATCH v3 15/16] ASoC: dt-bindings: cs35l41: Document CS35l41
 External Boost
Message-ID: <20220309012043.GA1694603@robh.at.kernel.org>
References: <20220308171730.454587-1-tanureal@opensource.cirrus.com>
 <20220308171730.454587-16-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308171730.454587-16-tanureal@opensource.cirrus.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 05:17:29PM +0000, Lucas Tanure wrote:
> From: David Rhodes <drhodes@opensource.cirrus.com>
> 
> Document internal and external boost feature for ASoC CS35L41.
> For internal boost the following properties are required:
> - cirrus,boost-peak-milliamp
> - cirrus,boost-ind-nanohenry
> - cirrus,boost-cap-microfarad
> 
> For external boost, the GPIO1 must be configured as output,
> so the following properties are required:
> - cirrus,gpio1-src-select = <1>
> - cirrus,gpio1-output-enable
> 
> Signed-off-by: David Rhodes <drhodes@opensource.cirrus.com>
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> ---
>  .../bindings/sound/cirrus,cs35l41.yaml        | 44 +++++++++++++++++--
>  1 file changed, 41 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
> index 3235702ce402..09b515924c59 100644
> --- a/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
> +++ b/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
> @@ -75,6 +75,19 @@ properties:
>      maximum: 3
>      default: 2
>  
> +  cirrus,boost-type:
> +    description:
> +      Configures the type of Boost being used.
> +      Internal boost requires boost-peak-milliamp, boost-ind-nanohenry and
> +      boost-cap-microfarad.
> +      External Boost must have GPIO1 as GPIO output. GPIO1 will be set high to
> +      enable boost voltage.
> +      0 = Internal Boost
> +      1 = External Boost
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    minimum: 0
> +    maximum: 1

What does not present mean? Might be better to make this boolean depending
on what you are trying to accomplish.

> +
>    cirrus,gpio1-polarity-invert:
>      description:
>        Boolean which specifies whether the GPIO1
> @@ -131,9 +144,32 @@ required:
>    - compatible
>    - reg
>    - "#sound-dai-cells"
> -  - cirrus,boost-peak-milliamp
> -  - cirrus,boost-ind-nanohenry
> -  - cirrus,boost-cap-microfarad
> +
> +allOf:
> +  - if:
> +      properties:
> +        cirrus,boost-type:
> +            const: 0

Note that this will be true if cirrus,boost-type is not present. You 
probably want to add 'required'.

> +    then:
> +      required:
> +        - cirrus,boost-peak-milliamp
> +        - cirrus,boost-ind-nanohenry
> +        - cirrus,boost-cap-microfarad
> +    else:
> +      if:
> +        properties:
> +          cirrus,boost-type:
> +            const: 1
> +      then:
> +        required:
> +          - cirrus,gpio1-output-enable
> +          - cirrus,gpio1-src-select
> +        properties:
> +          cirrus,boost-peak-milliamp: false
> +          cirrus,boost-ind-nanohenry: false
> +          cirrus,boost-cap-microfarad: false
> +          cirrus,gpio1-src-select:
> +            enum: [1]
>  
>  additionalProperties: false
>  
> @@ -150,6 +186,8 @@ examples:
>            VA-supply = <&dummy_vreg>;
>            VP-supply = <&dummy_vreg>;
>            reset-gpios = <&gpio 110 0>;
> +
> +          cirrus,boost-type = <0>;
>            cirrus,boost-peak-milliamp = <4500>;
>            cirrus,boost-ind-nanohenry = <1000>;
>            cirrus,boost-cap-microfarad = <15>;
> -- 
> 2.35.1
> 
> 
