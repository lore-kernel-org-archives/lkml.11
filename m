Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447D3C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 May 2022 12:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346299AbiEQMl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 08:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346238AbiEQMlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:41:07 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D965175B9;
        Tue, 17 May 2022 05:41:06 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id z5-20020a9d62c5000000b00606041d11f1so12097915otk.2;
        Tue, 17 May 2022 05:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=j5BrlQzLDAXkM38uIDVehzNU2wxoisuVTDhfLkPcVrc=;
        b=0RDRgmF5G0qzalk5RL6th1GOCJU0myYv2zLfiBlAJBtMZPSKWD/5sPjHHKvQR/h4oQ
         NgeAxTRGsS4c01xg/0WQx5skz4VAgfF+gGQWxNDyfdi2+hpSni3bGrfhM3kmA+zh1lSh
         00hNz8q/7jEpkBcPRgx0e889iJzvgH2DQ08ROspAAy44xG71Dnf9kINt0rrLDcw7n942
         oMwz97RAzRgvBt2a/QML5ZyEZxsTcikkZ32s/A4NkMzNOLGJluzuTYStBi671l/bbz/n
         0To9aW1AaIRcSA+Mg0ASMt3Un4aTJitEdhMrncIMuGqAW/nWt58zyYwOBFNJrKFo5/y+
         tFWQ==
X-Gm-Message-State: AOAM532YVkDdX4C13O3NO9uTjVdWbXkIfYpR+XlH5QOqNSp/bxQl8k36
        XwL30Db+vdoOtHfJqStL0g==
X-Google-Smtp-Source: ABdhPJxJmvcvtYfkkdf1N9RF24PpCjCJKFrr+60SDWwOuXaRZwDYasMaqX9n9wa5JyRWrgIr2jVGlw==
X-Received: by 2002:a05:6830:1491:b0:606:103c:6680 with SMTP id s17-20020a056830149100b00606103c6680mr7862250otq.18.1652791265485;
        Tue, 17 May 2022 05:41:05 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r196-20020acaa8cd000000b00325cda1ffa5sm4743640oie.36.2022.05.17.05.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 05:41:04 -0700 (PDT)
Received: (nullmailer pid 785394 invoked by uid 1000);
        Tue, 17 May 2022 12:40:59 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>, linux-usb@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        quic_pkondeti@quicinc.com, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, quic_ppratap@quicinc.com,
        quic_vpulyala@quicinc.com,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org
In-Reply-To: <1652723410-1630-2-git-send-email-quic_kriskura@quicinc.com>
References: <1652723410-1630-1-git-send-email-quic_kriskura@quicinc.com> <1652723410-1630-2-git-send-email-quic_kriskura@quicinc.com>
Subject: Re: [v5 1/3] dt-bindings: phy: qcom,usb-snps-femto-v2: Add phy override params bindings
Date:   Tue, 17 May 2022 07:40:59 -0500
Message-Id: <1652791259.453681.785393.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2022 23:20:08 +0530, Krishna Kurapati wrote:
> From: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> 
> Add device tree bindings for SNPS phy tuning parameters.
> 
> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  .../bindings/phy/qcom,usb-snps-femto-v2.yaml       | 105 +++++++++++++++++++++
>  1 file changed, 105 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,hs-rise-fall-time-bp: 'minimim' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'type', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,hs-crossover-voltage-microvolt: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: ignoring, error in schema: properties: qcom,hs-rise-fall-time-bp
Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.example.dtb:0:0: /example-0/phy@88e2000: failed to match any schema with compatible: ['qcom,sm8150-usb-hs-phy']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

