Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6ADC00140
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jul 2022 16:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239552AbiGZQuD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jul 2022 12:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbiGZQuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 12:50:01 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B610426ADF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 09:50:00 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id a9so10840761qtw.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 09:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4V8G4GMAGQ1xPvDjByOFORp35iePJWAOiQxIBrph8eA=;
        b=xXkF6ApYIQrUOAd5/80ZbtDhZ9O2vnQbr430frOix+I7sz9yyXY1bFQYXRuK/10x5s
         wysLxvE/P2hINv9ibo9AA3RFbPDnJ6tXL/NWTE4PZzN00x1aJWnsKFRrrU1o2SBslLVW
         ejU3bgRnfiA4nsgGy/pg6kPv07jsfav61gl50lCvJIzrLNvxgEks45x2wjnsV5aw9rEF
         TVa+LOyTHI5omK9m4+hraSOUwcoRP3uzjHd384miM/N8XLBgGNX6rWsBygjCCjhiUYNL
         npWggmd30TTPn9El5B5nzLQpHkNgPKVFClMeHIbNRj7d5/Mza0hB/RjINt7/Oy/doP8N
         spmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4V8G4GMAGQ1xPvDjByOFORp35iePJWAOiQxIBrph8eA=;
        b=ZvdzEdyFIQis3gvFtcF8AyI6TK5FR03QXIe/qVO2FO243YdlvxfaPtBYJl3CgSTj9X
         nszXlRMl38BEnTy1mKJxtjlFknAlK1qpYBim9M0r6A7ZPa25ILipMBpb5QbAV8D/s3pk
         /hS7dYBauI0oaJu9kLLm3JttkvRBjXYZxOidP02KUWptMW+oRWDlc+fI+N/v+Gm0Y+PI
         N+I1ItmbDHj/JxqFJdlnCB38SyBOAsdQjg74ApAFARDxaDDNSMOPM5XLVMlCEH4hR2z4
         naXQZgb59PI+E0WXi1cADDg0Pzl6Frsk8dnF9/HNi1hayt5xsd6sDCukY9+/mXlFTQKE
         Wd5w==
X-Gm-Message-State: AJIora8wOONUNjVR329PfIB5TS2kTB4hpn+EBI866V1J3AIpXCjidrPV
        mPV6ItpWR2l++nuFdF3hvA5+6txpyh3lLMyPDHwUyQ==
X-Google-Smtp-Source: AGRyM1tkfKbpdrlvcR1FzEgvY8vVTg/EQoBmZUKuLDzojspyZLarjSHE5qh/JxGDSovAP9259p2LgQ7MHaOPAlIcxpA=
X-Received: by 2002:a05:622a:178a:b0:31e:f9ff:c685 with SMTP id
 s10-20020a05622a178a00b0031ef9ffc685mr15660418qtk.62.1658854199911; Tue, 26
 Jul 2022 09:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220726150609.140472-1-krzysztof.kozlowski@linaro.org> <20220726150609.140472-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220726150609.140472-3-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 26 Jul 2022 19:49:49 +0300
Message-ID: <CAA8EJpp9D+RosfpOUJBq4geQARgSM-Q8Zma56LqbeOZmr_i1nQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] ARM: multi_v7_defconfig: enable more Qualcomm drivers
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2022 at 18:06, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Enable Qualcomm drivers:
> 1. Command DB (used in SDX55 and SDX65).
> 2. On Chip Memory - OCMEM (used in MSM8974)
> 3. RPMh and RPMh Power domain (used in SDX55 and SDX65).
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/configs/multi_v7_defconfig | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 5a5c772eedab..a23cdd352d23 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -1070,9 +1070,13 @@ CONFIG_ASPEED_LPC_CTRL=m
>  CONFIG_ASPEED_LPC_SNOOP=m
>  CONFIG_ASPEED_P2A_CTRL=m
>  CONFIG_RASPBERRYPI_POWER=y
> +CONFIG_QCOM_COMMAND_DB=m
>  CONFIG_QCOM_CPR=y
>  CONFIG_QCOM_GSBI=y
> +CONFIG_QCOM_OCMEM=m
>  CONFIG_QCOM_RMTFS_MEM=m
> +CONFIG_QCOM_RPMH=y
> +CONFIG_QCOM_RPMHPD=y
>  CONFIG_QCOM_RPMPD=y
>  CONFIG_QCOM_SMEM=y
>  CONFIG_QCOM_SMD_RPM=y

CONFIG_QOCM_STATS=m ?

> --
> 2.34.1
>


-- 
With best wishes
Dmitry
