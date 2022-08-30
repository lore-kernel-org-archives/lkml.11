Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BF9ECAAD4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Aug 2022 08:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiH3IFN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Aug 2022 04:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbiH3IEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:04:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55635D4186;
        Tue, 30 Aug 2022 01:04:28 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 985836601E8E;
        Tue, 30 Aug 2022 09:04:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661846659;
        bh=GJTT/+oC84VOzmoCMWQbYo6gCKJxXUVb6WsZq7befSg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hY1arLLCHiudf/f8QWUU8Lj3X+uZ+7gf4C5dIzPmbYDSNd5XWXvzXQKRwA6SM9rAS
         J7yIFjkQv93hBk1BeI86Hf7WP2y5TyiJBFKD3jnmo6evTEKAAaDnyhDu+1CE83SauY
         arUn61LBtCFqlOVDQR/K0KglyQb2I28AP91KJ47DUUXgFT/45I32Kuefb+foFSQzQf
         lbEqHBDzYpU7ipvqmbTWnqCAdnRADHyBzjHhJA3dPRClMIIVnzJNIZab5pOwafkwl9
         GJJk0vRm+Wd+KbdxrTRAFZfcDbWMvSz1ZLLZivZmMXTTcFYBcwuJOACxRIuHiep4XL
         w5XPoJIYwil1A==
Message-ID: <c34ba319-ad62-5ec7-55c0-94027265e77e@collabora.com>
Date:   Tue, 30 Aug 2022 10:04:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] dt-bindings: mfd: Rename mediatek,mt8195-scpsys.yaml
Content-Language: en-US
To:     matthias.bgg@kernel.org, lee@kernel.org, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        mandyjh.liu@mediatek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <mbrugger@suse.com>
References: <20220825141656.15747-1-matthias.bgg@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220825141656.15747-1-matthias.bgg@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/08/22 16:16, matthias.bgg@kernel.org ha scritto:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> The file describes the scpsys node for all SoCs and not only the mt8195.
> Rename it to reflect this fact.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>

Makes sense to me... but you forgot to change the $id in the yaml file to
reflect the new name.

Please fix that, after which:
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   .../mfd/{mediatek,mt8195-scpsys.yaml => mediatek,scpsys.yaml}     | 0
>   1 file changed, 0 insertions(+), 0 deletions(-)
>   rename Documentation/devicetree/bindings/mfd/{mediatek,mt8195-scpsys.yaml => mediatek,scpsys.yaml} (100%)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml b/Documentation/devicetree/bindings/mfd/mediatek,scpsys.yaml
> similarity index 100%
> rename from Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
> rename to Documentation/devicetree/bindings/mfd/mediatek,scpsys.yaml
> 


