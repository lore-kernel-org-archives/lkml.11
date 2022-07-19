Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D5EC43334
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jul 2022 14:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237831AbiGSOFU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jul 2022 10:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237942AbiGSOEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:04:53 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAED52DD9;
        Tue, 19 Jul 2022 06:18:12 -0700 (PDT)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 4A6661FEF7;
        Tue, 19 Jul 2022 15:18:10 +0200 (CEST)
Date:   Tue, 19 Jul 2022 15:18:03 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 3/3] clk: qcom: lcc-ipq806x: convert to parent data
Message-ID: <20220719131803.v7bvnutput6dnott@SoMainline.org>
References: <20220708000338.26572-1-ansuelsmth@gmail.com>
 <20220708000338.26572-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708000338.26572-3-ansuelsmth@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-08 02:03:38, Christian Marangi wrote:
> Convert lcc-ipq806x driver to parent_data API.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> v5:
> - Fix the same compilation error (don't know what the hell happen
>   to my buildroot)
> v4:
> - Fix compilation error
> v3:
>  - Inline pxo pll4 parent
>  - Change .name from pxo to pxo_board
> 
>  drivers/clk/qcom/lcc-ipq806x.c | 77 ++++++++++++++++++----------------
>  1 file changed, 42 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/clk/qcom/lcc-ipq806x.c b/drivers/clk/qcom/lcc-ipq806x.c
> index ba90bebba597..72d6aea5be30 100644
> --- a/drivers/clk/qcom/lcc-ipq806x.c
> +++ b/drivers/clk/qcom/lcc-ipq806x.c
> @@ -34,7 +34,9 @@ static struct clk_pll pll4 = {
>  	.status_bit = 16,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "pll4",
> -		.parent_names = (const char *[]){ "pxo" },
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "pxo", .name = "pxo_board",
> +		},
>  		.num_parents = 1,
>  		.ops = &clk_pll_ops,
>  	},
> @@ -64,9 +66,9 @@ static const struct parent_map lcc_pxo_pll4_map[] = {
>  	{ P_PLL4, 2 }
>  };
>  
> -static const char * const lcc_pxo_pll4[] = {
> -	"pxo",
> -	"pll4_vote",
> +static const struct clk_parent_data lcc_pxo_pll4[] = {
> +	{ .fw_name = "pxo", .name = "pxo" },
> +	{ .fw_name = "pll4_vote", .name = "pll4_vote" },
>  };
>  
>  static struct freq_tbl clk_tbl_aif_mi2s[] = {
> @@ -131,18 +133,14 @@ static struct clk_rcg mi2s_osr_src = {
>  		.enable_mask = BIT(9),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "mi2s_osr_src",
> -			.parent_names = lcc_pxo_pll4,
> -			.num_parents = 2,
> +			.parent_data = lcc_pxo_pll4,
> +			.num_parents = ARRAY_SIZE(lcc_pxo_pll4),

We've typically done the ARRAY_SIZE conversion in a separate patch, as
they're not related to "parent_data API", strictly speaking.
(Except in the lcc_mi2s_bit_div_codec_clk etc case below, which was
written inline previously).

- Marijn

[.. snip ..]
