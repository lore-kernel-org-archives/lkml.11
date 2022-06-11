Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACEEC43334
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jun 2022 17:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238111AbiFKRMi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jun 2022 13:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238004AbiFKRMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 13:12:34 -0400
Received: from mailrelay2-1.pub.mailoutpod1-cph3.one.com (mailrelay2-1.pub.mailoutpod1-cph3.one.com [46.30.210.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB6C38A
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 10:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=8VcGizsapvboVcP1zo3t8VxEp/sSKU/KGufu1khKH6o=;
        b=A2wRRGJm1Dvqzp3wRD+S/rNCRrsrErVX0FjAVx1b5Ac3qvP9aFddXJjAUWE3Fnxz+PfHJ/yqPcorr
         kxK9ae79ZmxqRar/4qo13DZpgM4yIJaPwRdqpwc8lUBkgIfUXXkoFRqRQmTVyHdC7csX/DePHyFSHW
         66aUAeyCW4+Dl7S8MPlvoOpRcnUxrr5FUS7QStJSrjDsvgjMmDsprXQTphGT+PHSWVgb4LK/WhkbCf
         n06mxYRgZAiR+MNZROUeofaPHSbmfOAydPTbpd/TpQYgawN/UVqKXaoM5nabiFx0k7aA3tBAq/V1v5
         17iBZgSgYqmDPeNRYIWLEywb1y+eCrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=8VcGizsapvboVcP1zo3t8VxEp/sSKU/KGufu1khKH6o=;
        b=5IAb1CIcBziY4xbn1yKwpAEQP590Fwx9G74QT+/t4VuSVJBiFkamznak0BvExsLjxPd37010eTkxY
         QvULcsDBQ==
X-HalOne-Cookie: e063aac0e33e47e8e18a15f833bc9b5f259a959b
X-HalOne-ID: a9d70d84-e9a9-11ec-a912-d0431ea8a290
Received: from mailproxy2.cst.dirpod4-cph3.one.com (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id a9d70d84-e9a9-11ec-a912-d0431ea8a290;
        Sat, 11 Jun 2022 17:12:25 +0000 (UTC)
Date:   Sat, 11 Jun 2022 19:12:23 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     dri-devel@lists.freedesktop.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Kees Cook <keescook@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH] drm: Fix htmldocs indentation warning w/ DP AUX power
 requirements
Message-ID: <YqTM946ghjz+8CzJ@ravnborg.org>
References: <20220611095445.1.I534072d346b1ebbf0db565b714de9b65cbb24651@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220611095445.1.I534072d346b1ebbf0db565b714de9b65cbb24651@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2022 at 09:55:04AM -0700, Douglas Anderson wrote:
> Two blank lines are needed to make the rst valid.
> 
> Fixes: 69ef4a192bba ("drm: Document the power requirements for DP AUX transfers")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
> ---
> 
>  include/drm/display/drm_dp_helper.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
> index dc3c02225fcf..c5f8f45511ed 100644
> --- a/include/drm/display/drm_dp_helper.h
> +++ b/include/drm/display/drm_dp_helper.h
> @@ -372,8 +372,10 @@ struct drm_dp_aux {
>  	 * Also note that this callback can be called no matter the
>  	 * state @dev is in and also no matter what state the panel is
>  	 * in. It's expected:
> +	 *
>  	 * - If the @dev providing the AUX bus is currently unpowered then
>  	 *   it will power itself up for the transfer.
> +	 *
>  	 * - If we're on eDP (using a drm_panel) and the panel is not in a
>  	 *   state where it can respond (it's not powered or it's in a
>  	 *   low power state) then this function may return an error, but
> -- 
> 2.36.1.476.g0c4daa206d-goog
