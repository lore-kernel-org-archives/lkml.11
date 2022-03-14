Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB40C43217
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 14:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237905AbiCNOoJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 10:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbiCNOoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 10:44:04 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8E82649;
        Mon, 14 Mar 2022 07:42:53 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id b16so18507734ioz.3;
        Mon, 14 Mar 2022 07:42:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=P6i4RU/tPZze8eL4r7T4d4lTaUlhqOICZTOabmzGqJo=;
        b=1J1+B4FOMG7i6YAoYNLXAW9PNAiCiFocpokkyj98SKTZ9Xq0luPQSTumhqsG93ypbt
         jg89FhT+V6lyM7D8n/MMBLdlurzn7ZOBmT1Vna8yFbucWYKYmoGlt2tTHHZSovKWnksr
         /bpRPvSqT13aMlr+H3mOxlPYQnjMGaQnjwOomM+FA3gs+VfDxUrTbAr0J2ksiQ+j6K/q
         TvV2UP7wEXQjqjLxamdDgTVPN68W41L1nTK4El6oLycanqIoLrbAho+FgTEpb0jp1Hwd
         rrCMk6vHMjFmYaeVVkoV0IbQBQj1fw34Mv4qy1KY3E9lr4hCtpZeVdY1EXbG7MaRP2rm
         wSyw==
X-Gm-Message-State: AOAM533SntIRzdE6uvq4uc6E495i5M0kWHMJBnM4Vx6L4bG8LKnrKrT5
        pGUbW5634Gh8gxWVM9uxqw==
X-Google-Smtp-Source: ABdhPJx1W+IucDCrXQADrUIvGLf3h0+168Y/wjXCtVEGvr+Aigd/pJ+Wk1AuIprhiK1BehyvzdFPtw==
X-Received: by 2002:a05:6638:1405:b0:30d:69cd:f44 with SMTP id k5-20020a056638140500b0030d69cd0f44mr20485674jad.208.1647268972747;
        Mon, 14 Mar 2022 07:42:52 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id p4-20020a92d284000000b002c64436fa71sm9071631ilp.72.2022.03.14.07.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 07:42:51 -0700 (PDT)
Received: (nullmailer pid 12506 invoked by uid 1000);
        Mon, 14 Mar 2022 14:42:49 -0000
From:   Rob Herring <robh@kernel.org>
To:     Tony Huang <tonyhuang.sunplus@gmail.com>
Cc:     tony.huang@sunplus.com, derek.kiernan@xilinx.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, dragan.cvetic@xilinx.com,
        arnd@arndb.de, krzysztof.kozlowski@canonical.com,
        gregkh@linuxfoundation.org, wells.lu@sunplus.com
In-Reply-To: <c0ef91adc0af9fedca2791e4006009fabfdfef2c.1647095774.git.tonyhuang.sunplus@gmail.com>
References: <cover.1647095774.git.tonyhuang.sunplus@gmail.com> <c0ef91adc0af9fedca2791e4006009fabfdfef2c.1647095774.git.tonyhuang.sunplus@gmail.com>
Subject: Re: [PATCH v11 1/2] dt-bindings: misc: Add iop yaml file for Sunplus SP7021
Date:   Mon, 14 Mar 2022 08:42:49 -0600
Message-Id: <1647268969.313741.12505.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Mar 2022 00:16:04 +0800, Tony Huang wrote:
> Add iop yaml file for Sunplus SP7021
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
> ---
> Changes in v11:
>  - Addressed comments from krzysztof.
> 
>  .../devicetree/bindings/misc/sunplus,iop.yaml      | 78 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 ++
>  2 files changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/sunplus,iop.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/misc/sunplus,iop.yaml:78:7: [error] no new line character at the end of file (new-line-at-end-of-file)

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/misc/sunplus,iop.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/misc/sunplus,iop.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/misc/sunplus,iop.example.dt.yaml: iop@9c000400: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/misc/sunplus,iop.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1604673

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

