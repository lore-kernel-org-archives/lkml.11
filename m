Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BEAC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 May 2022 14:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348208AbiEQOBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 10:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243926AbiEQOBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:01:48 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E963C702
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:01:46 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id k16so10200936pff.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MYT6AoGjpjKPZE95kv4oaDF35B9E5NzFdrvZoyxWcfA=;
        b=h1qEseCrbWCj13XjC66q1TpmrQDsxSXfNGCvfk3f0yHCGxRlvkQo+FG5JqeH0W3WNV
         oqbfBYZplGBv5LWIVW8pynuaooMkDr1dshu0Td5haE8lk0E8KVd22UjjbPshRn8qDOyc
         ibV/i8A9SGqrXhoTxPMrgStxernfMqqJfe5L0A1ooekmAeqZzZXMBKaec1xYDeOB5btY
         SbldITFsqMnPUw9GkuT7uaZQsY+KvMAKzJV3tV8Z1m5vPLwYVGAOspxc2b4Yb082Z1Zg
         6P4+CfjPKz2vQ0XOKiCap262JZRqFPTnkFlHaZw/w+r9PV9hsqijym3LhHGcr8LxuDjP
         OTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MYT6AoGjpjKPZE95kv4oaDF35B9E5NzFdrvZoyxWcfA=;
        b=Rei/SLmPctXkSTH+V/uH7s+B0CazwVMb5W07vS8HMAbHohrq9k7xqYqzJXFwmz2LoZ
         bud32rhyzxQXStxT7xiW1aCNRSs7eGEqXiYUKAopAesaAiBheUJGdf+H3ftiqMlvCnRh
         WqZQrSmCN6GJrv6ViJGcwioMA085v+J6CupzR3Q2Tjf2jMBgmY3aNKDoIFubFUsfGyxW
         dRl2FF3wtJaTfwQyFV5mbvnKGVJemEif28OLL1FNPvXWmBESwnPjQKpbCpjRMEgARVHb
         4hQwXYobmx9M8vGxe70mw+vfnIvbxat34P4wKQc95v16ba5KS7VUZ3gHk1l3/VMxFhkm
         ldwQ==
X-Gm-Message-State: AOAM531w9VrOTs6wzwSx5EGcsRWYipEkUt+kJ2HNROd+Wy7OlC+2DM/g
        mJwKTvwG2PL4XUc8PGEaUvxpC7oAzc20H9V5VQMPaQ==
X-Google-Smtp-Source: ABdhPJxJJdV1gKFQTcRKSnGQ3y//p40QUYAHJFm/TBZOjXQB3WsSLQ1+IBIurA4uiIr+8zv3iOSg7rJj4y/374mFa5I=
X-Received: by 2002:a63:31d3:0:b0:3f5:d1f4:5f95 with SMTP id
 x202-20020a6331d3000000b003f5d1f45f95mr1754162pgx.178.1652796105800; Tue, 17
 May 2022 07:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <449e08ca791a3ca308de5477c1bdc1f6eb1b34e7.1652104211.git.geert+renesas@glider.be>
 <6ac50bba-e18f-0aeb-90a3-5e448328b22e@denx.de>
In-Reply-To: <6ac50bba-e18f-0aeb-90a3-5e448328b22e@denx.de>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 17 May 2022 16:01:34 +0200
Message-ID: <CAG3jFyvXbVCMqo=mjSd_jk2kCcg8fJe585E1b5P-tGb_y0aXVw@mail.gmail.com>
Subject: Re: [PATCH] drm: bridge: DRM_FSL_LDB should depend on ARCH_MXC
To:     Marek Vasut <marex@denx.de>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 May 2022 at 16:41, Marek Vasut <marex@denx.de> wrote:
>
> On 5/9/22 15:52, Geert Uytterhoeven wrote:
> > The Freescale i.MX8MP LDB bridge is only present on Freescale i.MX8MP
> > SoCs.  Hence add a dependency on ARCH_MXC, to prevent asking the user
> > about this driver when configuring a kernel without i.MX SoC support.
> >
> > Fixes: 463db5c2ed4aed01 ("drm: bridge: ldb: Implement simple Freescale i.MX8MP LDB bridge")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Reviewed-by: Marek Vasut <marex@denx.de>

Applied to drm-misc-next
