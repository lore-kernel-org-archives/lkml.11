Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6DAC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 May 2022 18:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376645AbiEDS0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 May 2022 14:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377163AbiEDSZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:25:34 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C114653B5D
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 10:52:00 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id a21so2571690edb.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 10:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=stNpZhjIc0rYI9UDa/dYUY+xIJVUaddvmdhdaTGP+Hg=;
        b=AAXDrANDKO1uGISazEbDjdomKwAoiXe4Gf0d06N7eRs7Mz6+HySMa2m59aygu7wY1K
         OshCn5wqPPIx2L71WNiK6uIY+jNs+wk69cCXgGJk9NdybD7+AevrQ/U4PB1f9WASix5r
         4XbXskNBem/yi8dBdrlsUDvvTw9X1Dx6dC9Oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=stNpZhjIc0rYI9UDa/dYUY+xIJVUaddvmdhdaTGP+Hg=;
        b=ta8kI55HnzyHqaIvqJ+qClpobOCMcoRo2PCTAndBxyfFX14EtHZVtg2bp9ATUZ6h/6
         /dZVclwDDFL56tKBgWGjya1laFTUjeQ8dNmlyXA5D54qjZfsALwc2kFC/Ke0sudmTGZh
         CET1IlpemjSm7CQNPfs77D9aEVWyEyQWs/QXe0jWiLBEOsUx35oh8FyT4/A1UpiLzuUS
         UZP2plkF2BLBe471z2UMxW1ioK+d2sW640Oixe8I6xTWO6Ffuv4DuUAp7x/AxMPphw0W
         k3Q4oNyKXamcXN7CoCG7g6eZkiz28IxPUoOjUzKZsnAWgxaWwyAeCDN48Zh8QAnquvc3
         459g==
X-Gm-Message-State: AOAM531KrYQjwaabQpf8KItGpNFExjmgh8oLUP75dFMd/h3n6CI0Ahu1
        f+U0f46AJMSC2D92xk2ZVhHCTrZJtHD+y80ep0M=
X-Google-Smtp-Source: ABdhPJzqwdTzmOZkbiWlNrQoIEDtPGkC6WqO7YZ0CQO2sU6ijiLsCNtVGYBiNw+sPvQ8bVday9aWvw==
X-Received: by 2002:a50:ed0e:0:b0:425:e476:f4ed with SMTP id j14-20020a50ed0e000000b00425e476f4edmr24262591eds.32.1651686719143;
        Wed, 04 May 2022 10:51:59 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id jy13-20020a170907762d00b006f3ef214e1fsm5922830ejc.133.2022.05.04.10.51.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 10:51:58 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id v12so3015246wrv.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 10:51:58 -0700 (PDT)
X-Received: by 2002:a5d:42c8:0:b0:20a:d91f:87b5 with SMTP id
 t8-20020a5d42c8000000b0020ad91f87b5mr17565732wrr.301.1651686717659; Wed, 04
 May 2022 10:51:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220502173338.1.I26eca1856f99e6160d30de6d50ecab60e6226354@changeid>
 <165168485227.3730817.11549721304895378126.b4-ty@linaro.org>
In-Reply-To: <165168485227.3730817.11549721304895378126.b4-ty@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 4 May 2022 10:51:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WkJu8s5EmwJke49TPZ8CU8kD-CMcQi-9a3oUMqz9yBrQ@mail.gmail.com>
Message-ID: <CAD=FV=WkJu8s5EmwJke49TPZ8CU8kD-CMcQi-9a3oUMqz9yBrQ@mail.gmail.com>
Subject: Re: (subset) [PATCH] soc: qcom: socinfo: Add another ID for sc7180
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        matvore@chromium.org, Andy Gross <agross@kernel.org>,
        "Reviewed-by : Stephen Boyd" <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 4, 2022 at 10:21 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Mon, 2 May 2022 17:33:45 -0700, Douglas Anderson wrote:
> > It appears the some sc7180 devices, like the one in my
> > sc7180-trogdor-homestar, report an ID of 407 instead of 425. Add
> > another ID into the list.
> >
> >
>
> Applied, thanks!
>
> [1/1] soc: qcom: socinfo: Add another ID for sc7180
>       commit: c35886d605604e0b03cdd835ae3249dc1fe0cc2a

Hmm. Did you see the responses from Sai [1] about this? He seemed to
indicate that there might be some issue here because he thought 407
was supposed to be a different SoC. Are we sure we want to land this
patch while we're sorting it out?

[1] https://lore.kernel.org/r/13819b2d-26f0-14f4-9cb9-affb6b18f13d@quicinc.com/
