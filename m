Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00115C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Apr 2022 19:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbiDVTGz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Apr 2022 15:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiDVTG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 15:06:29 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309BC184F05
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 11:55:37 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id y27-20020a4a9c1b000000b0032129651bb0so1570563ooj.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 11:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=OzJwbTlQ5CJq/RrC/jGJQpBejYRhRViMdibg0uOTI3E=;
        b=mTHk9DTfYvsaJW3PRKyUsqoHdHZD4IP6/MrS4TPvAs8Hk/8KxfkDCQW4MVG51y5ZTv
         9MKmLP+X7+XkN1eBTusqAiLA+vBjALdK9n1uTzxp9aC8stEiZofN7Kyn0TxUCIVHsN4U
         VmZRZFdWSCrUHgAy+XmlECriJewFQCzWvxZHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=OzJwbTlQ5CJq/RrC/jGJQpBejYRhRViMdibg0uOTI3E=;
        b=3vDLoJRUlwhxVgxenR8pcOzoRRIlk7As82U1Zw2k9Zhobsn4baQaEcrMqUq02LRvjF
         GVJIaTE98VI8oNXO0IqJ0n9ThVTD0XBm0rO7Br+DTW7zStFoqBxoHPj3kHwA6i14sS6q
         rBtzh8YnHMJl5o0b2Bg1Ktr8rDlIh/OBJ/N6TX/u8He/0dWRqnPNSc4kLIi7WcSfDLVH
         LXKsQHby5wyDsMbe9hodAL+gzQgYzne+XwwAAwcnHtD1wTL6LZGSneDR4gERjSqxB3rV
         dqtB73+W1BnapgbR971ZTut7YBFwJc6EKYSYMA/3h8ChkojuCh+fOj8UALkYs2Nvc6Ip
         1Y7Q==
X-Gm-Message-State: AOAM533cNo/fQjHbhX2wIvq8wgRs0NZ7dUDAKxn2KqqRX8Tgkdoxl0lz
        HT+NcKFtEjxBJlU4NazibF/H6BkYDglN7C7oGwqhag==
X-Google-Smtp-Source: ABdhPJxybbIi1hEyAcfi/V3yEnSJipqITB3vlp/TaI8mUT8lmjCW3COZdZf3uW0sjb9k7ZQrODc2JlVXEK2EZJ8H9gw=
X-Received: by 2002:a4a:6f49:0:b0:35e:1902:1d3b with SMTP id
 i9-20020a4a6f49000000b0035e19021d3bmr1514867oof.1.1650653687684; Fri, 22 Apr
 2022 11:54:47 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 22 Apr 2022 11:54:47 -0700
MIME-Version: 1.0
In-Reply-To: <1650621734-10297-1-git-send-email-quic_srivasam@quicinc.com>
References: <1650621734-10297-1-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 22 Apr 2022 11:54:47 -0700
Message-ID: <CAE-0n520B-+QK9vxWQdRV3ChMEN1mD3fBSEY+YG9N4EvGc9wwQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280-qcard: Add ldo_l17b regulator node
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, dianders@chromium.org,
        judyhsiao@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rjendra@quicinc.com,
        quic_rohkumar@quicinc.com, robh+dt@kernel.org,
        srinivas.kandagatla@linaro.org
Cc:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2022-04-22 03:02:14)
> Add pm7325 ldo_l17b regulator, which is required for
> wcd codec vdd buck supply on sc7280-qcard board.
>
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
