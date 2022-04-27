Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4D6C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Apr 2022 12:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbiD0ML1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Apr 2022 08:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbiD0MLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 08:11:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93E032E9F9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 05:08:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62916143D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 05:08:14 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 281FE3F774
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 05:08:14 -0700 (PDT)
Date:   Wed, 27 Apr 2022 13:08:06 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     pengfuyuan <pengfuyuan@kylinos.cn>
Cc:     Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/arm/mali-dp: Fix spelling typo in comment
Message-ID: <YmkyJgXeNjxuv1yQ@e110455-lin.cambridge.arm.com>
References: <20220426121639.39160-1-pengfuyuan@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220426121639.39160-1-pengfuyuan@kylinos.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 08:16:39PM +0800, pengfuyuan wrote:
> Fix spelling typo in comment.
> 
> Signed-off-by: pengfuyuan <pengfuyuan@kylinos.cn>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Many thanks for fixing this!

Best regards,
Liviu

> ---
>  drivers/gpu/drm/arm/malidp_regs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_regs.h b/drivers/gpu/drm/arm/malidp_regs.h
> index 514c50dcb74d..3bc16db70ddb 100644
> --- a/drivers/gpu/drm/arm/malidp_regs.h
> +++ b/drivers/gpu/drm/arm/malidp_regs.h
> @@ -145,7 +145,7 @@
>  #define     MALIDP_SE_COEFFTAB_DATA_MASK	0x3fff
>  #define     MALIDP_SE_SET_COEFFTAB_DATA(x) \
>  		((x) & MALIDP_SE_COEFFTAB_DATA_MASK)
> -/* Enhance coeffents reigster offset */
> +/* Enhance coefficients register offset */
>  #define MALIDP_SE_IMAGE_ENH			0x3C
>  /* ENH_LIMITS offset 0x0 */
>  #define     MALIDP_SE_ENH_LOW_LEVEL		24
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
