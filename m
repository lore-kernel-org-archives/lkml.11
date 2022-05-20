Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9317BC4332F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 May 2022 19:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353368AbiETT6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 May 2022 15:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353361AbiETT6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 15:58:08 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545CC19C3A2
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 12:58:07 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id er5so12024811edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 12:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=91hRve8uPKHyD7cyqNThpoM05puNaYd3DvR3HzXYuko=;
        b=lpqvBoM6Gr/2Au3IjwUDRf3AW+vRv/AgjUKjUMpr2Tw/h+UWoftPNUSJ2yRY2vUkKR
         yJTMS6AqC12+s4S/tRChmy7WAqYdVjWFuZnKS4oknUkTe1hU6PWku2CFzVRkEtgOLWeo
         /48NID9BaVY3CXLyUDP/zbnXK78bYQY8hNCEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=91hRve8uPKHyD7cyqNThpoM05puNaYd3DvR3HzXYuko=;
        b=8KHbWEYXAQWIwuHJZ3H40GU4tlxwv74q8rpvmDXEp09GwbLeYen17loDVvoy3J3H2c
         +T2iYagLUHZpsUYeLyQAKgW9pPuijrkoU3dxn0VU0s34M3/1/frLN6gIdGWRbOU+3OTj
         L2KNxQ2zbEdk44ZBzJs6pjQ5q4yx8yhOH6jpWmCYfL0olDrHXNjyy5JLLHzb7rMW41lh
         z3qFhnL0eBDGXWjlu5ZZyryCxL8+ASlfOcRwRQDB2R/ZL+hgkfk8toiRwyGro3Uas7ip
         vuUPE+WJI1crL+xUoEuzKtYNW6l/89lb2bwUDSzT5dxhku6alLPRb6qYhq1xI879sCb3
         heZg==
X-Gm-Message-State: AOAM533n3PvG+lvb27n2MQ8WyVx7HH1S2I3i/sVzwJdu81uDTGMFzpzT
        g31yVsO3xngx/iXkB8S0OeN65FX9vLtKMglUG/g=
X-Google-Smtp-Source: ABdhPJwscdvZXT/kOrG6VO2xajpmQBysYA9hLwiitWBNV7uUnhdVVySKRZNVhjrgzjExB1Ga7ZkW2w==
X-Received: by 2002:a05:6402:331b:b0:42a:e899:29c4 with SMTP id e27-20020a056402331b00b0042ae89929c4mr12740282eda.139.1653076685632;
        Fri, 20 May 2022 12:58:05 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id v18-20020a056402349200b0042ac43be19dsm5086349edc.3.2022.05.20.12.58.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 12:58:04 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id p189so5070590wmp.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 12:58:03 -0700 (PDT)
X-Received: by 2002:a05:600c:acf:b0:397:345f:fe10 with SMTP id
 c15-20020a05600c0acf00b00397345ffe10mr6514763wmr.15.1653076683048; Fri, 20
 May 2022 12:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220520124834.1.I7c51c6255bb53086a82c5b3f4fafffcc5ccbc4ae@changeid>
In-Reply-To: <20220520124834.1.I7c51c6255bb53086a82c5b3f4fafffcc5ccbc4ae@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 20 May 2022 12:57:50 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X4GBLoTuOcHetAFXWLQKFF0yn=E5yv0ExTg8Mwrw1iUw@mail.gmail.com>
Message-ID: <CAD=FV=X4GBLoTuOcHetAFXWLQKFF0yn=E5yv0ExTg8Mwrw1iUw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Enable keyboard backlight for villager
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 20, 2022 at 12:48 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Villager has a backlit keyboard, enable support for the backlight.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
>  arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts | 8 ++++++++
>  arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi            | 2 +-
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts
> index d3d6ffad4eff..b6a6a1454883 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts
> @@ -58,6 +58,10 @@ &ap_sar_sensor1 {
>         status = "okay";
>  };
>
> +&keyboard_backlight {
> +       status = "okay";
> +};

Instead of doing this, can you just get rid of the status = "disabled"
in herobrine.dtsi? I don't think there's any benefit to having two
levels of "disabled" in the herobrine device tree.
