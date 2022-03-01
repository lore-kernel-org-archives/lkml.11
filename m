Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3080C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Mar 2022 22:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237343AbiCAWZa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Mar 2022 17:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234492AbiCAWZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 17:25:27 -0500
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [5.144.164.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DF960CC9
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 14:24:44 -0800 (PST)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id DDF663F73D;
        Tue,  1 Mar 2022 23:24:41 +0100 (CET)
Date:   Tue, 1 Mar 2022 23:24:40 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: Drop bogus interrupt flags cell on
 MDSS nodes
Message-ID: <20220301222440.pn3uxnoata4jaq4z@SoMainline.org>
References: <20220301210531.1855709-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301210531.1855709-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2022-03-01 15:05:31, Rob Herring wrote:
> The MDSS interrupt provider is a single cell, so specifying interrupt flags
> on the consumers is incorrect.

There seem to be many more violators of `#interrupt-cells = <1>;`, at
least on -next e6ada6df471f.  It seems those are not intentionally
omitted in this patch?  Searching for `interrupt-parent = <&mdss>;`
globally and evaluating `interrupts =` right next to it yields:

- Two more hits in both sdm845.dtsi and sm8250.dtsi;
- qcom-msm8974.dtsi;
- msm8996.dtsi;
- sdm630.dtsi;
- sdm660.dtsi.

And for the docs patch:
- mdp5.txt;
- And the recently added dpu-qcm2290.yaml, whose CI failure might have
  exactly lead to this patch?

Would you mind cleaning these up in a v2, or otherwise explain and
forgive my ignorance for not seeing why these were not changed?

Thanks!

- Marijn

> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 41f4e46e1f85..a6bf04780667 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -4281,7 +4281,7 @@ mdss_mdp: mdp@ae01000 {
>  				power-domains = <&rpmhpd SDM845_CX>;
>  
>  				interrupt-parent = <&mdss>;
> -				interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupts = <0>;
>  
>  				ports {
>  					#address-cells = <1>;
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index fdaf303ba047..e732e3370c75 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -3200,7 +3200,7 @@ mdss_mdp: mdp@ae01000 {
>  				power-domains = <&rpmhpd SM8250_MMCX>;
>  
>  				interrupt-parent = <&mdss>;
> -				interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupts = <0>;
>  
>  				ports {
>  					#address-cells = <1>;
> -- 
> 2.32.0
> 
