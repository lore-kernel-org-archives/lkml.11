Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDAEC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Feb 2022 05:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237326AbiBWFIa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Feb 2022 00:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiBWFI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 00:08:27 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15474B1C5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 21:07:59 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 328CCDD;
        Wed, 23 Feb 2022 06:07:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1645592877;
        bh=kN0ZyoiXMV6L86XxzCtG8GG9/tq0A0jYC35yUuHrYpg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bD7ZBhUzEVTFSC9UurN3tBFuK/V2CrlB81b9dlbdrRkJa8+jXNsELI/EYUjbws6Ca
         beS3SQQIBx4nLEeXw8MP2ya6FLBFpyD7fvvOY6sNSdiL8nYSmRoFrgJn0BF7sSrRbr
         7zgeVkjgaG/01MZkw5VH4Z57Et1ihson0wpgRBw0=
Date:   Wed, 23 Feb 2022 07:07:47 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org,
        Brian Norris <briannorris@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Properly undo autosuspend
Message-ID: <YhXBIxbx63IXBU7L@pendragon.ideasonboard.com>
References: <20220222141838.1.If784ba19e875e8ded4ec4931601ce6d255845245@changeid>
 <CACRpkdbQ9U22afR74YiZs95qCm7dnLb2k4_nT3Le__hJPpDGUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACRpkdbQ9U22afR74YiZs95qCm7dnLb2k4_nT3Le__hJPpDGUw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 11:44:54PM +0100, Linus Walleij wrote:
> On Tue, Feb 22, 2022 at 11:19 PM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > The PM Runtime docs say:
> >   Drivers in ->remove() callback should undo the runtime PM changes done
> >   in ->probe(). Usually this means calling pm_runtime_disable(),
> >   pm_runtime_dont_use_autosuspend() etc.
> >
> > We weren't doing that for autosuspend. Let's do it.
> >
> > Fixes: 9bede63127c6 ("drm/bridge: ti-sn65dsi86: Use pm_runtime autosuspend")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> 
> Hm. I know a few places in drivers where I don't do this :/

It seems to be a very common problem indeed, I haven't seen any driver
yet that uses pm_runtime_dont_use_autosuspend(). We could play a game of
whack-a-mole, but we'll never win. Could this be solved in the runtime
PM framework instead ? pm_runtime_disable() could disable auto-suspend.
If there are legitimate use cases for disabling runtime PM temporarily
without disabling auto-suspend, then a new function designed
specifically for remove() that would take care of cleaning everything up
could be another option.

> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

-- 
Regards,

Laurent Pinchart
