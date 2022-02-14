Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B11C4332F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 10:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiBNKmM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 05:42:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348882AbiBNKji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 05:39:38 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61DEA9965;
        Mon, 14 Feb 2022 02:04:01 -0800 (PST)
Date:   Mon, 14 Feb 2022 10:03:01 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 06/23] drm/ingenic: Make use of the helper
 component_compare_of
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        James Wang <james.qian.wang@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        iommu@lists.linux-foundation.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>, srv_heupstream@mediatek.com,
        Rob Clark <robdclark@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, linux-mips@vger.kernel.org
Message-Id: <19HA7R.NEIIBC5SNORY1@crapouillou.net>
In-Reply-To: <20220214060819.7334-7-yong.wu@mediatek.com>
References: <20220214060819.7334-1-yong.wu@mediatek.com>
        <20220214060819.7334-7-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le lun., févr. 14 2022 at 14:08:02 +0800, Yong Wu 
<yong.wu@mediatek.com> a écrit :
> Use the common compare helper from component.
> 
> Cc: Paul Cercueil <paul@crapouillou.net>
> Cc: linux-mips@vger.kernel.org
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c 
> b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> index b4943a56be09..23b8f012b418 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> @@ -1322,11 +1322,6 @@ static int 
> ingenic_drm_bind_with_components(struct device *dev)
>  	return ingenic_drm_bind(dev, true);
>  }
> 
> -static int compare_of(struct device *dev, void *data)
> -{
> -	return dev->of_node == data;
> -}
> -
>  static void ingenic_drm_unbind(struct device *dev)
>  {
>  	struct ingenic_drm *priv = dev_get_drvdata(dev);
> @@ -1360,7 +1355,7 @@ static int ingenic_drm_probe(struct 
> platform_device *pdev)
>  	if (!np)
>  		return ingenic_drm_bind(dev, false);
> 
> -	drm_of_component_match_add(dev, &match, compare_of, np);
> +	drm_of_component_match_add(dev, &match, component_compare_of, np);
>  	of_node_put(np);
> 
>  	return component_master_add_with_match(dev, &ingenic_master_ops, 
> match);
> --
> 2.18.0
> 


