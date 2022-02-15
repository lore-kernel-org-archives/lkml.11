Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0CBC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 06:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbiBOG5Y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 01:57:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiBOG5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 01:57:22 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221B8656A;
        Mon, 14 Feb 2022 22:57:12 -0800 (PST)
X-UUID: 9544f8c0507647d390792cfc0b099226-20220215
X-UUID: 9544f8c0507647d390792cfc0b099226-20220215
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 926062451; Tue, 15 Feb 2022 14:57:09 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 15 Feb 2022 14:57:08 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Feb 2022 14:57:08 +0800
Message-ID: <73a6bfd04fb8e81e25e15ba686ba72a36d3899d2.camel@mediatek.com>
Subject: Re: [PATCH v3 20/31] clk: mediatek: mtk: Clean up included headers
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Miles Chen <miles.chen@mediatek.com>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Tue, 15 Feb 2022 14:57:08 +0800
In-Reply-To: <20220208124034.414635-21-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org>
         <20220208124034.414635-21-wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-02-08 at 20:40 +0800, Chen-Yu Tsai wrote:
> Some included headers aren't actually used anywhere, while other
> headers
> with the declaration of functions and structures aren't directly
> included.
> 
> Get rid of the unused ones, and add the ones that should be included
> directly.
> 
> On the header side, replace headers that are included purely for data
> structure definitions with forward declarations. This decreases the
> amount of preprocessing and compilation effort required for each
> inclusion.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>

Reviewed-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mtk.c | 13 ++++++-------
>  drivers/clk/mediatek/clk-mtk.h | 12 ++++++------
>  2 files changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mtk.c
> b/drivers/clk/mediatek/clk-mtk.c
> index f108786caeda..5618c84e4e08 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -4,17 +4,16 @@
>   * Author: James Liao <jamesjj.liao@mediatek.com>
>   */
>  
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> +#include <linux/bitops.h>
> +#include <linux/clk-provider.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> -#include <linux/slab.h>
> -#include <linux/delay.h>
> -#include <linux/clkdev.h>
> -#include <linux/module.h>
>  #include <linux/mfd/syscon.h>
> -#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
>  
>  #include "clk-mtk.h"
>  #include "clk-gate.h"
> diff --git a/drivers/clk/mediatek/clk-mtk.h
> b/drivers/clk/mediatek/clk-mtk.h
> index 4fa658f5d934..7f902581a115 100644
> --- a/drivers/clk/mediatek/clk-mtk.h
> +++ b/drivers/clk/mediatek/clk-mtk.h
> @@ -7,19 +7,19 @@
>  #ifndef __DRV_CLK_MTK_H
>  #define __DRV_CLK_MTK_H
>  
> -#include <linux/regmap.h>
> -#include <linux/bitops.h>
>  #include <linux/clk-provider.h>
> -#include <linux/platform_device.h>
> -
> -struct clk;
> -struct clk_onecell_data;
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
>  
>  #define MAX_MUX_GATE_BIT	31
>  #define INVALID_MUX_GATE_BIT	(MAX_MUX_GATE_BIT + 1)
>  
>  #define MHZ (1000 * 1000)
>  
> +struct platform_device;
> +
>  struct mtk_fixed_clk {
>  	int id;
>  	const char *name;

