Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF66C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Apr 2022 11:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350914AbiDSLRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Apr 2022 07:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiDSLRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:17:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 807852B1B2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:14:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46EE213D5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:14:23 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1093B3F73B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:14:22 -0700 (PDT)
Date:   Tue, 19 Apr 2022 12:14:14 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Xuezhi Zhang <zhangxuezhi1@coolpad.com>
Cc:     brian.starkey@arm.com, airlied@linux.ie, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/malidp: convert sysfs snprintf to sysfs_emit
Message-ID: <Yl6ZhnewbrlUbWuo@e110455-lin.cambridge.arm.com>
References: <20220417132918.135795-1-zhangxuezhi1@coolpad.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220417132918.135795-1-zhangxuezhi1@coolpad.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 17, 2022 at 01:29:18PM +0000, Xuezhi Zhang wrote:
> Fix the following coccicheck warning:
> drivers/gpu/drm/arm/malidp_drv.c:658:8-16:
> WARNING: use scnprintf or sprintf
> 
> Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Thanks for this!

Best regards,
Liviu

> ---
>  drivers/gpu/drm/arm/malidp_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
> index d5aef21426cf..b1ffd5ba27d9 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.c
> +++ b/drivers/gpu/drm/arm/malidp_drv.c
> @@ -655,7 +655,7 @@ static ssize_t core_id_show(struct device *dev, struct device_attribute *attr,
>  	struct drm_device *drm = dev_get_drvdata(dev);
>  	struct malidp_drm *malidp = drm->dev_private;
>  
> -	return snprintf(buf, PAGE_SIZE, "%08x\n", malidp->core_id);
> +	return sysfs_emit(buf, "%08x\n", malidp->core_id);
>  }
>  
>  static DEVICE_ATTR_RO(core_id);
> -- 
> 2.25.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
