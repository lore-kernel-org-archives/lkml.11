Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D350C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 30 May 2022 13:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbiE3NFT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 May 2022 09:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236356AbiE3NFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 09:05:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5CA7DE31;
        Mon, 30 May 2022 06:05:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25F3FB80D86;
        Mon, 30 May 2022 13:05:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C10DC385B8;
        Mon, 30 May 2022 13:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653915911;
        bh=f51GI44mfzMyxMYx34Abcuu4ez37U0rG+03vNzNKYvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pTejx5gj3sCKMu4j6ranmCfSYcL+sRDF2Gfl/9lBFZdp7mTZ16NrkVqnI8yYFRpk+
         P4BQYmj4q2K+9ThaYT+UiK0XPGqzT2ikn37DZjBwxwyPrZi//y0Naw+TSn2/rI1BNA
         9GvtDSGxkCyjdT8UH2U9QNayUsiwlXR4jzTErWCQ=
Date:   Mon, 30 May 2022 15:05:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ryan Lin <tsung-hua.lin@amd.com>
Cc:     leon.li@amd.com, praful.swarnakar@amd.com, shirish.s@amd.com,
        ching-shih.li@amd.com, Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        stable@vger.kernel.org, Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <sashal@kernel.org>,
        Mark Yacoub <markyacoub@google.com>,
        Roman Li <Roman.Li@amd.com>,
        Ikshwaku Chauhan <ikshwaku.chauhan@amd.corp-partner.google.com>,
        Simon Ser <contact@emersion.fr>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BACKPORT: drm/amdgpu/disply: set num_crtc earlier
Message-ID: <YpTBBPVxcdJ8sn8m@kroah.com>
References: <20220530092902.810336-1-tsung-hua.lin@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530092902.810336-1-tsung-hua.lin@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 05:29:02PM +0800, Ryan Lin wrote:
> From: Alex Deucher <alexander.deucher@amd.com>
> 
> To avoid a recently added warning:
>  Bogus possible_crtcs: [ENCODER:65:TMDS-65] possible_crtcs=0xf (full crtc mask=0x7)
>  WARNING: CPU: 3 PID: 439 at drivers/gpu/drm/drm_mode_config.c:617 drm_mode_config_validate+0x178/0x200 [drm]
> In this case the warning is harmless, but confusing to users.
> 
> Fixes: 0df108237433 ("drm: Validate encoder->possible_crtcs")
> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=209123
> Reviewed-by: Daniel Vetter <daniel@ffwll.ch>
> Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org


Why did you not sign off on this?

And what is the git id of this in Linus's tree?

> Conflicts:
> 	drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> 	[Ryan Lin: Fixed the conflict, remove the non-main changed part
> 	of this patch]

No need for this here, right?

thanks,

greg k-h
