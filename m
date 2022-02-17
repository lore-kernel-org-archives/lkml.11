Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB58FC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Feb 2022 13:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240863AbiBQNUG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Feb 2022 08:20:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiBQNUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:20:05 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32422AE714
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 05:19:50 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id o2so9961845lfd.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 05:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0An669Iue0lct/PXwnrntLRE0hi1DPyhT87g1X3KepI=;
        b=MeViv4Q1sh3oA0phn3xCAfVPbUG8UGeCVCszFOJaVYPZ32sxEME6e/Dr4NIcz9yODs
         LpKlbrCOBLUVZI6Wp8wrIiVG7wQSGLWS6bd6RhwFn9/6cDa3pH600WFEDvZW5ZcE8EWS
         +L4ECNrLWk+ywa1FsfbHvuxngAm2eL/ZAvjcML8ymU0/rE9CbzsN9YgTM9b8H9ia4Kiy
         wiuuqavEDBNsc61UqaXfqIbnEKnArqbMhwOFST6Wlf69nu2qJvpzCQhdvEdZc/bnN6wi
         2++Uplfk9gZJ24pf+DIaY02fxBGOfjgwako9ozJWi/mmidUKL3z2xBlnPj2FyXtc65zi
         kM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0An669Iue0lct/PXwnrntLRE0hi1DPyhT87g1X3KepI=;
        b=gWcGdKKqulM3/F7SRroS2G67QV+bAMZGN+hBjd4aIMaQJBArAc4HhUWI6F2GQwTsRY
         XSEEJyWu00Fxtdxo/NkPyUzlFrd2xkl6RymzWOiKbDH2o31BPfM24vAAivsu5NN85wK7
         zCme61xgahqzZJjFK9qKG3rBHYOPiBPI+VH/34fHFSXRTnA75MdPPcdMh4wje37LWewm
         MlN9kgIbg824zNS5MSET9wo+K6lrJcsskkPTDM36Rx8fiOiaxHqjdCebVJQG0Kcb6GWf
         zz4OYNH5sUWItD6F5KbKsQ3mge9ZOE1R+J7S4/UT0FbJaigLmBZdBQX/PedPcpRxvW+o
         kTMg==
X-Gm-Message-State: AOAM530o8neghw9AXYWA/giAFdMkx5zgwOiFR/PuPxjbLgXlEqIu6ksR
        BabbIuTIfGBQcm5VfOos+Civ/UJO3OTbJCKaiJV4XA==
X-Google-Smtp-Source: ABdhPJyC1BtPjjGMsjBMSsnoUmb/BzUl4zPcvEnNASVBJEc5VAdCH14DKvRJidRbKEN9KVukLptHJz0vVA5Xa3s0wV8=
X-Received: by 2002:a05:6512:3604:b0:443:5d4b:3760 with SMTP id
 f4-20020a056512360400b004435d4b3760mr2013092lfs.358.1645103989132; Thu, 17
 Feb 2022 05:19:49 -0800 (PST)
MIME-Version: 1.0
References: <20220130210210.549877-1-daniel.lezcano@linaro.org> <20220130210210.549877-5-daniel.lezcano@linaro.org>
In-Reply-To: <20220130210210.549877-5-daniel.lezcano@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Feb 2022 14:19:13 +0100
Message-ID: <CAPDyKFpbMoqDLBqy4YaYxbLnT5X0yOg2ynKteeDM+4ff8jD0UA@mail.gmail.com>
Subject: Re: [PATCH v1 5/7] powercap/dtpm: Move the 'root' reset place
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, heiko@sntech.de, lukasz.luba@arm.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jan 2022 at 22:02, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> The 'root' node is checked everytime a dtpm node is destroyed.
>
> When we reach the end of the hierarchy destruction function, we can
> unconditionnaly set the 'root' node to NULL again.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/powercap/dtpm.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
> index d9d74f981118..ec931a06d90a 100644
> --- a/drivers/powercap/dtpm.c
> +++ b/drivers/powercap/dtpm.c
> @@ -184,9 +184,6 @@ int dtpm_release_zone(struct powercap_zone *pcz)
>         else
>                 kfree(dtpm);
>
> -       if (root == dtpm)
> -               root = NULL;
> -
>         return 0;
>  }
>
> @@ -656,6 +653,8 @@ void dtpm_destroy_hierarchy(void)
>
>         pct = NULL;
>
> +       root = NULL;
> +
>  out_unlock:
>         mutex_unlock(&dtpm_lock);
>  }
> --
> 2.25.1
>
