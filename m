Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B34C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jan 2022 01:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbiA0BKh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jan 2022 20:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbiA0BKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 20:10:32 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9C8C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 17:10:31 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 81DA9EE;
        Thu, 27 Jan 2022 02:10:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1643245828;
        bh=BPUcwthO7R4TX+y7PM6L06wt4SEiKj1uceVdIu2FkzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g//YgZq/hVPZQAL6ludO1xfEhlZg/zxbUz/ZQ1dN/ZfMWmpWGF+CsRJ7Ekc6sqX1o
         g90pOMzqNjYwvf/q21IwIYyntGklt84kICF/SqKHYyTwMOqTi2jdZQ7zw5Sad8fkZ7
         RtJvVVmmuy9YB1Qdnad1evVUeGSZTJ/fpFmhdMXc=
Date:   Thu, 27 Jan 2022 03:10:09 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Yongzhi Liu <lyz_cs@pku.edu.cn>
Cc:     a.hajda@samsung.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, jonas@kwiboo.se, jernej.skrabec@gmail.com,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge: Add missing pm_runtime_put_sync
Message-ID: <YfHw8WwDpnRXO07G@pendragon.ideasonboard.com>
References: <Ye21tlZKRRe2vUzR@pendragon.ideasonboard.com>
 <1643008835-73961-1-git-send-email-lyz_cs@pku.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1643008835-73961-1-git-send-email-lyz_cs@pku.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yongzhi,

Thank you for the patch.

On Sun, Jan 23, 2022 at 11:20:35PM -0800, Yongzhi Liu wrote:
> pm_runtime_get_sync() will increase the rumtime PM counter
> even when it returns an error. Thus a pairing decrement is needed
> to prevent refcount leak. Fix this by replacing this API with
> pm_runtime_resume_and_get(), which will not change the runtime
> PM counter on error. Besides, a matching decrement is needed
> on the error handling path to keep the counter balanced.
> 
> Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/nwl-dsi.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
> index 9282e61..30aacd9 100644
> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> @@ -862,18 +862,19 @@ nwl_dsi_bridge_mode_set(struct drm_bridge *bridge,
>  	memcpy(&dsi->mode, adjusted_mode, sizeof(dsi->mode));
>  	drm_mode_debug_printmodeline(adjusted_mode);
>  
> -	pm_runtime_get_sync(dev);
> +	if (pm_runtime_resume_and_get(dev) < 0)
> +		return;
>  
>  	if (clk_prepare_enable(dsi->lcdif_clk) < 0)
> -		return;
> +		goto runtime_put;
>  	if (clk_prepare_enable(dsi->core_clk) < 0)
> -		return;
> +		goto runtime_put;
>  
>  	/* Step 1 from DSI reset-out instructions */
>  	ret = reset_control_deassert(dsi->rst_pclk);
>  	if (ret < 0) {
>  		DRM_DEV_ERROR(dev, "Failed to deassert PCLK: %d\n", ret);
> -		return;
> +		goto runtime_put;
>  	}
>  
>  	/* Step 2 from DSI reset-out instructions */
> @@ -883,13 +884,18 @@ nwl_dsi_bridge_mode_set(struct drm_bridge *bridge,
>  	ret = reset_control_deassert(dsi->rst_esc);
>  	if (ret < 0) {
>  		DRM_DEV_ERROR(dev, "Failed to deassert ESC: %d\n", ret);
> -		return;
> +		goto runtime_put;
>  	}
>  	ret = reset_control_deassert(dsi->rst_byte);
>  	if (ret < 0) {
>  		DRM_DEV_ERROR(dev, "Failed to deassert BYTE: %d\n", ret);
> -		return;
> +		goto runtime_put;
>  	}
> +
> +	return;
> +
> +runtime_put:
> +	pm_runtime_put_sync(dev);
>  }
>  
>  static void

-- 
Regards,

Laurent Pinchart
