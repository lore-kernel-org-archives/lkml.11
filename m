Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197F6ECAAD6
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Aug 2022 18:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345001AbiHZStP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Aug 2022 14:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345318AbiHZSsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:48:31 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D440E9278
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 11:45:35 -0700 (PDT)
Received: from [192.168.1.101] (afbd60.neoplus.adsl.tpnet.pl [95.49.29.60])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id DFE813F677;
        Fri, 26 Aug 2022 20:45:33 +0200 (CEST)
Message-ID: <7276a824-4535-89bf-0eab-241d3f2d5527@somainline.org>
Date:   Fri, 26 Aug 2022 20:45:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] arm64: dts: qcom: sc7280-herobrine: Don't enable the USB
 2.0 port
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
References: <20220826084813.1.I8c9a771fcf4d1cfb6e8e0ef17a153143af9a644d@changeid>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220826084813.1.I8c9a771fcf4d1cfb6e8e0ef17a153143af9a644d@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.08.2022 17:48, Matthias Kaehlcke wrote:
> The USB 2.0 port of sc7280 is currently not used by any herobrine
> board. Delete the device tree entries that enable it.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
> I was also told that the 2.0 port is for the Embedded USB Debugger
> (EUD) only, but I'm not sure if that's true. From the Linux side
> it looks like a regular dwc3 controller.
> 
>  arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> index 3f8996c00b05..b2f0404d3f71 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> @@ -606,18 +606,6 @@ &usb_1_qmpphy {
>  	status = "okay";
>  };
>  
> -&usb_2 {
> -	status = "okay";
> -};
> -
> -&usb_2_dwc3 {
> -	dr_mode = "host";
> -};
> -
> -&usb_2_hsphy {
> -	status = "okay";
> -};
> -
>  /* PINCTRL - ADDITIONS TO NODES IN PARENT DEVICE TREE FILES */
>  
>  &dp_hot_plug_det {
