Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B72C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 06:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbiBOGa4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 01:30:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbiBOGaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 01:30:55 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FAF11EF21;
        Mon, 14 Feb 2022 22:30:45 -0800 (PST)
X-UUID: fe1d889511ac493f862d67ca37580b87-20220215
X-UUID: fe1d889511ac493f862d67ca37580b87-20220215
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 10348682; Tue, 15 Feb 2022 14:30:44 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Feb 2022 14:30:42 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 15 Feb
 2022 14:30:42 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Feb 2022 14:30:42 +0800
Message-ID: <7a9f37bda4f187eb62674087abf807c5c27167aa.camel@mediatek.com>
Subject: Re: [PATCH v3 10/31] clk: mediatek: mux: Internalize struct
 mtk_clk_mux
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
Date:   Tue, 15 Feb 2022 14:30:42 +0800
In-Reply-To: <20220208124034.414635-11-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org>
         <20220208124034.414635-11-wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-02-08 at 20:40 +0800, Chen-Yu Tsai wrote:
> struct mtk_clk_mux is an implementation detail of the mux clk type,
> and is not used outside of the implementation.
> 
> Internalize the definition to minimize leakage of details and shrink
> the header file.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>

Reviewed-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mux.c | 8 ++++++++
>  drivers/clk/mediatek/clk-mux.h | 8 --------
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mux.c
> b/drivers/clk/mediatek/clk-mux.c
> index 6f0c22a699c3..2d4d8dc0120a 100644
> --- a/drivers/clk/mediatek/clk-mux.c
> +++ b/drivers/clk/mediatek/clk-mux.c
> @@ -13,6 +13,14 @@
>  #include "clk-mtk.h"
>  #include "clk-mux.h"
>  
> +struct mtk_clk_mux {
> +	struct clk_hw hw;
> +	struct regmap *regmap;
> +	const struct mtk_mux *data;
> +	spinlock_t *lock;
> +	bool reparent;
> +};
> +
>  static inline struct mtk_clk_mux *to_mtk_clk_mux(struct clk_hw *hw)
>  {
>  	return container_of(hw, struct mtk_clk_mux, hw);
> diff --git a/drivers/clk/mediatek/clk-mux.h
> b/drivers/clk/mediatek/clk-mux.h
> index cb2ac4f04c58..38a2b6014b08 100644
> --- a/drivers/clk/mediatek/clk-mux.h
> +++ b/drivers/clk/mediatek/clk-mux.h
> @@ -9,14 +9,6 @@
>  
>  #include <linux/clk-provider.h>
>  
> -struct mtk_clk_mux {
> -	struct clk_hw hw;
> -	struct regmap *regmap;
> -	const struct mtk_mux *data;
> -	spinlock_t *lock;
> -	bool reparent;
> -};
> -
>  struct mtk_mux {
>  	int id;
>  	const char *name;

