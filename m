Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EC8C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jul 2022 18:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbiGRSG7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jul 2022 14:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbiGRSG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 14:06:58 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA242ED5B;
        Mon, 18 Jul 2022 11:06:57 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id h145so9910416iof.9;
        Mon, 18 Jul 2022 11:06:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2XLx27BevMMYggeW95Kf6PqEo7TObURqeNS6YT6uRbI=;
        b=PEH/ID9jzB8pVVho+x6i/DrTPkBcjC6YsG30XT+PmivKRrLLU0Lo/ac5SfF/XtrYHj
         cJHmRsHDdBH8KonREiyBYA+GFzaWpAR05E0P7NZrB+NWeuPiQE32Wk5V9BavgCB85kfF
         Y8OQR1Yr7U1MXlDS69/j+tdeQQ7JqZtds138lj8dX7ZgPwn9QlMz/tc9GPRGSy6r1J43
         GRihUN2AnRPdS4I6M9s8yFFYVuT+txLEyj7zBPrkix3s4ocNBUrEQ0BuX1vlbq6Ry1Zm
         Mhc/c8PCTLPEuaAaaUncjF85rFpcFR3KDLt8RHKkEJJOjKZEfYpy6X+AyVwoQcGcsXUl
         1ubg==
X-Gm-Message-State: AJIora/GnYZFBMoWn0A+S4dl1nZ2nmyAGGW1zGlpVrRPe2ZRpaTpN1T9
        RZSu5K/EAR4aHtb6TpcHGg==
X-Google-Smtp-Source: AGRyM1vBi5nYgBxBwYhVAQ7Lyykz76T6YG04KzUoCurovhRE7LNmZwdfqXQIWdN5VoZD4+YmGpR/Xg==
X-Received: by 2002:a05:6638:411f:b0:33f:8c3d:c4d9 with SMTP id ay31-20020a056638411f00b0033f8c3dc4d9mr13525413jab.259.1658167616369;
        Mon, 18 Jul 2022 11:06:56 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id l1-20020a922801000000b002dc2b20e9cfsm4993358ilf.1.2022.07.18.11.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 11:06:56 -0700 (PDT)
Received: (nullmailer pid 3266350 invoked by uid 1000);
        Mon, 18 Jul 2022 18:06:54 -0000
Date:   Mon, 18 Jul 2022 12:06:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        chun-jie.chen@mediatek.com, weiyi.lu@mediatek.com,
        mbrugger@suse.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        nfraprado@collabora.com
Subject: Re: [PATCH 2/3] dt-bindings: power: mediatek: Update example to use
 phandle to syscon
Message-ID: <20220718180654.GA3260460-robh@kernel.org>
References: <20220711122503.286743-1-angelogioacchino.delregno@collabora.com>
 <20220711122503.286743-3-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711122503.286743-3-angelogioacchino.delregno@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 02:25:02PM +0200, AngeloGioacchino Del Regno wrote:
> The preferred way of declaring this node is by using a phandle to
> syscon: update the example to reflect that.

Preferred by who? Not me. 
 
What problem are you trying to solve? Better be a good reason for 
breaking compatibility.


> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../power/mediatek,power-controller.yaml      | 125 +++++++++---------
>  1 file changed, 63 insertions(+), 62 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> index 848fdff7c9d8..bed059e4401d 100644
> --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> @@ -237,76 +237,77 @@ examples:
>          scpsys: syscon@10006000 {
>              compatible = "syscon", "simple-mfd";

Only generic compatibles is certainly not preferred.

>              reg = <0 0x10006000 0 0x1000>;
> +        };
> +    };
>  
> -            spm: power-controller {
> -                compatible = "mediatek,mt8173-power-controller";
> +    spm: power-controller {
> +        compatible = "mediatek,mt8173-power-controller";
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        #power-domain-cells = <1>;
> +        syscon = <&scpsys>;
> +
> +        /* power domains of the SoC */
> +        power-domain@MT8173_POWER_DOMAIN_VDEC {
> +            reg = <MT8173_POWER_DOMAIN_VDEC>;
> +            clocks = <&topckgen CLK_TOP_MM_SEL>;
> +            clock-names = "mm";
> +            #power-domain-cells = <0>;
> +        };
> +        power-domain@MT8173_POWER_DOMAIN_VENC {
> +            reg = <MT8173_POWER_DOMAIN_VENC>;
> +            clocks = <&topckgen CLK_TOP_MM_SEL>,
> +                     <&topckgen CLK_TOP_VENC_SEL>;
> +            clock-names = "mm", "venc";
> +            #power-domain-cells = <0>;
> +        };
> +        power-domain@MT8173_POWER_DOMAIN_ISP {
> +            reg = <MT8173_POWER_DOMAIN_ISP>;
> +            clocks = <&topckgen CLK_TOP_MM_SEL>;
> +            clock-names = "mm";
> +            #power-domain-cells = <0>;
> +        };
> +        power-domain@MT8173_POWER_DOMAIN_MM {
> +            reg = <MT8173_POWER_DOMAIN_MM>;
> +            clocks = <&topckgen CLK_TOP_MM_SEL>;
> +            clock-names = "mm";
> +            #power-domain-cells = <0>;
> +            mediatek,infracfg = <&infracfg>;
> +        };
> +        power-domain@MT8173_POWER_DOMAIN_VENC_LT {
> +            reg = <MT8173_POWER_DOMAIN_VENC_LT>;
> +            clocks = <&topckgen CLK_TOP_MM_SEL>,
> +                     <&topckgen CLK_TOP_VENC_LT_SEL>;
> +            clock-names = "mm", "venclt";
> +            #power-domain-cells = <0>;
> +        };
> +        power-domain@MT8173_POWER_DOMAIN_AUDIO {
> +            reg = <MT8173_POWER_DOMAIN_AUDIO>;
> +            #power-domain-cells = <0>;
> +        };
> +        power-domain@MT8173_POWER_DOMAIN_USB {
> +            reg = <MT8173_POWER_DOMAIN_USB>;
> +            #power-domain-cells = <0>;
> +        };
> +        power-domain@MT8173_POWER_DOMAIN_MFG_ASYNC {
> +            reg = <MT8173_POWER_DOMAIN_MFG_ASYNC>;
> +            clocks = <&clk26m>;
> +            clock-names = "mfg";
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            #power-domain-cells = <1>;
> +
> +            power-domain@MT8173_POWER_DOMAIN_MFG_2D {
> +                reg = <MT8173_POWER_DOMAIN_MFG_2D>;
>                  #address-cells = <1>;
>                  #size-cells = <0>;
>                  #power-domain-cells = <1>;
>  
> -                /* power domains of the SoC */
> -                power-domain@MT8173_POWER_DOMAIN_VDEC {
> -                    reg = <MT8173_POWER_DOMAIN_VDEC>;
> -                    clocks = <&topckgen CLK_TOP_MM_SEL>;
> -                    clock-names = "mm";
> -                    #power-domain-cells = <0>;
> -                };
> -                power-domain@MT8173_POWER_DOMAIN_VENC {
> -                    reg = <MT8173_POWER_DOMAIN_VENC>;
> -                    clocks = <&topckgen CLK_TOP_MM_SEL>,
> -                             <&topckgen CLK_TOP_VENC_SEL>;
> -                    clock-names = "mm", "venc";
> -                    #power-domain-cells = <0>;
> -                };
> -                power-domain@MT8173_POWER_DOMAIN_ISP {
> -                    reg = <MT8173_POWER_DOMAIN_ISP>;
> -                    clocks = <&topckgen CLK_TOP_MM_SEL>;
> -                    clock-names = "mm";
> -                    #power-domain-cells = <0>;
> -                };
> -                power-domain@MT8173_POWER_DOMAIN_MM {
> -                    reg = <MT8173_POWER_DOMAIN_MM>;
> -                    clocks = <&topckgen CLK_TOP_MM_SEL>;
> -                    clock-names = "mm";
> +                power-domain@MT8173_POWER_DOMAIN_MFG {
> +                    reg = <MT8173_POWER_DOMAIN_MFG>;
>                      #power-domain-cells = <0>;
>                      mediatek,infracfg = <&infracfg>;
>                  };
> -                power-domain@MT8173_POWER_DOMAIN_VENC_LT {
> -                    reg = <MT8173_POWER_DOMAIN_VENC_LT>;
> -                    clocks = <&topckgen CLK_TOP_MM_SEL>,
> -                             <&topckgen CLK_TOP_VENC_LT_SEL>;
> -                    clock-names = "mm", "venclt";
> -                    #power-domain-cells = <0>;
> -                };
> -                power-domain@MT8173_POWER_DOMAIN_AUDIO {
> -                    reg = <MT8173_POWER_DOMAIN_AUDIO>;
> -                    #power-domain-cells = <0>;
> -                };
> -                power-domain@MT8173_POWER_DOMAIN_USB {
> -                    reg = <MT8173_POWER_DOMAIN_USB>;
> -                    #power-domain-cells = <0>;
> -                };
> -                power-domain@MT8173_POWER_DOMAIN_MFG_ASYNC {
> -                    reg = <MT8173_POWER_DOMAIN_MFG_ASYNC>;
> -                    clocks = <&clk26m>;
> -                    clock-names = "mfg";
> -                    #address-cells = <1>;
> -                    #size-cells = <0>;
> -                    #power-domain-cells = <1>;
> -
> -                    power-domain@MT8173_POWER_DOMAIN_MFG_2D {
> -                        reg = <MT8173_POWER_DOMAIN_MFG_2D>;
> -                        #address-cells = <1>;
> -                        #size-cells = <0>;
> -                        #power-domain-cells = <1>;
> -
> -                        power-domain@MT8173_POWER_DOMAIN_MFG {
> -                            reg = <MT8173_POWER_DOMAIN_MFG>;
> -                            #power-domain-cells = <0>;
> -                            mediatek,infracfg = <&infracfg>;
> -                        };
> -                    };
> -                };
>              };
>          };
>      };
> -- 
> 2.35.1
> 
> 
