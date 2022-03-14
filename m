Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2E3C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 10:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238411AbiCNKMh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 06:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238417AbiCNKM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 06:12:28 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394BB3C486;
        Mon, 14 Mar 2022 03:11:18 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 570641F43E0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647252677;
        bh=bh/ot0gyUXjiizNGIRbwL29lZq8POFQ8narx72tYYBk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=n2Zp7NYnWcqXpGm/3VYq6d2gu9k/IgIQWVB1oDk18aQU/kEUpt3qPhZaS3ExQPCzG
         DRN60BMs1+boTWX4HgiGFDW+iIyHrhpJY2JUP5hrQ+ngco4pVDiEcv1UKwRS+kP/HU
         9RyAebdQ739o06kd3ykBbv7Ff4DGp7s769KKPlxaZbqKZEpKp/0KwPRN+VHR1zSH4a
         FV3nWTegQtNrHej2fH7oKeLFtvkvOUG07fSx8DpzZePyxjQ1jbhSmwHTRKkesiPMA5
         eRLILwkis4aHK+SSEtKKvUJY5WjgAvcBkQxvo/BRpAZI7uB2ugVvm7PBSEsM5goOUK
         PXThe59vLepmg==
Message-ID: <15fed391-a94f-aaca-906c-ffd96caead69@collabora.com>
Date:   Mon, 14 Mar 2022 11:11:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH V7 1/5] dt-bindings: display: mediatek: add aal binding
 for MT8183
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, chunkuang.hu@kernel.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        jassisinghbrar@gmail.com, fparent@baylibre.com,
        yongqiang.niu@mediatek.com, hsinyi@chromium.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220314090033.25773-1-rex-bc.chen@mediatek.com>
 <20220314090033.25773-2-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220314090033.25773-2-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/03/22 10:00, Rex-BC Chen ha scritto:
> Add aal binding for MT8183.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   .../devicetree/bindings/display/mediatek/mediatek,aal.yaml      | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
> index 61f0ed1e388f..6c8c83988a24 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
> @@ -23,6 +23,8 @@ properties:
>       oneOf:
>         - items:
>             - const: mediatek,mt8173-disp-aal
> +      - items:
> +          - const: mediatek,mt8183-disp-aal
>         - items:
>             - enum:
>                 - mediatek,mt2712-disp-aal


