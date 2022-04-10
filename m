Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFD6C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Apr 2022 15:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243442AbiDJPYi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Apr 2022 11:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiDJPYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 11:24:32 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4389F17078;
        Sun, 10 Apr 2022 08:22:22 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 969BF482;
        Sun, 10 Apr 2022 17:22:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1649604140;
        bh=jsKiMlFOrucR9xanWkR9gKDjay3Oi7MS53acaKyt+Co=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vc1+DgFpCjiNyA50WK+pmchFdih67+Fz0LOhiPin+LTjplmkYCoglIl4uqZzfMjnG
         eo9G+uOmrQySRsKgAYFAxEC3Xx4jTWrGOmCNT2ojg1z+HxviH1MayvaFNJYxEMWore
         k165tw/Ukx9I6smv9tzEKGhubLmz0tWi4lZkKWHw=
Date:   Sun, 10 Apr 2022 18:22:18 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm: rcar-du: Extend CMM HDSE documentation
Message-ID: <YlL2KuYPyByjtbsL@pendragon.ideasonboard.com>
References: <20220409185706.505319-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220409185706.505319-1-kieran.bingham+renesas@ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Sat, Apr 09, 2022 at 07:57:06PM +0100, Kieran Bingham wrote:
> When the CMM is enabled, the HDSE offset is further adjusted to
> compensate for consumed pixels.
> 
> Explain this further, with an extra comment at the point the offset is
> adjusted.
> 
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> index f361a604337f..23e1aedf8dc0 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> @@ -300,6 +300,11 @@ static void rcar_du_crtc_set_display_timing(struct rcar_du_crtc *rcrtc)
>  	     | DSMR_DIPM_DISP | DSMR_CSPM;
>  	rcar_du_crtc_write(rcrtc, DSMR, dsmr);
>  
> +	/*
> +	 * When the CMM is enabled, an additional offset of 25 pixels must be
> +	 * subtracted from the HDS (horizontal display start) and HDE
> +	 * (horizontal display end) registers.
> +	 */
>  	hdse_offset = 19;
>  	if (rcrtc->group->cmms_mask & BIT(rcrtc->index % 2))
>  		hdse_offset += 25;

-- 
Regards,

Laurent Pinchart
