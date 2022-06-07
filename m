Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B7AC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 16:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344254AbiFGQck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 12:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbiFGQci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:32:38 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E539022BCD;
        Tue,  7 Jun 2022 09:32:36 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id d7so9498406iof.10;
        Tue, 07 Jun 2022 09:32:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rVeOPt1rquCTzA9kjd/p/dlOlMYCaOYG3RBeb0SndAg=;
        b=ZS+PZQoSn2sASIZ3iX7ndCR/SJBykl5IBju5bU6pSut5kGIfR9yWXytk89P0VWJe/4
         Qy32bwcj6yU6oMzY0rlzND0FkHmRuZrQwrJVCiVl3eiMh0hlzOokrat6VtyELDxsdclr
         zUsn/lFOTpjKKb55HdyVihW8sFeDPVTBJwyITwcnEb3SzgyXkAG+XlhyL5lzRBDPdI/1
         1IrDaH+bC1opyOjYXlhekGbwPShOoa11J1G2C8S0TGaZhS4piJrdrosmOPW98rbaS5B/
         ChdkOvYv+vFjbpZUNpa3WCiQemVQx/Yh6PDEckTkb5gu1r51zrNb+e3YtPCHiLKazsE4
         aWAw==
X-Gm-Message-State: AOAM531OBL+ZgVa3v8gmKb+KP1eCNB5c5u6rQAOBGUI1uqRsN9Vke1Mr
        1YxYLG2kzv5neMnepJV4eA==
X-Google-Smtp-Source: ABdhPJwxy5B7FSxAcypBGvH0qkzPyXdFxGcvh0ARIoNUf/Ssjkc7hT+UhVIXEto2xhsx82Tfyt/aXg==
X-Received: by 2002:a05:6602:2d0e:b0:64f:d1ff:ac9c with SMTP id c14-20020a0566022d0e00b0064fd1ffac9cmr14578583iow.41.1654619556127;
        Tue, 07 Jun 2022 09:32:36 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id l10-20020a02cd8a000000b00330f8579e2csm6785921jap.99.2022.06.07.09.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 09:32:35 -0700 (PDT)
Received: (nullmailer pid 3391203 invoked by uid 1000);
        Tue, 07 Jun 2022 16:32:31 -0000
Date:   Tue, 7 Jun 2022 10:32:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/10] dt-bindings: arm: freescale: Add fsl,scu-wdt yaml
 file
Message-ID: <20220607163231.GC3384053-robh@kernel.org>
References: <20220607105951.1821519-1-abel.vesa@nxp.com>
 <20220607105951.1821519-10-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607105951.1821519-10-abel.vesa@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 01:59:50PM +0300, Abel Vesa wrote:
> This documents separately the watchdog child node of the SCU main node.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  .../bindings/arm/freescale/fsl,scu-wdt.yaml   | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu-wdt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu-wdt.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-wdt.yaml
> new file mode 100644
> index 000000000000..c5d71ca83963
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-wdt.yaml
> @@ -0,0 +1,29 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/freescale/fsl,scu-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: i.MX SCU Client Device Node - Watchdog bindings based on SCU Message Protocol
> +
> +maintainers:
> +  - Shawn Guo <shawnguo@kernel.org>
> +
> +description: i.MX SCU Client Device Node
> +  Client nodes are maintained as children of the relevant IMX-SCU device node.
> +

Need a ref to watchdog.yaml

> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: fsl,imx8qxp-sc-wdt
> +          - const: fsl,imx-sc-wdt
> +      - items:
> +          - const: fsl,imx-sc-wdt
> +
> +  timeout-sec: true
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> -- 
> 2.34.3
> 
> 
