Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39183C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Apr 2022 18:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349148AbiDKSeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 14:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348874AbiDKSd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 14:33:59 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3312B132;
        Mon, 11 Apr 2022 11:31:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8FA24CE19E5;
        Mon, 11 Apr 2022 18:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA17C385A4;
        Mon, 11 Apr 2022 18:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649701900;
        bh=gf6psStw1GAOWRBXxHx1fc7I0v5BTAOUapSwAlu8h6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K3WOWpuNioT3TzpcMRDQSdZMJ5c92D+8/VFQX71ML0cqHb+Lj1kBRD3KD4+nqHCPQ
         c+1loD+UqTB+kja9pII1I8ZzSNkX0wxpD4dyIEea+v6GE/x5LpcCmCHRgGOCvtRjr5
         9mMxRwZqqP2Vv/42h7FPph8psR8ac8/s72WKU6bqm4cjFaoVME0/JBfg1nB3kHV7vD
         wa5tnh92Lcb/3l74vOLWDvaTObOvbirRK5LXIhOgc3Gus92zgDYCDDwsSnV/3g76GM
         +MeOPRiETT89wYw0r6MGtuN0EzdcU63tY89Fn3olX7jVdwUzWYDx82XpUY99kjqtjo
         yrtD52cD+VM6A==
Date:   Tue, 12 Apr 2022 00:01:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] clk: qcom: add sc8280xp GCC driver
Message-ID: <YlR0B8N443IQZFEN@matsya>
References: <20220408224321.627126-1-bjorn.andersson@linaro.org>
 <20220408224321.627126-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408224321.627126-2-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-04-22, 15:43, Bjorn Andersson wrote:

> +static struct clk_branch gcc_aggre_ufs_card_axi_hw_ctl_clk = {
> +	.halt_reg = 0x750cc,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.hwcg_reg = 0x750cc,
> +	.hwcg_bit = 1,
> +	.clkr = {
> +		.enable_reg = 0x750cc,
> +		.enable_mask = BIT(1),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_aggre_ufs_card_axi_hw_ctl_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gcc_ufs_card_axi_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops, /* XXX: clk_branch2_hw_ctl_ops */

I think comment should be removed (couple of them here)

> +static struct clk_branch gcc_gpu_memnoc_gfx_clk = {
> +	.halt_reg = 0x71010,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.hwcg_reg = 0x71010,
> +	.hwcg_bit = 1,
> +	.clkr = {
> +		.enable_reg = 0x71010,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_gpu_memnoc_gfx_clk",
> +//			.flags = CLK_DONT_HOLD_STATE,

This need to be removed/updated

-- 
~Vinod
