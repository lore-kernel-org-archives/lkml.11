Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA03C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jan 2022 16:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243619AbiAXQNu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jan 2022 11:13:50 -0500
Received: from foss.arm.com ([217.140.110.172]:39162 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235393AbiAXQNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:13:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBE55D6E;
        Mon, 24 Jan 2022 08:13:48 -0800 (PST)
Received: from [10.57.38.96] (unknown [10.57.38.96])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD5663F793;
        Mon, 24 Jan 2022 08:13:47 -0800 (PST)
Subject: Re: [PATCH] drm/arm: arm hdlcd select DRM_GEM_CMA_HELPER
To:     carsten.haitzler@foss.arm.com, dri-devel@lists.freedesktop.org
Cc:     liviu.dudau@arm.com, brian.starkey@arm.com, airlied@linux.ie,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org
References: <20220124151357.2467149-1-carsten.haitzler@foss.arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <b302b8f4-40de-7b88-fbf5-933707476cdb@arm.com>
Date:   Mon, 24 Jan 2022 16:13:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220124151357.2467149-1-carsten.haitzler@foss.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2022 15:13, carsten.haitzler@foss.arm.com wrote:
> From: Carsten Haitzler <carsten.haitzler@arm.com>
> 
> Without DRM_GEM_CMA_HELPER HDLCD won't build. This needs to be there too.
> 
> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>

To add the context, DRM_HDLCD used to select DRM_KMS_CMA_HELPER but that
was removed in commit 09717af7d13d ("drm: Remove
CONFIG_DRM_KMS_CMA_HELPER option"). DRM_KMS_CMA_HELPER would select
DRM_GEM_CMA_HELPER but that transitive dependency was lost and
apparently the fixup was missed in that commit.

So we need a:

Fixes: 09717af7d13d ("drm: Remove CONFIG_DRM_KMS_CMA_HELPER option")

and with that...

Reviewed-by: Steven Price <steven.price@arm.com>

Steve

> ---
>  drivers/gpu/drm/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/arm/Kconfig b/drivers/gpu/drm/arm/Kconfig
> index 58a242871b28..6e3f1d600541 100644
> --- a/drivers/gpu/drm/arm/Kconfig
> +++ b/drivers/gpu/drm/arm/Kconfig
> @@ -6,6 +6,7 @@ config DRM_HDLCD
>  	depends on DRM && OF && (ARM || ARM64 || COMPILE_TEST)
>  	depends on COMMON_CLK
>  	select DRM_KMS_HELPER
> +	select DRM_GEM_CMA_HELPER
>  	help
>  	  Choose this option if you have an ARM High Definition Colour LCD
>  	  controller.
> 

