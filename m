Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C680C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Mar 2022 23:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243029AbiCaXb7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Mar 2022 19:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242948AbiCaXb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 19:31:56 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7897416CE65
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 16:30:08 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id e16so1790436lfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 16:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7juVurgjLt3GvUzI9U9c+xp5sahJ/Uk+aOlgugxy0EM=;
        b=RtJix/BsoQj0ELH2OMFl7dwsORWQLL0UBqSXWJr5KoYLICZZbVFRb/zdCkHwWWysN5
         3b5vtLz0FaF+JGho0PKGYaYoz18U0Fy53xtgtIwoMITco5McP4KTTF/FQkbhfbr91SR4
         pxJraAJYBLjynqhNcmQ0n9QTPBRiLktURUGCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7juVurgjLt3GvUzI9U9c+xp5sahJ/Uk+aOlgugxy0EM=;
        b=4J7ZVH9nF9hTBf2mP/3YizlVXuQO7oadCkP8+OutSs48DSoW6JRAhRO44vvp/gDBwQ
         Ex97swb++ua8AC97QLZu1J2mYo4JhOIvvz2A8+0CIOdoEp3f9L7RlSO4jOdI1sj5477d
         mMhPhVts3QL4E3gdTjmy8CQN3dyL88lJqn79sW8a2LvlY5aLmSq/y4z4jVI2mfbwp4/L
         PazuM3F1iyuMEjAHm2HszVa1wKS0XFgTVw2B9kB1A8p61TxEjmPy/yc3BN6zvMCKzaMW
         NqvTg8oYv4xf1cVGHXSTmal4F8MMv36pHypUWxOZ+6uLfkVBR+dgTFJRuV937PIx7aoa
         AQhg==
X-Gm-Message-State: AOAM533cC3iDqylK38SnEOvwUcnDmY9QWi2vximckPIGl3PJCt0JfDwU
        IDVK7HXKtXGMBpNGPkQqsSRueFVU8CKpQAAdFvY=
X-Google-Smtp-Source: ABdhPJynqZrSyKsK5laJpRuOcQX5iDukR6dmBXk9JBaHlbv3tpdDhrojZ82Yo5MDDBb/2H1fWoMaLg==
X-Received: by 2002:a05:6512:39c5:b0:44a:646c:48c6 with SMTP id k5-20020a05651239c500b0044a646c48c6mr11979129lfu.596.1648769406289;
        Thu, 31 Mar 2022 16:30:06 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id m22-20020a0565120a9600b0044a93d21093sm68748lfu.279.2022.03.31.16.30.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 16:30:05 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id w7so1860311lfd.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 16:30:05 -0700 (PDT)
X-Received: by 2002:adf:e7cd:0:b0:204:ba2:b106 with SMTP id
 e13-20020adfe7cd000000b002040ba2b106mr5551021wrn.679.1648768998053; Thu, 31
 Mar 2022 16:23:18 -0700 (PDT)
MIME-Version: 1.0
References: <1648656179-10347-1-git-send-email-quic_sbillaka@quicinc.com> <1648656179-10347-6-git-send-email-quic_sbillaka@quicinc.com>
In-Reply-To: <1648656179-10347-6-git-send-email-quic_sbillaka@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 31 Mar 2022 16:23:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wn-XypjRcw-D0VtBHZbuTz=RHiMq6RCHCa=CWmZM42nQ@mail.gmail.com>
Message-ID: <CAD=FV=Wn-XypjRcw-D0VtBHZbuTz=RHiMq6RCHCa=CWmZM42nQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] drm/msm/dp: prevent multiple votes for dp resources
To:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        quic_vproddut <quic_vproddut@quicinc.com>,
        quic_aravindh@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 30, 2022 at 9:04 AM Sankeerth Billakanti
<quic_sbillaka@quicinc.com> wrote:
>
> The aux_bus support with the dp_display driver will enable the dp
> resources during msm_dp_modeset_init. The host_init has to return early
> if the core is already initialized to prevent putting an additional vote
> for the dp controller resources.
>
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

I'm not a huge fan of this but I'll leave it up to Dmitry. In general
it feels like there should be _a_ place that enables these resources.
Checks like this make it feel like we just scattershot enabling
resources in a bunch of random places instead of coming up with the
design for enabling them in the right place.

In any case, if we do end up landing this patch, it sure feels like it
needs to move earlier in the patch series, right? This patch shouldn't
hurt even without the other patches in the series but if you apply the
earlier patches in the series without this one then you'll have a bug,
right? That means this needs to come earlier.

-Doug
