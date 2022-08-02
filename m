Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D23AC00140
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Aug 2022 22:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237271AbiHBWjQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Aug 2022 18:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237207AbiHBWiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:38:52 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B3254CBF;
        Tue,  2 Aug 2022 15:38:36 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id z132so11795351iof.0;
        Tue, 02 Aug 2022 15:38:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=xc7pVcgM8oggfYYoDi+YgFJKASpGtHTVPBIB9MLasi0=;
        b=U68JPjhcBKABY2EvsarONwVp5tohHQCtr7S63ThToKpvKEov9ALIHsiM+hl/1/X51v
         ZZ8SkqvresjW37+CbExxB/IiJ1OJdmem9wQgLH3siNzkk5gL7SnFNdXbrNqbr/WjAbJp
         aBjKeCOet+qZ6l1F1o8bjOBsCVHITkvvWx3U6R9TlG2J8eHQPcX2sLBkBGn7pt5qrDmf
         XQ2Pzj7czWDUYtlia7mbWCxx+Hf6xQ21npZXIYBQ/US2UTo8c/ynR86GAwnlIQzcJZxo
         chROhYDn5JzRgRFjitmcK7FKSnuDUQ67ikb5Fv3QHGXFOJlcaGkJyZCG4VzzdoGo7rpO
         VxBQ==
X-Gm-Message-State: AJIora+opKqbpGMhWwm9yl+DQ15SC8nwvzUV8CkfVwkGq8RCvoWnRU68
        FGBAlwt3HygFoaJu9AdFbQ==
X-Google-Smtp-Source: AGRyM1uvjDnbb8GnFfjBfYlQ83bdSSQK2oBX9P0LrOPi4jW/MSL2a2C/PDhZtFJlJhS9j6J7oaGaYQ==
X-Received: by 2002:a02:9046:0:b0:341:af23:4bb5 with SMTP id y6-20020a029046000000b00341af234bb5mr8385992jaf.44.1659479911950;
        Tue, 02 Aug 2022 15:38:31 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id d191-20020a0262c8000000b00341927a1e0dsm7109249jac.72.2022.08.02.15.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 15:38:31 -0700 (PDT)
Received: (nullmailer pid 758799 invoked by uid 1000);
        Tue, 02 Aug 2022 22:38:27 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jai Luthra <j-luthra@ti.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20220802214811.29033-1-j-luthra@ti.com>
References: <20220802214811.29033-1-j-luthra@ti.com>
Subject: Re: [PATCH] dt-bindings: sound: tlv320aic3x: Convert to dtschema
Date:   Tue, 02 Aug 2022 16:38:27 -0600
Message-Id: <1659479907.575212.758797.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Aug 2022 16:48:11 -0500, Jai Luthra wrote:
> Convert bindings for TI's TLV320AIC3x audio codecs to dtschema.
> 
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---
>  .../devicetree/bindings/sound/tlv320aic3x.txt |  97 ------------
>  .../bindings/sound/tlv320aic3x.yaml           | 145 ++++++++++++++++++
>  2 files changed, 145 insertions(+), 97 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/tlv320aic3x.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/tlv320aic3x.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/tlv320aic3x.yaml: properties:ai3x-gpio-func:maxItems: False schema does not allow 3
	hint: Scalar properties should not have array keywords
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/tlv320aic3x.yaml: properties:ai3x-gpio-func:minItems: False schema does not allow 3
	hint: Scalar properties should not have array keywords
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/tlv320aic3x.yaml: ignoring, error in schema: properties: ai3x-gpio-func: maxItems
Documentation/devicetree/bindings/sound/tlv320aic3x.example.dtb:0:0: /example-0/i2c/tlv320aic3x@1b: failed to match any schema with compatible: ['ti,tlv320aic3x']
Documentation/devicetree/bindings/sound/tlv320aic3x.example.dtb:0:0: /example-1/spi/codec@0: failed to match any schema with compatible: ['ti,tlv320aic3x']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

