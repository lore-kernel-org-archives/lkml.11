Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9604C4332F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 May 2022 17:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386616AbiEBRVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 May 2022 13:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386609AbiEBRVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 13:21:11 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8980AE7C
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 10:17:41 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id p4so17427307edx.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 10:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U6I8l2/ksiQd63xGl5KCPWmwyj9JWjRhGv3A0r30Lxs=;
        b=eTQFfROjG1qUk1tXr04rLGRtNfHRxSVeDMHEKcSFJsWB2lR87/reU6RgOyiv7E0qxt
         fUq+C3AJS8urPlLqMtWicVO+G9N1mRO6lsGXvu7mjehiG33ekyO0H9hzZBSmG8CoJ/H/
         xlGLQpdPwl7jKLkTG4yZ/QYEk11Z1W9wmbWRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U6I8l2/ksiQd63xGl5KCPWmwyj9JWjRhGv3A0r30Lxs=;
        b=Yr29hjb/uD6AJ+b4euaW2jLMBxACZmRNbXIt2VrwHfFoUKaTJkXiTyfjnxb6bkI1VI
         eB73F+wMDkqdZpeOSjPOW1mN4XdP4QoW3QTjgE6UepKkw4jGSA7iX1yeq2shqeIR56Ss
         M0wf9D/XFKWGCCiw+mOzsmpz6h4P507PbQYn4a+POP5yC19rEf2ncZNBWgal3YbUUlvu
         7kJ20Y80M6kpTofoXve5Q1xm7GmH8euEJThi+c81riXQNLoxDSbw64UvJt/MxMnBJLAK
         8GKBgFBTwvO3hFzHR4HSTv4qNEaL8nHC0iShiS/z2UhIq3IRkfvJHkKk8/OKJYZGm13Z
         bIhQ==
X-Gm-Message-State: AOAM531Xap8odoRU6JvRMOfsAU2Yu6PaeT35xgMefGzVgntQ//2wlbqI
        d2Mu3zSCezFEc89da/T5VTsBoazzrFo263Dc
X-Google-Smtp-Source: ABdhPJxSUoS8p/2gO+gHgXATI55+ws10xvA6wfsgiJzZstLUtIuZZRgC/kcvPV1qjCbTPTlSwCDsCg==
X-Received: by 2002:a05:6402:2999:b0:418:eb22:64f9 with SMTP id eq25-20020a056402299900b00418eb2264f9mr13968140edb.391.1651511860298;
        Mon, 02 May 2022 10:17:40 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id ci18-20020a170907267200b006e8c7f3992esm3756632ejc.2.2022.05.02.10.17.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 10:17:39 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id m62so8598831wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 10:17:38 -0700 (PDT)
X-Received: by 2002:a05:600c:3c99:b0:392:b49c:7b79 with SMTP id
 bg25-20020a05600c3c9900b00392b49c7b79mr89734wmb.199.1651511858472; Mon, 02
 May 2022 10:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220430011402.1.If7c3471db53bea55213f7bcf17e9043084d3ac0c@changeid>
 <20220430011402.2.Iac7ac752b18224ab1458a7681301d9b48cab25c4@changeid>
In-Reply-To: <20220430011402.2.Iac7ac752b18224ab1458a7681301d9b48cab25c4@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 2 May 2022 10:17:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XZsUkCMjV9bBweVOPgJBUi72hDXpiMcuQfi7ZcQ4xqtw@mail.gmail.com>
Message-ID: <CAD=FV=XZsUkCMjV9bBweVOPgJBUi72hDXpiMcuQfi7ZcQ4xqtw@mail.gmail.com>
Subject: Re: [PATCH 2/5] arm64: dts: qcom: sc7180: Add mrbland dts files
To:     "Joseph S. Barrera III" <joebar@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Apr 30, 2022 at 1:18 AM Joseph S. Barrera III
<joebar@chromium.org> wrote:
>
> Mrbland is a trogdor-based board. These dts files are copies from
> the downstream Chrome OS 5.4 kernel, but with downstream bits removed.
>
> Signed-off-by: Joseph S. Barrera III <joebar@chromium.org>
> ---
>
>  arch/arm64/boot/dts/qcom/Makefile             |   4 +
>  .../qcom/sc7180-trogdor-mrbland-rev0-auo.dts  |  22 ++
>  .../qcom/sc7180-trogdor-mrbland-rev0-boe.dts  |  22 ++
>  .../dts/qcom/sc7180-trogdor-mrbland-rev0.dtsi |  53 +++
>  .../qcom/sc7180-trogdor-mrbland-rev1-auo.dts  |  22 ++
>  .../qcom/sc7180-trogdor-mrbland-rev1-boe.dts  |  24 ++
>  .../boot/dts/qcom/sc7180-trogdor-mrbland.dtsi | 352 ++++++++++++++++++
>  7 files changed, 499 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
