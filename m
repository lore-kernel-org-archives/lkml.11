Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E41C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Jul 2022 13:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbiGFNYV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Jul 2022 09:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbiGFNYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:24:19 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [5.144.164.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498EC1A3A7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 06:24:18 -0700 (PDT)
Received: from [192.168.1.101] (abxi46.neoplus.adsl.tpnet.pl [83.9.2.46])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 28A183F69E;
        Wed,  6 Jul 2022 15:24:16 +0200 (CEST)
Message-ID: <ab0858b0-c508-185e-2c3a-8c7215d8da75@somainline.org>
Date:   Wed, 6 Jul 2022 15:24:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/5] ARM: dts: qcom: add pxo/cxo clock-output-names for
 ipq8064
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220705202837.667-1-ansuelsmth@gmail.com>
 <20220705202837.667-5-ansuelsmth@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220705202837.667-5-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.07.2022 22:28, Christian Marangi wrote:
> Drivers expect to call pxo/cxo_board clock as pxo/cxo.
> Use clock-output-names to set the correct naming for these fixed clock
> to save drivers that are migrating to parent_data and still use
> parent_names.
> 
For this you'd want to call them "cxo_board" and "pxo_board",
as that's what they were named because of their node names.

Konrad
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  arch/arm/boot/dts/qcom-ipq8064.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> index 1425a4e4283f..720e27e29627 100644
> --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> @@ -302,12 +302,14 @@ cxo_board: cxo_board {
>  			compatible = "fixed-clock";
>  			#clock-cells = <0>;
>  			clock-frequency = <25000000>;
> +			clock-output-names = "cxo";
>  		};
>  
>  		pxo_board: pxo_board {
>  			compatible = "fixed-clock";
>  			#clock-cells = <0>;
>  			clock-frequency = <25000000>;
> +			clock-output-names = "pxo";
>  		};
>  
>  		sleep_clk: sleep_clk {
