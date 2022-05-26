Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E099C433FE
	for <linux-kernel@archiver.kernel.org>; Thu, 26 May 2022 12:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237749AbiEZMkk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 May 2022 08:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240043AbiEZMkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 08:40:37 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C1D2F020;
        Thu, 26 May 2022 05:40:36 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id y66so1979716oia.1;
        Thu, 26 May 2022 05:40:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=8QQi9UAdNLHLfBvhZVbeEVs5brcL+rQG9Px5mSwS5Fc=;
        b=STvQ6hlCLk+S2RsJy789msnRZ+D6U1Q2AoQbneMprIdFT6d7DyRqLdY3DZIKWi2ZyJ
         rYqdHKBpxT36FYpm1ltGd6A+V9NAYE2AX+3dYWI+LT984aXUbKy6dL873MdP1zaStK3N
         qpqEo1kQO43Ttey2/1RI/0uHFgMf2Rz7xD2m9mapFXZWuHMgZU4QH8QBykK+wxvnkYA4
         Ki9l6hz//0hVb0jaQlARQuIYgRW5PGGEzUJ5IGlYF8ldZgSvrEveUNbqi8QP0dF+Zc7A
         Jr1y8wzqvKdGddlnwCI/27OW4jJGxKGv1KuG3lQTEJAojAbceX8Yz7g7wc3avphm3zEE
         D3oQ==
X-Gm-Message-State: AOAM532jlPAdNLzOOBGlNbkbr/uP9Q0lfcJH6VLwXYU4HEO3xX3wZCLZ
        A/RFbEiQgAZBBPMCk4N0ZA==
X-Google-Smtp-Source: ABdhPJzSEnsODeFXU35jwjUC1neJG1165yxNM0C9AuIQwkdwRBKk9KKxp3vy0jylqao/4eNol/as0g==
X-Received: by 2002:aca:6c5:0:b0:325:5bce:bbc1 with SMTP id 188-20020aca06c5000000b003255bcebbc1mr1002134oig.221.1653568835402;
        Thu, 26 May 2022 05:40:35 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p8-20020a056870a54800b000f169cbbb32sm565161oal.43.2022.05.26.05.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 05:40:34 -0700 (PDT)
Received: (nullmailer pid 3797151 invoked by uid 1000);
        Thu, 26 May 2022 12:40:33 -0000
From:   Rob Herring <robh@kernel.org>
To:     Harsh Agarwal <quic_harshq@quicinc.com>
Cc:     quic_pkondeti@quicinc.com, Philipp Zabel <p.zabel@pengutronix.de>,
        quic_ppratap@quicinc.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <1653560029-6937-2-git-send-email-quic_harshq@quicinc.com>
References: <1653560029-6937-1-git-send-email-quic_harshq@quicinc.com> <1653560029-6937-2-git-send-email-quic_harshq@quicinc.com>
Subject: Re: [RFC v2 1/2] dt-bindings: usb: dwc3: Add support for multiport related properties
Date:   Thu, 26 May 2022 07:40:33 -0500
Message-Id: <1653568833.732260.3797150.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 May 2022 15:43:48 +0530, Harsh Agarwal wrote:
> Added support for multiport, mport, num-ssphy and num-hsphy
> properties. These properties are used to support devices having
> a multiport controller.
> 
> Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
> ---
>  .../devicetree/bindings/usb/snps,dwc3.yaml         | 55 ++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/usb/snps,dwc3.yaml:366:8: [warning] wrong indentation: expected 6 but found 7 (indentation)
./Documentation/devicetree/bindings/usb/snps,dwc3.yaml:367:10: [warning] wrong indentation: expected 11 but found 9 (indentation)
./Documentation/devicetree/bindings/usb/snps,dwc3.yaml:369:11: [warning] wrong indentation: expected 11 but found 10 (indentation)

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/usb/snps,dwc3.example.dts:86.27-89.15: Warning (unit_address_vs_reg): /example-2/usb@4a000000/multiport/mport@1: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/usb/snps,dwc3.example.dts:91.27-93.15: Warning (unit_address_vs_reg): /example-2/usb@4a000000/multiport/mport@2: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/usb/snps,dwc3.example.dts:95.27-97.15: Warning (unit_address_vs_reg): /example-2/usb@4a000000/multiport/mport@3: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/usb/snps,dwc3.example.dts:99.27-101.15: Warning (unit_address_vs_reg): /example-2/usb@4a000000/multiport/mport@4: node has a unit name, but no reg or ranges property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/snps,dwc3.example.dtb: usb@4a000000: multiport: 'mport' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/snps,dwc3.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

