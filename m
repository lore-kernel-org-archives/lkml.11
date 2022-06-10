Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDDCCCA47B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jun 2022 20:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350733AbiFJUya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jun 2022 16:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350238AbiFJUyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 16:54:25 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17F438183;
        Fri, 10 Jun 2022 13:54:18 -0700 (PDT)
Received: from g550jk.localnet (31-151-115-246.dynamic.upc.nl [31.151.115.246])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 4B063CD36E;
        Fri, 10 Jun 2022 20:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1654894455; bh=ReHCgRQiyBeVa6Oze6kiepfxtxodGrFLvPA/WtYpe1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=BJSI5fU7XXNKeWe9bTlCgtNZWjO4ITUpcZ9ehN+UyhX63nWSMQYjpjkmBXurQhQUn
         LkPUlviLAtXY4vDKGp3mEOk+RwwCr6cgx5xCy4+FBKZrqnXoBrcZH+qvF/pFCi3nqC
         S8tkC099CHtfixaka5Yu/qAFg+20uhJvRssyGAP4=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 05/14] ARM: dts: qcom: msm8974: add dedicated IMEM compatible
Date:   Fri, 10 Jun 2022 22:54:15 +0200
Message-ID: <5573836.DvuYhMxLoT@g550jk>
In-Reply-To: <20220607171848.535128-5-krzysztof.kozlowski@linaro.org>
References: <20220607171848.535128-1-krzysztof.kozlowski@linaro.org> <20220607171848.535128-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Dienstag, 7. Juni 2022 19:18:39 CEST Krzysztof Kozlowski wrote:
> syscon compatible must be preceded with a specific compatible, to
> accurately describe the device.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Luca Weiss <luca@z3ntu.xyz>

> ---
>  arch/arm/boot/dts/qcom-msm8974.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi
> b/arch/arm/boot/dts/qcom-msm8974.dtsi index 09b181bb5365..5e6b2ae72e62
> 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -1651,7 +1651,7 @@ smd-edge {
>  		};
> 
>  		imem: sram@fe805000 {
> -			compatible = "syscon", "simple-mfd";
> +			compatible = "qcom,msm8974-imem", "syscon", 
"simple-mfd";
>  			reg = <0xfe805000 0x1000>;
> 
>  			reboot-mode {




