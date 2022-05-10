Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293F8C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 May 2022 17:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348369AbiEJRox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 May 2022 13:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348360AbiEJRot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:44:49 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D443212082
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:40:49 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id q8so19291051oif.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=UKufSQs9qr2bj9JxpR70M2MLmSNQQ67hZiGFvmJhYoc=;
        b=mdY/If8uRLEfI44R6YGWNOJxV4pcVZkV2cqgKl6mPn2qSRu9ZEv1lEWDIFC2daiykt
         2e1RiT9qD3sYV5V/WfZx0zxgjzmxv1dsDsRhjJ9fNdW9WfpT/PoLmKh1gugpSSvyB9OS
         r5ivIcCI5Z4QdKRZvhVb8GLWcVU4lgDzVyo9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=UKufSQs9qr2bj9JxpR70M2MLmSNQQ67hZiGFvmJhYoc=;
        b=Wu/U97UAd+4xzZEP+PoUIGb1Jkx9e6V7SQcYTDRo7S5a/3bjno/k5V2o8k6dazItsu
         sILw/4Pdpjra8wINYTSvsJvUpwiPmp4Mz8kRjTZ4e6kUyyQR6T2T9Va55YOIYPjUbFsB
         AgXk6XCUo1CwX6dhxQMLIWv0igg1iXAbHseSCjF5yYG9NjagN9cBOynPp0n6nOJzSo92
         4Gptfp6+EXG3WCz5IOjSxKL9h4OoyJaK6BDrze5DQLJG7EOSwiINvSdtHPicuiaqBy1C
         Gb9ybdiME29lP08aTworExCj1fTdayoOnraBs6rYQ0dztqhi8zU4EW8gRK77eL2Fatlf
         hSqw==
X-Gm-Message-State: AOAM532qSKkpOD8gRUZ0OI8Mm9jy/njLzTUnbS9djKq7HeNfyMcDwv9k
        25KbI80ujlFzN2NKJ0IUEaoZwr5oD3uwV+X96YDJxA==
X-Google-Smtp-Source: ABdhPJz95HjcXUXoUbA/7guupIrd/nNtcSppXPf36HaH/0UjgRjU1DiKnHjuUteekXQ3UkimNseRwGrch2RzwVkttFo=
X-Received: by 2002:a05:6808:14c2:b0:326:c129:d308 with SMTP id
 f2-20020a05680814c200b00326c129d308mr576354oiw.193.1652204449230; Tue, 10 May
 2022 10:40:49 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 May 2022 10:40:48 -0700
MIME-Version: 1.0
In-Reply-To: <20220505104024.v4.1.Id769ddc5dbf570ccb511db96da59f97d08f75a9c@changeid>
References: <20220505104024.v4.1.Id769ddc5dbf570ccb511db96da59f97d08f75a9c@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 10 May 2022 10:40:48 -0700
Message-ID: <CAE-0n511S7dNPetX0dHp2RSPUZQjwGtXM8nMTF0bf03JjbPwfg@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] arm64: dts: qcom: sc7180: Add wormdingler dts files
To:     "Joseph S. Barrera III" <joebar@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Joseph S. Barrera III (2022-05-05 10:41:12)
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
> new file mode 100644
> index 000000000000..e947e01d0b3b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
> @@ -0,0 +1,417 @@
[...]
> +
> +/* PINCTRL - board-specific pinctrl */
> +
> +&tlmm {
> +       gpio-line-names = "HUB_RST_L",
[...]
> +
> +       vdd_reset_1800: vdd-reset-1800 {
> +               pinmux {
> +                       pins = "gpio87";
> +                       function = "gpio";
> +               };
> +
> +               pinconf {
> +                       pins = "gpio87";
> +                       drive-strength = <2>;
> +                       bias-disable;
> +               };
> +       };
> +
> +       avdd_lcd_en: avdd-lcd-en {
> +               pinmux {
> +                       pins = "gpio88";
> +                       function = "gpio";
> +               };
> +
> +               pinconf {
> +                       pins = "gpio88";
> +                       drive-strength = <2>;
> +                       bias-disable;
> +               };
> +       };
> +
> +       avee_lcd_en: avee-lcd_en {

avee-lcd-en

No underscores in node names please.

> +               pinmux {
> +                       pins = "gpio21";
> +                       function = "gpio";
> +               };
> +
> +               pinconf {
> +                       pins = "gpio21";
> +                       drive-strength = <2>;
> +                       bias-disable;
> +               };
> +       };

Are these supposed to be sorted by node name? Or gpio number? Please do
one of those.

> +
> +       mipi_1800_en: mipi-1800-en {
> +               pinmux {
> +                       pins = "gpio86";
> +                       function = "gpio";
> +               };
> +
> +               pinconf {
> +                       pins = "gpio86";
> +                       drive-strength = <2>;
> +                       bias-disable;
> +               };
> +       };
> +};
