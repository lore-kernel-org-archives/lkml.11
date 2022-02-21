Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5BCC433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 12:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348893AbiBUMUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 07:20:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357609AbiBUMTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:19:22 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C0B24596;
        Mon, 21 Feb 2022 04:15:12 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id AFAFF482;
        Mon, 21 Feb 2022 13:15:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1645445710;
        bh=z2gP+YiY54A7p25XmMCHjyaR7eKgMyq0FafyUCX7pNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WB38vC51fJwzH/eXxAz406pecnSxPUyMgblwAOzG/kDqRXXrNP4S7+ihdfjEHOsZv
         GPa8AwhfxFP9vSzD3UUJ55fgkrHJ6hFYHhWm9nWkX8Z2q4d2jiKmC8ZM/gvqEvo9km
         gp/NOz2PCE765RbfDqNdoe3xMwolQhWZYnKXgUEQ=
Date:   Mon, 21 Feb 2022 14:15:01 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     =?utf-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        kieran.bingham+renesas@ideasonboard.com, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: rcar-du: switch to devm_drm_of_get_bridge
Message-ID: <YhOCRQhDClgsBAtV@pendragon.ideasonboard.com>
References: <20220221073757.12181-1-jose.exposito89@gmail.com>
 <20220221085619.bqyr2etq4xjjqa4p@houat>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220221085619.bqyr2etq4xjjqa4p@houat>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 09:56:19AM +0100, Maxime Ripard wrote:
> On Mon, Feb 21, 2022 at 08:37:57AM +0100, José Expósito wrote:
> > The function "drm_of_find_panel_or_bridge" has been deprecated in
> > favor of "devm_drm_of_get_bridge".
> > 
> > Switch to the new function and reduce boilerplate.
> > 
> > Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> > ---
> >  drivers/gpu/drm/rcar-du/rcar_lvds.c | 16 +++++-----------
> >  1 file changed, 5 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c b/drivers/gpu/drm/rcar-du/rcar_lvds.c
> > index 72a272cfc11e..99b0febc56d1 100644
> > --- a/drivers/gpu/drm/rcar-du/rcar_lvds.c
> > +++ b/drivers/gpu/drm/rcar-du/rcar_lvds.c
> > @@ -712,18 +712,12 @@ static int rcar_lvds_parse_dt(struct rcar_lvds *lvds)
> >  {
> >  	int ret;
> >  
> > -	ret = drm_of_find_panel_or_bridge(lvds->dev->of_node, 1, 0,
> > -					  &lvds->panel, &lvds->next_bridge);
> 
> I guess lvds->panel can be removed from the rcar_lvds struct as well?

It's used in rcar_lvds_get_lvds_mode() though, so this patch introduces
a regression.

-- 
Regards,

Laurent Pinchart
