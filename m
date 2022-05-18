Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57086C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 May 2022 04:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiEREcf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 May 2022 00:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiEREcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 00:32:10 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7850CD0;
        Tue, 17 May 2022 21:32:07 -0700 (PDT)
X-UUID: f93d8a7ec43a430d9e92ab4a41ceb90c-20220518
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:1a3431a6-9d98-4d9c-ad33-682530c15756,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:25
X-CID-META: VersionHash:2a19b09,CLOUDID:f6ad95e2-edbf-4bd4-8a34-dfc5f7bb086d,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:3,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: f93d8a7ec43a430d9e92ab4a41ceb90c-20220518
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1251744058; Wed, 18 May 2022 12:31:59 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 18 May 2022 12:31:57 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 18 May 2022 12:31:57 +0800
Message-ID: <8edc3b72195ecf82369a6c040c70e5b97e7c718a.camel@mediatek.com>
Subject: Re: [PATCH v6 3/4] drm/mediatek: Add mt8186 dsi compatible to
 mtk_dsi.c
From:   CK Hu <ck.hu@mediatek.com>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <chunkuang.hu@kernel.org>,
        <p.zabel@pengutronix.de>
CC:     <devicetree@vger.kernel.org>, <jitao.shi@mediatek.com>,
        <xinlei.lee@mediatek.com>, <airlied@linux.ie>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 18 May 2022 12:31:57 +0800
In-Reply-To: <20220504091923.2219-4-rex-bc.chen@mediatek.com>
References: <20220504091923.2219-1-rex-bc.chen@mediatek.com>
         <20220504091923.2219-4-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rex:

On Wed, 2022-05-04 at 17:19 +0800, Rex-BC Chen wrote:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Add the compatible because use different cmdq addresses in mt8186.

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> 
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> Reviewed-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c
> b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index ccb0511b9cd5..b13fd0317e96 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -1155,6 +1155,12 @@ static const struct mtk_dsi_driver_data
> mt8183_dsi_driver_data = {
>  	.has_size_ctl = true,
>  };
>  
> +static const struct mtk_dsi_driver_data mt8186_dsi_driver_data = {
> +	.reg_cmdq_off = 0xd00,
> +	.has_shadow_ctl = true,
> +	.has_size_ctl = true,
> +};
> +
>  static const struct of_device_id mtk_dsi_of_match[] = {
>  	{ .compatible = "mediatek,mt2701-dsi",
>  	  .data = &mt2701_dsi_driver_data },
> @@ -1162,6 +1168,8 @@ static const struct of_device_id
> mtk_dsi_of_match[] = {
>  	  .data = &mt8173_dsi_driver_data },
>  	{ .compatible = "mediatek,mt8183-dsi",
>  	  .data = &mt8183_dsi_driver_data },
> +	{ .compatible = "mediatek,mt8186-dsi",
> +	  .data = &mt8186_dsi_driver_data },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, mtk_dsi_of_match);

