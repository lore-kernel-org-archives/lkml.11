Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C3FC433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Mar 2022 22:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236736AbiCCWHE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Mar 2022 17:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbiCCWHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 17:07:00 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976AB169203
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 14:06:13 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id w3-20020a056830060300b005ad10e3becaso5825225oti.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 14:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=pdvZcd1dCzTos36AEvo2XuYW96g/JSyyd6Ju386HZBA=;
        b=GU/VicsmSZRw1d2LkDZ6wzydbTYT4L8dB1zCnJwjzA08Es/V8nusp7J1acftodaTq0
         5HH7HAouRm088ujftN55DNIdMBENIQKdJvGbxCq+X2n4YuPls/MdNaItK8W+zOfxKnv/
         O+Fxmy7cnSFBcug80vgAZtRq7kEgQVZE07yfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=pdvZcd1dCzTos36AEvo2XuYW96g/JSyyd6Ju386HZBA=;
        b=rHku/XHuCYwMQdM2KmAEP3j19Yv8Xe7KyMk6/wEyTulbwa76sI0iNZbmiD5oaHnjvK
         r13RuqDlRGWyi5LsBAwEpyZRva0i8RxwbIZ88JGaRWZamlLWPiCEnz5Vl0N6ymYI3YGv
         F1YZ83xFDC9Qm1pkEPzIFPqvQ+5+W0KcfEC8fMz/ST/6w7oQ2RMBPsRlzf0ZT42/labM
         bfion/4FtFlF1tMueBxREVO0SkUB7P/AO7N0CsJQxWevaTypFNAzryew2tz1QpnquO2u
         XW/tIY3WoKtj2U2PEfNm88BMNS9lTap8uB5cfZTohvJhQe2w6drlqPurLlUh5TUi0hvX
         wIbw==
X-Gm-Message-State: AOAM532Ifcpn6e4Q7iWYd2UNLaQpjCl0JEvgeiqw773+AIPchFEeSDG2
        soRLRpC+GoqHSrh4TmOMbZD64ZO0TVd5aid/unA4Gw==
X-Google-Smtp-Source: ABdhPJzIsZYjGMPB9mIKaz9We4al2KijnAO/aGSWVSgdvkGTTn/LV94gdLX1B1Wq6BQq3wFmiUQFljUdJvXq2KeLZYw=
X-Received: by 2002:a9d:22e9:0:b0:5ac:1754:342c with SMTP id
 y96-20020a9d22e9000000b005ac1754342cmr19987839ota.159.1646345172996; Thu, 03
 Mar 2022 14:06:12 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Mar 2022 14:06:12 -0800
MIME-Version: 1.0
In-Reply-To: <1646300401-9063-3-git-send-email-quic_vpolimer@quicinc.com>
References: <1646300401-9063-1-git-send-email-quic_vpolimer@quicinc.com> <1646300401-9063-3-git-send-email-quic_vpolimer@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 3 Mar 2022 14:06:12 -0800
Message-ID: <CAE-0n539U9OzNRoaAG28TG7UJBUdiBYdJ-PKzGyF++ihK0Xo1A@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] arm64/dts/qcom/sc7180: remove assigned-clock-rate
 property for mdp clk
To:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, quic_kalyant@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Polimera (2022-03-03 01:39:59)
> Kernel clock driver assumes that initial rate is the
> max rate for that clock and was not allowing it to scale
> beyond the assigned clock value.
>
> Drop the assigned clock rate property and vote on the mdp clock as per
> calculated value during the usecase.
>
> Fixes: a3db7ad1af("arm64: dts: qcom: sc7180: add display dt nodes")
> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
