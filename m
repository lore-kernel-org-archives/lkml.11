Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CC4C28D13
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Aug 2022 06:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbiHYGvt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Aug 2022 02:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiHYGvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 02:51:45 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C412AA0637
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 23:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661410304; x=1692946304;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=oL/cDsyvaZ2AMAuLWe4mBX/p2crsIcQ5eiyX+HbuLvc=;
  b=Ue0/YG6HRsQ2oB2wKBCoABJ2/issO67Bq0JVmmAr9uSE/d3K9iPwKPuo
   i71OhokYJ/sVnMDDElXhL983ebmqGt32rIzfClYQdM+0ewuGqQaG7F5rg
   T/ZBRbmN9Q1C/1ED1xqO+dsMAHrPXpzV8I1hyR6Ux57ed3J+RNiJHhq0M
   2GMEulEt/owjMnHskrpffrRoKQOXWXBLam4VPHSrPshXSH6YT17V+v8X8
   /otmxiV6jqepEfjrLIm9LNJ7uJYsQzdShx/yoKQXdLLRdY+MHusJy1mZ5
   0BK+paEnh1hvLuB5sW9McHVcNyPLO99PtmbkBUsPWBnBqtVjQFXlpoiNS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="320236818"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="320236818"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 23:51:44 -0700
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="670847183"
Received: from pranavir-mobl.gar.corp.intel.com (HELO localhost) ([10.252.50.196])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 23:51:41 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Lv qian <lvqian@nfschina.com>, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Lv qian <lvqian@nfschina.com>
Subject: Re: [PATCH] drm/i915:Move the code position to reduce the number of
 judgments
In-Reply-To: <20220825013752.120988-1-lvqian@nfschina.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220825013752.120988-1-lvqian@nfschina.com>
Date:   Thu, 25 Aug 2022 09:51:39 +0300
Message-ID: <87h720izno.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2022, Lv qian <lvqian@nfschina.com> wrote:
> 	If the kmalloc allocation is successful, the if is judged twice, 
> 	so I move the second judgment in to the first judgment.

The code is fine as it is.

BR,
Jani.

>
> Signed-off-by: Lv qian <lvqian@nfschina.com>
> ---
>  drivers/gpu/drm/i915/i915_gpu_error.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_gpu_error.c b/drivers/gpu/drm/i915/i915_gpu_error.c
> index 32e92651ef7c..c8230a8beadb 100644
> --- a/drivers/gpu/drm/i915/i915_gpu_error.c
> +++ b/drivers/gpu/drm/i915/i915_gpu_error.c
> @@ -112,10 +112,10 @@ static bool __i915_error_grow(struct drm_i915_error_state_buf *e, size_t len)
>  	if (!e->buf) {
>  		e->size = PAGE_ALIGN(len + 1);
>  		e->buf = kmalloc(e->size, GFP_KERNEL);
> -	}
> -	if (!e->buf) {
> -		e->err = -ENOMEM;
> -		return false;
> +		if (!e->buf) {
> +			e->err = -ENOMEM;
> +			return false;
> +		}
>  	}
>  
>  	return true;

-- 
Jani Nikula, Intel Open Source Graphics Center
