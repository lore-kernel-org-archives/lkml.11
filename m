Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F03CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 18 May 2022 13:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238166AbiERNw6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 May 2022 09:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238182AbiERNw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:52:56 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901C41C6CBF
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:52:54 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id i27so3958421ejd.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ez+ANy+RKejIxGfGKCpQHExRQ8gPkVRdNNVMgRcAEvs=;
        b=l+B5/IQS1OJOGyccBY+I+FFBICuXQ8yUtCmCCF2WEyxnm6nWdLG8Gt5bvVLQpbVJFC
         K+cw9GJWrDbztXJFqHpYaOEBIbUH3FObZR0D/91fWkPjNVPsiOkjFfngH/BNLi30DudR
         qDb63Cg0rwBwB37UWAF3UdNK2phTKwO6T+Luc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ez+ANy+RKejIxGfGKCpQHExRQ8gPkVRdNNVMgRcAEvs=;
        b=HcQwQM5WANZtYAJZwyhhT9LTC+RGRt02mboovvnFmnQ3/dzAvhcT2QQY3M5eWpdwqw
         SfCG/uUevRz4mLaMzKqVFdJVlbBH0h7D0yf7G3HYeSRbeAahc2iwztTHxHKBpQnUPRZ0
         5QOegGgYBhi8EKjRT5gG9ufpxmEPyOWcjr4nJuNaTloxSEskxV90q5ZscE2iRkoKra8i
         D/w9Mpeshit+p4uCsop6zrmgMxaJyxc5mVrXiOO7LPMgHDlGPdeGHALpqJTmUVpAJwtZ
         72WMvV7F0U9Yeke+bG7bbDU5Ky7IwkpEQJ5irYuGbokVG50Va2zkWUbdEAejdOCHkkmj
         qyLg==
X-Gm-Message-State: AOAM533tTpnmlPcMBBJ4/NGmj1wE5I87nosVVBjBh8HYa5hJduGIzhFg
        BT8lKFTMhiLjo8ZQ2LUjjRpfJiX+Aft2PLEKuwY=
X-Google-Smtp-Source: ABdhPJzQp3gyG83SDl8mgnxAgYj93aPl1bFKd6qq9BWeRr4orXnz+FLbBBfp7RCyEh9xNj2R0E28sg==
X-Received: by 2002:a17:907:6297:b0:6da:6388:dc58 with SMTP id nd23-20020a170907629700b006da6388dc58mr24869390ejc.472.1652881972910;
        Wed, 18 May 2022 06:52:52 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id 12-20020a170906014c00b006f4c24495e7sm1008330ejh.33.2022.05.18.06.52.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 06:52:50 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id h5so1688843wrb.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:52:50 -0700 (PDT)
X-Received: by 2002:a05:6000:1c03:b0:20e:5cac:1eb5 with SMTP id
 ba3-20020a0560001c0300b0020e5cac1eb5mr5326338wrb.422.1652881969929; Wed, 18
 May 2022 06:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220510154406.v5.1.Id769ddc5dbf570ccb511db96da59f97d08f75a9c@changeid>
 <20220510154406.v5.3.I0977b1a08830d0caa8bfb1bdedb4ecceac709a7f@changeid>
In-Reply-To: <20220510154406.v5.3.I0977b1a08830d0caa8bfb1bdedb4ecceac709a7f@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 18 May 2022 06:52:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X4wekMgpT-o6Oy4_1n1YssJbUgyyeBxiHSk334UKqYyQ@mail.gmail.com>
Message-ID: <CAD=FV=X4wekMgpT-o6Oy4_1n1YssJbUgyyeBxiHSk334UKqYyQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] arm64: dts: qcom: sc7180: Add quackingstick dts files
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

On Tue, May 10, 2022 at 3:46 PM Joseph S. Barrera III
<joebar@chromium.org> wrote:
>
> Quackingstick is a trogdor-based board. These dts files are copies from
> the downstream Chrome OS 5.4 kernel, but with downstream bits removed.
>
> Signed-off-by: Joseph S. Barrera III <joebar@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> ---
>
> Changes in v5:
> - Removed extra newline
> - Added comment that compatible will be filled in per-board
>
> Changes in v4:
> - Added missing version history
>
> Changes in v3:
> - First inclusion in this series
>
>  arch/arm64/boot/dts/qcom/Makefile             |   2 +
>  .../sc7180-trogdor-quackingstick-r0-lte.dts   |  38 ++
>  .../qcom/sc7180-trogdor-quackingstick-r0.dts  |  26 ++
>  .../qcom/sc7180-trogdor-quackingstick.dtsi    | 324 ++++++++++++++++++
>  4 files changed, 390 insertions(+)

Just so it doesn't get lost, I saw another downstream change fly by.
Since you already have to spin for v6, you should incorporate that
too:

https://crrev.com/c/3652958

-Doug
