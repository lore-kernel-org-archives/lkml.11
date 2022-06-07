Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06676CCA47C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 16:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345021AbiFGQ3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 12:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbiFGQ3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:29:46 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C007522D;
        Tue,  7 Jun 2022 09:29:45 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id n144so2972063iod.4;
        Tue, 07 Jun 2022 09:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VkHgSyrMaxLfSTBUWUPiisxSd9LbZDe0qvh4d09npv4=;
        b=SbXBFID1hcmXzAqH/g1IsymiV37bihdg8xicpoH7fEY08vQQRHdHcf4G81hZgCa8bU
         lawMG+58C91beofo0KST7k6oKTgprZBe0kjhsXDXRamzMv6WT5UiGFFkayVumRKp74Ib
         x0OVF9bKDeey1aMYjyU57Rb90Iy3puVhc1xgpqJlRQ1gRaNxXkdpOEyKdnpJAat9pwXY
         UK+RLbG6ZK8qltRzU49Ew4TZ0sHCto7ZDWv/vmknOdi6iXXAJIt5ycoCZvCteNEaZIJS
         8ZoD4wuDcLkqxLK4ZhdjY4QzRu8DcC8iidFY+7Pxs1TH7+k899sUDpES+P8LlFeHX6Ed
         uKtA==
X-Gm-Message-State: AOAM530yvJP8sWeeuhz82RGNhSrUH9UdiINLDUHhv1HNfgT9/lAFWqJ5
        Zuven7hvjMAsDiK6md3aQw==
X-Google-Smtp-Source: ABdhPJwr9tFjGOeRsEAmBgGX5JBiVi/TZ4GSOFGrJ/CfC9fU/zy1yE9p9mNfAgDeSmLZGt8pyPNYZQ==
X-Received: by 2002:a05:6602:2c13:b0:669:7f63:a2d7 with SMTP id w19-20020a0566022c1300b006697f63a2d7mr1365322iov.169.1654619384433;
        Tue, 07 Jun 2022 09:29:44 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id j4-20020a02cc64000000b003314d7b59b0sm6771376jaq.88.2022.06.07.09.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 09:29:44 -0700 (PDT)
Received: (nullmailer pid 3386644 invoked by uid 1000);
        Tue, 07 Jun 2022 16:29:42 -0000
Date:   Tue, 7 Jun 2022 10:29:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/10] dt-bindings: arm: freescale: Add fsl,scu-clk yaml
 file
Message-ID: <20220607162942.GA3384053-robh@kernel.org>
References: <20220607105951.1821519-1-abel.vesa@nxp.com>
 <20220607105951.1821519-3-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607105951.1821519-3-abel.vesa@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 01:59:43PM +0300, Abel Vesa wrote:
> This documents separately the clock child node of the SCU main node.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  .../bindings/arm/freescale/fsl,scu-clk.yaml   | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu-clk.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu-clk.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-clk.yaml
> new file mode 100644
> index 000000000000..f6b97439ce38
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-clk.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/freescale/fsl,scu-clk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: i.MX SCU Client Device Node - Clock bindings based on SCU Message Protocol
> +
> +maintainers:
> +  - Shawn Guo <shawnguo@kernel.org>
> +
> +description: i.MX SCU Client Device Node
> +  Client nodes are maintained as children of the relevant IMX-SCU device node.
> +  This binding uses the common clock binding.
> +  (Documentation/devicetree/bindings/clock/clock-bindings.txt)
> +  The clock consumer should specify the desired clock by having the clock
> +  ID in its "clocks" phandle cell.
> +  See the full list of clock IDs from
> +  include/dt-bindings/clock/imx8qxp-clock.h
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - fsl,imx8dxl-clk
> +              - fsl,imx8qm-clk
> +              - fsl,imx8qxp-clk
> +          - const: fsl,scu-clk
> +      - items:
> +          - const: fsl,imx8qxp-clk

Why do you need to support with and without a fallback?

> +  '#clock-cells':
> +    const: 2
> +  clocks:
> +    minItems: 1
> +    maxItems: 3

Need to define what are the clock entries.

> +  clock-names:
> +    minItems: 1
> +    maxItems: 3

Need to define the names.

> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - '#clock-cells'
> -- 
> 2.34.3
> 
> 
