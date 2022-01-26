Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53671C2BA4C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jan 2022 07:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237667AbiAZHOA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jan 2022 02:14:00 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:56140 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237647AbiAZHNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 02:13:54 -0500
X-UUID: bad8563046744e228b1242b46bfb9402-20220126
X-UUID: bad8563046744e228b1242b46bfb9402-20220126
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1344257898; Wed, 26 Jan 2022 15:13:51 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Jan 2022 15:13:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Jan 2022 15:13:49 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <wenst@chromium.org>
CC:     <chun-jie.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
Subject: Re: [PATCH 19/31] clk: mediatek: Add mtk_clk_simple_remove()
Date:   Wed, 26 Jan 2022 15:13:49 +0800
Message-ID: <20220126071349.1118-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220122091731.283592-20-wenst@chromium.org>
References: <20220122091731.283592-20-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In commit c58cd0e40ffa ("clk: mediatek: Add mtk_clk_simple_probe() to
> simplify clock providers"), a generic probe function was added to
> simplify clk drivers that only needed to support clk gates. However due
> to the lack of unregister APIs, a corresponding remove function was not
> added.
> 
> Now that the unregister APIs have been implemented, add aforementioned
> remove function to make it complete.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mtk.c | 15 +++++++++++++++
>  drivers/clk/mediatek/clk-mtk.h |  1 +
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
> index 2150ed8678e0..cd76e1d80242 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -369,6 +369,8 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
>  	if (r)
>  		goto free_data;
>  
> +	platform_set_drvdata(pdev, clk_data);
> +
>  	return r;
>  
>  free_data:
> @@ -376,4 +378,17 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
>  	return r;
>  }
>  
> +int mtk_clk_simple_remove(struct platform_device *pdev)
> +{
> +	const struct mtk_clk_desc *mcd = of_device_get_match_data(&pdev->dev);
> +	struct clk_onecell_data *clk_data = platform_get_drvdata(pdev);
> +	struct device_node *node = pdev->dev.of_node;
> +
> +	of_clk_del_provider(node);
> +	mtk_clk_unregister_gates(mcd->clks, mcd->num_clks, clk_data);
> +	mtk_free_clk_data(clk_data);
> +
> +	return 0;
> +}
> +
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
> index 3c3a934f53cd..4fa658f5d934 100644
> --- a/drivers/clk/mediatek/clk-mtk.h
> +++ b/drivers/clk/mediatek/clk-mtk.h
> @@ -202,5 +202,6 @@ struct mtk_clk_desc {
>  };
>  
>  int mtk_clk_simple_probe(struct platform_device *pdev);
> +int mtk_clk_simple_remove(struct platform_device *pdev);
>  
>  #endif /* __DRV_CLK_MTK_H */
> -- 
> 2.35.0.rc0.227.g00780c9af4-goog
> 

