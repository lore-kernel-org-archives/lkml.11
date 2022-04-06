Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20A2C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 17:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238624AbiDFRTS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 13:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238717AbiDFRSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:18:55 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995A7488BF5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 08:17:23 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id w127so2684434oig.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 08:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=5IGW36ATNTFuDtqtwEvQFDb2q7pmTzr4D9NnXRTD/xw=;
        b=KgFwjjlg0aWwCjBZFlRpCgjg7GZDYKuxr2Z+U7XA0a6fFd3pR/iGAhvG4TS/9klOZ2
         /L3AisgNvoo7ZzKMDuPy63d/Gmd0OJk0TiwZy3uZd0eCy3OsqNPLu4aBPdnw5jpxthV/
         DPkrfCtELKlXt8SwElUaVjpdAg42yJBoVRMvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=5IGW36ATNTFuDtqtwEvQFDb2q7pmTzr4D9NnXRTD/xw=;
        b=cw1CXl/0RHMm8ctnOJJWcWG1jehba88/PcpUUMLR49oiBzfTY5OY37zyaPZA5NuHLi
         ojMTPdq8bizDjncK6SblvY5EeMwhITPFlVYfp8X/XFwzDSDsZ7X268o1ajfEYXeShc5G
         hWr+uTgtDVbRfBA2g41qtYd3V1XUpwxdv917JVzpWlY2ZpGJqMIEkLUxxwzDg8xSr0x9
         0Gt3n1GPXTYVwvrHGjtTIaz3+1n5MRCqTbdA/3dGRtdfatu5Fzdk3cRnuyRTtnsk6kF3
         1apmT87UFR5yeRiIDLBZtThPBoqqW3zIe2EWovDqobCtlgUXkEhFXmGRQI1KTT7HTDAt
         I1mA==
X-Gm-Message-State: AOAM530sf5p+BDMOdtA2K9a5Da2eDYCeXlwsNaXtSlrDVZMIDV26YTq4
        co8KbPQ8kU0wD+6CIoPbug6KhoZsYI+M2KeyFtK0CsKxRMk=
X-Google-Smtp-Source: ABdhPJzZLs+ZKP2BdEfUxGDctInEKn3clfbk7tx1n9Ky2Ieb3JBTI5A6BXvZzDotTaj+FYuqbH3Rcb26fCvH2SVAm3M=
X-Received: by 2002:aca:a9c8:0:b0:2da:45b6:b796 with SMTP id
 s191-20020acaa9c8000000b002da45b6b796mr3603521oie.193.1649258241857; Wed, 06
 Apr 2022 08:17:21 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 6 Apr 2022 08:17:21 -0700
MIME-Version: 1.0
In-Reply-To: <20220406111101.27412-1-quic_mpubbise@quicinc.com>
References: <20220406111101.27412-1-quic_mpubbise@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 6 Apr 2022 08:17:21 -0700
Message-ID: <CAE-0n51vq_V85SKh+hN1Ueas9t1dV7ZFaFyQsG9vukRBAHUc5A@mail.gmail.com>
Subject: Re: [PATCH v11] arm64: dts: qcom: sc7280: Add WPSS remoteproc node
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_sibis@quicinc.com,
        kuabhs@chromium.org, quic_pillair@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Manikanta Pubbisetty (2022-04-06 04:11:01)
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index ecbf2b89d896..f61a3e15fa8b 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -547,3 +547,6 @@ sw_ctrl: sw-ctrl {
>         };
>  };
>
> +&remoteproc_wpss {
> +       status = "okay";
> +};

This should be before the PINCTRL section in this file. I believe after
the uart node.
