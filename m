Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396D4C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Apr 2022 15:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240730AbiDJPaF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Apr 2022 11:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiDJPaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 11:30:03 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288B948894;
        Sun, 10 Apr 2022 08:27:53 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id w17-20020a056830111100b005b22c584b93so9639987otq.11;
        Sun, 10 Apr 2022 08:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=1mL2aY3xXiJ7dMZfNmBOeXXhr4K+A6cg+YMWCgVINI8=;
        b=p5tpy+vA5N66xtoEH70fESaRa6YvOGHiw7hOwLn2WODGAGz1Dua43/bAWhHipx/VWS
         JhL4EsvcucJmQJcqVTShUCykQgD148lXF5ruVp+Qk4r0THdqdfNMrNKYWi1VrHB9Zb4k
         T7G6QTdGwMgZQk8CndKntaO3ZXaSt8ek98qVrOY2P2HsfMeVun7dXxrYKRNwwCxmuwgA
         MYY3nQYLQuZWXHtyCUR9YJCL48F0F6kGfun6M4QwhOoQc6hqVGyKtkSDxeCQxzhvUPX9
         pwbVr+PA1C/XoDoJq5F6jEV4ICmJKIVCEqRj7XNNKjQpZdT0NmgGHUxARJftxNZ/pFs4
         hqyQ==
X-Gm-Message-State: AOAM531MGF0jHbp2EXdDDbmf7GCIOg1/aMYXZB2TpDx/ZWgFikEZPQyv
        mgGPM/L/nYEi2CC+WHsv0Q==
X-Google-Smtp-Source: ABdhPJyi8R/bY9ArK+hRKVWel+qJZbd2owFN/x05OqsuEXsLMtLZrEa76EQkdalH3xDyM0QlC0RRDQ==
X-Received: by 2002:a9d:868:0:b0:5ce:1958:2ce1 with SMTP id 95-20020a9d0868000000b005ce19582ce1mr9428105oty.147.1649604472428;
        Sun, 10 Apr 2022 08:27:52 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k10-20020a4abd8a000000b00324907b406fsm10296066oop.21.2022.04.10.08.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 08:27:51 -0700 (PDT)
Received: (nullmailer pid 3426157 invoked by uid 1000);
        Sun, 10 Apr 2022 15:27:51 -0000
From:   Rob Herring <robh@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        letux-kernel@openphoenux.org, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
In-Reply-To: <84adfe6237cd4cfd52cb9723416f69926e556e55.1649443080.git.hns@goldelico.com>
References: <cover.1649443080.git.hns@goldelico.com> <84adfe6237cd4cfd52cb9723416f69926e556e55.1649443080.git.hns@goldelico.com>
Subject: Re: [PATCH 13/18] dt-bindings: fix jz4780-nemc issue as reported by dtbscheck
Date:   Sun, 10 Apr 2022 10:27:51 -0500
Message-Id: <1649604471.299379.3426156.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Apr 2022 20:37:56 +0200, H. Nikolaus Schaller wrote:
> jz4780-nemc needs to be compatible to simple-mfd as well or we get
> 
> arch/mips/boot/dts/ingenic/ci20.dtb: memory-controller@13410000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	['ingenic,jz4780-nemc', 'simple-mfd'] is too long
> 	'ingenic,jz4725b-nemc' was expected
> 	'ingenic,jz4740-nemc' was expected
> 	From schema: Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  .../devicetree/bindings/memory-controllers/ingenic,nemc.yaml    | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml:20:23: [warning] too few spaces after comma (commas)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml: properties:compatible:oneOf:0:enum:1: ['ingenic', 'jz4780-nemc', 'simple-mfd'] is not of type 'string'
	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml: ignoring, error in schema: properties: compatible: oneOf: 0: enum: 1
Documentation/devicetree/bindings/mtd/ingenic,nand.example.dtb:0:0: /example-0/memory-controller@13410000: failed to match any schema with compatible: ['ingenic,jz4780-nemc']
Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.example.dtb:0:0: /example-0/memory-controller@13410000: failed to match any schema with compatible: ['ingenic,jz4780-nemc']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

