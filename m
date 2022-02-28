Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFCDC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Feb 2022 19:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiB1Tvv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Feb 2022 14:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiB1Tvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 14:51:36 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7647210E552
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 11:49:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B8D51CE107E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 19:36:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7ECC340F6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 19:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646076999;
        bh=uQg4SANC0tJU01vBVn+TzxDgIh1ds1BGQLyvH74OLKI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ru9dbqGPywx4rU8bE2+ALmWNqKepMsAz+aIsY4z/xVDf19gnI7gBbxmQY5gpzLztD
         u/76HNcsnpdicFc4FWL1gyc7fQdqQNFeIkVh5vgzgd/q76fMCGklz10id4PLc6YuHC
         yRL3Y5gMvSGm466ekMyUf9XdZpfspZP6MolYzDiqnVhBDFPiu17n6J47JSyi6Te7lB
         9DRJNywzHl3YfI7X9e6zQsW29lwDxMbJ5J+6m4R5yLxbaRhgZ8M+95Rdy0yoCZpk6d
         UfYL3W6Exy/9h5Boyw7tkidqi1D+t8TbWZTCaHGl+p1NL7Y24mv9ve43L6bt+qie1Z
         fmYcGMwHznSjw==
Received: by mail-ej1-f48.google.com with SMTP id p15so26979983ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 11:36:38 -0800 (PST)
X-Gm-Message-State: AOAM532jI2z+pmxV9hpArY2IzL7cFMEgFCC/ek2luS6rSPx7d8o2XWIi
        A299/HGfx/xqXqih8jdQK7MPX2JjRijl1myV8g==
X-Google-Smtp-Source: ABdhPJwy5V0qZqdzoWekWLIQTK+ex/E6tQfwsl/Ul2TecipRpl9pTgZCDU6AkEbHUbR6Tb1Q5X7GWm2ya30cCXWXbkw=
X-Received: by 2002:a17:906:9913:b0:6d6:dc48:5d49 with SMTP id
 zl19-20020a170906991300b006d6dc485d49mr1820180ejb.325.1646076997213; Mon, 28
 Feb 2022 11:36:37 -0800 (PST)
MIME-Version: 1.0
References: <20220124162437.2470344-1-carsten.haitzler@foss.arm.com>
 <Ye/vEilz6j8gX3wu@e110455-lin.cambridge.arm.com> <20220223101851.46423dcf@donnerap.cambridge.arm.com>
In-Reply-To: <20220223101851.46423dcf@donnerap.cambridge.arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 28 Feb 2022 13:36:25 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL5REBih_Q+q==S_RhH90Ook0pPKhpcz4910h52-AFa+g@mail.gmail.com>
Message-ID: <CAL_JsqL5REBih_Q+q==S_RhH90Ook0pPKhpcz4910h52-AFa+g@mail.gmail.com>
Subject: Re: [PATCH] drm/arm: arm hdlcd select DRM_GEM_CMA_HELPER
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Liviu Dudau <liviu.dudau@arm.com>, carsten.haitzler@foss.arm.com,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Steven Price <steven.price@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 4:19 AM Andre Przywara <andre.przywara@arm.com> wrote:
>
> On Tue, 25 Jan 2022 12:37:38 +0000
> Liviu Dudau <liviu.dudau@arm.com> wrote:
>
> Hi,
>
> > On Mon, Jan 24, 2022 at 04:24:37PM +0000, carsten.haitzler@foss.arm.com wrote:
> > > From: Carsten Haitzler <carsten.haitzler@arm.com>
> > >
> > > Without DRM_GEM_CMA_HELPER HDLCD won't build. This needs to be there too.
> > >
> > > Fixes: 09717af7d13d ("drm: Remove CONFIG_DRM_KMS_CMA_HELPER option")
> > >
> > > Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
> >
> > Acked-by: Liviu Dudau <liviu.dudau@arm.com>
> >
> > I will add Steven's reviewed-by as well when pushing it.
>
> Did this go anywhere? I see my .config just selecting HDLCD still failing
> with -rc5. Any chance this can be taken now, as this is a regression
> introduced with -rc1?

I thought Liviu was going to, but in any case I've now pushed it to
drm-misc-fixes.

Rob
