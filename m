Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E723C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jun 2022 19:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243403AbiFETw1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jun 2022 15:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiFETwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 15:52:24 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038EAE032
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 12:52:23 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id q1so25312909ejz.9
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 12:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GC11sRAMV84GQweZr/T4nr/Uv9RvS1mCN24/5JobQVQ=;
        b=p8O5V9smB/8DJp9PUPDL216uqbHqB5nnGzb8A4iJZwvNZyKEFdLKb+U1bXnaO5yJCz
         7G6H45gFhZnfoKBIfHr5IC3XZF/z/yLdMWGjAnfp6Oxxkmzx9S6CGAETiAuvzJajMHxl
         OPjccKsR81usJYeKYiRMGIR8Kocz70X3ddn14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GC11sRAMV84GQweZr/T4nr/Uv9RvS1mCN24/5JobQVQ=;
        b=ht36zQ9Rfs5ZeKxOBFuLige/9+gNAsuO7kLVzDdEE/Vxh/rPLXbOheozVQqSHGlb/S
         S8WWYtzS3a6FOwZunV837Uqxhns+eh49Ahv0bXU4gvwM4DXxpIBgF4E4Pc14hyYHDHMl
         PFEZ8KUtMjpErNV0/HL31OJJ9g6aLvgPG5+f97gC1EOnmmRU4dcHnf7JCpqnF7mkbi+I
         glzk56k1V04EHRzuUdEMgZnMqYB6CGc1LJkHhJmz54SoGWKRYyZgImGxkDeAtryivMl8
         Xgde49YLeLA9q3h0Q/FTb/BqqQl3WrId+CAbXTCHzD701v/waxam7Qw/ZxkYkhy/1GxF
         w3aQ==
X-Gm-Message-State: AOAM532DGAJ8B44qhJtS16ljs7rR8kHHEg7UX/GTAkDt1ZID9awmj1gi
        vak/ZhqBv/LEwrwel2fwKSK8FA==
X-Google-Smtp-Source: ABdhPJxu7x/WVlwGxllTKrNw7LvGgPRtnkI3CZoj+i8lFDDyfzAQiqlNmWgEgtoCqH2BwHv9uwwvyg==
X-Received: by 2002:a17:907:60cf:b0:6ff:1ba7:aa26 with SMTP id hv15-20020a17090760cf00b006ff1ba7aa26mr18229565ejc.667.1654458741526;
        Sun, 05 Jun 2022 12:52:21 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-2-39-143-183.cust.vodafonedsl.it. [2.39.143.183])
        by smtp.gmail.com with ESMTPSA id kq15-20020a170906abcf00b0070cac22060esm3861892ejb.95.2022.06.05.12.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 12:52:20 -0700 (PDT)
Date:   Sun, 5 Jun 2022 21:52:18 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 3/3] arm64: defconfig: enable i.MX93 clk & pinctrl
Message-ID: <20220605195218.GA194223@tom-ThinkPad-T14s-Gen-2i>
References: <20220425110330.1630984-1-peng.fan@oss.nxp.com>
 <20220425110330.1630984-4-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425110330.1630984-4-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 07:03:30PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Enable i.MX93 clk and pinctrl driver for booting the system
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 6906b83f5e45..8205f9ffa200 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -525,6 +525,7 @@ CONFIG_PINCTRL_IMX8QM=y
>  CONFIG_PINCTRL_IMX8QXP=y
>  CONFIG_PINCTRL_IMX8DXL=y
>  CONFIG_PINCTRL_IMX8ULP=y
> +CONFIG_PINCTRL_IMX93=y
>  CONFIG_PINCTRL_MSM=y
>  CONFIG_PINCTRL_IPQ8074=y
>  CONFIG_PINCTRL_IPQ6018=y
> @@ -1017,6 +1018,7 @@ CONFIG_CLK_IMX8MP=y
>  CONFIG_CLK_IMX8MQ=y
>  CONFIG_CLK_IMX8QXP=y
>  CONFIG_CLK_IMX8ULP=y
> +CONFIG_CLK_IMX93=y
>  CONFIG_TI_SCI_CLK=y
>  CONFIG_COMMON_CLK_QCOM=y
>  CONFIG_QCOM_A53PLL=y
> -- 
> 2.25.1
> 

Hi Peng,
Looks good to me.

Reviewed-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>

Thanks,
Tommaso

-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
