Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B6FC32772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 13:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiHWNtW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 09:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239324AbiHWNrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 09:47:47 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4463320984C;
        Tue, 23 Aug 2022 03:52:34 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9E3BA440;
        Tue, 23 Aug 2022 12:40:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1661251254;
        bh=qtB/GHrhmBGbFTFOqU8r92UoGanWbvaJR09DP0TwpEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tS2Rs/F+MOfHTNWsI+H3m05aDeJAOtf8tSyFbGcMxlDkCQsCPLhe9L8m1+l+krphh
         JlthAFo+rUPhGU1YsAd/yehvqfSLWAh4rBTy2J6WB+Cf615tZMk5HlMmB7VHw4Rme+
         ogK54hF/L1LRWOeI4VuxuMQk4A33kWS6CnDFPN7o=
Date:   Tue, 23 Aug 2022 13:40:50 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: synopsys,dw-hdmi: drop ref from
 reg-io-width
Message-ID: <YwSusqWrapWASOSK@pendragon.ideasonboard.com>
References: <20220823101031.387082-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220823101031.387082-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thank you for the patch.

On Tue, Aug 23, 2022 at 01:10:31PM +0300, Krzysztof Kozlowski wrote:
> reg-io-width is a standard property, so no need for defining its type
> with $ref.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  .../devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml     | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml b/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml
> index b00246faea57..4b7e54a8f037 100644
> --- a/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml
> @@ -26,7 +26,6 @@ properties:
>    reg-io-width:
>      description:
>        Width (in bytes) of the registers specified by the reg property.
> -    $ref: /schemas/types.yaml#/definitions/uint32
>      enum: [1, 4]
>      default: 1
>  

-- 
Regards,

Laurent Pinchart
