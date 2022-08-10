Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B86DC25B07
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Aug 2022 02:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiHJCKc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Aug 2022 22:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiHJCK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 22:10:28 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9925D0EB
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 19:10:27 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id j66-20020a9d17c8000000b00636b0377a8cso8754898otj.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 19:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc;
        bh=jLuXr02/4FcnH6sSE/wa3hWFY34+NhWVn6axHTm9v/U=;
        b=SnnzWIIwqEobH0Hd3ElkxWCS38PwdORjOB/7trnM5hVytyfdptItihRxhMGoPP5fqe
         sKhDjKnAmbLJIES5S/ksPgr1XhXVLMEs5mTFcH8A4VgLJWI3ICoZdbpVobzoT2IOXJyU
         LK2WAGuvO87YkEAZsMlvKsPAZ7tuRLY3R30fc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc;
        bh=jLuXr02/4FcnH6sSE/wa3hWFY34+NhWVn6axHTm9v/U=;
        b=fMt3Gb1HNzTDZ0AKerIJaNIQjCj2X4hcAIBU9VieHmTHiCCZOjf3zBcFjq2GA8FuJG
         vazUnBVCMRyHMeXbvz+so717Q0ZLAwkIGesOJ7+14EOlZ2wWES4nDa+7V/83F07MhFGP
         5v6aS3SQelJVtT7NsPVo4aW4xhpFHL6EUQpOcrrjM2HjcAt9ex0YyUwtOs7S6VyyTvmd
         CPHtJmEN0U6FaunVjHxlBVLyAPGo4kQjYuX1eaVZROYyg7hTwvYbs9xVTvu7Ix6zliXf
         A0hnJX0j/S0GLcZmReA7+aJQGuI0J8ac0HKeT0xttAyr2PDIcBYP8uRA4ibnr/8KuxRZ
         69Cw==
X-Gm-Message-State: ACgBeo33+lKi+FpFkQLGRAdruYizdtq0paOo7PCxGFTyjbH2q0dvz1QM
        JCSHXSn4p7yuIQFN+pgZPdklKAmnn19AW57vi86azQ==
X-Google-Smtp-Source: AA6agR5OcLVB+7ZF57mi3MW+ZH7iZGc+sxaF/YsydE2T4hd6AePeikXS7eWcIyvhYpSWNwM09WrM0Xvr8aG+ebLGr54=
X-Received: by 2002:a05:6830:34a9:b0:637:eaf:573a with SMTP id
 c41-20020a05683034a900b006370eaf573amr1897387otu.3.1660097426801; Tue, 09 Aug
 2022 19:10:26 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Aug 2022 21:10:26 -0500
MIME-Version: 1.0
In-Reply-To: <1660077890-31622-1-git-send-email-quic_khsieh@quicinc.com>
References: <1660077890-31622-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 9 Aug 2022 21:10:26 -0500
Message-ID: <CAE-0n50e_rwTGwHyi=bajNCQ==h3ETO0iM1f75VpvoeLEpaZoA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: check hpd_state before push idle pattern at dp_bridge_disable()
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dianders@chromium.org, dmitry.baryshkov@linaro.org,
        robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-08-09 13:44:50)
> dp_bridge_disable() is the first step toward tearing down main link.
> Its major function is to start transmitting idle pattern to replace
> video stream. This patch will check hpd_state to make sure main link
> is enabled before commit changes of main link's configuration to
> push idle pattern out to avoid system crashing due to main link clock
> is disabled while access main link registers.
>
> Fixes: 13ea4799a81b ("drm/msm/dp: remove extra wrappers and public functions");

Does it really fix 375a126090b9 ("drm/msm/dp: tear down main link at
unplug handle immediately")? I don't see how removing extra wrappers
caused us to start trying to set the idle pattern when the device was
unclocked.
