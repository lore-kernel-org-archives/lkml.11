Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47ADAC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jun 2022 21:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbiFHVPZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jun 2022 17:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236424AbiFHVNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 17:13:23 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1843FBBDB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 14:13:16 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-e5e433d66dso28804006fac.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 14:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=KJjsYc5Q+FB6nVGvxpVGic7XyzdqJCtqUxTU1078q0M=;
        b=Gc9L1/Mk7mWV/4QJF/gCpyklEm3nrwzE108+emduADQEs5E3Yfs7t1VmgeSm7ZtoDS
         X4ToRRe0h40UYzuAIXkCKg9zfmX2Yw5XBX2bOpNgglkLh+Q2hcCkAYWgRlCMdNmxJ3EL
         XhsDPen9KeraIcqoJgmxzfDsD93FEDV2a7wXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=KJjsYc5Q+FB6nVGvxpVGic7XyzdqJCtqUxTU1078q0M=;
        b=uBtkPHq2QlhWPAarSdZ1C96tGhlbm7c6YtvXPQLcYcSYTFLErzbHaR0hbp9EVSiBx5
         UFQ1b1nGmQe6nHlJgxESFKJCJJ4Xa6aSYvYaa8f/RDpE+tlQTb8glSfGcXOQvFBZayAE
         ZPM5CqyYO9etuv7+Nw+AFGstfY54q9svTlArCYzdaYjWRFQbfNeHc30Yxt3WloUeOQbR
         xQUreiMDY2v9Nvw0+PFEeXaDtIKk3Ufx1KwPfP8VXMkfnDb/krgYBGMiuoMDp87mEEeY
         pn1xTRNNFHi3lU3Qg/p3w/66BRqxrDvDVPdX4bEQpuJ1EDP3/YQ6VVA4I621Nz6NBga2
         qRHg==
X-Gm-Message-State: AOAM533DbP1sPZi3FTLIfl0Mt/bQ9/vRcgTlNcWEShyeQyePOMS5wogh
        naIMcsSOoVeexkyUKeqGuqXJQPG2RhpQm44q44/1Mg==
X-Google-Smtp-Source: ABdhPJwQzs1bZwvLnqYeliieUkYLdQdpx/nYITaJw1lWaOSE5I7YZuUPgGWLIW/4CNZXvEIeqxzv3HsRQyon2FoXQYk=
X-Received: by 2002:a05:6870:b381:b0:fe:2004:b3b5 with SMTP id
 w1-20020a056870b38100b000fe2004b3b5mr1792742oap.63.1654722796290; Wed, 08 Jun
 2022 14:13:16 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jun 2022 14:13:15 -0700
MIME-Version: 1.0
In-Reply-To: <20220608094816.2898692-6-hsinyi@chromium.org>
References: <20220608094816.2898692-1-hsinyi@chromium.org> <20220608094816.2898692-6-hsinyi@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 8 Jun 2022 14:13:15 -0700
Message-ID: <CAE-0n51EMagNGQL8JPZXG8rek-a7+730FtRdj7jkzce4PwUD2w@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] drm/panel: panel-simple: Implement
 .get_orientation callback
To:     Douglas Anderson <dianders@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hsin-Yi Wang (2022-06-08 02:48:13)
> To return the orientation property to drm/kms driver.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
