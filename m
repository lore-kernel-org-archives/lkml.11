Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F10C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Apr 2022 20:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352619AbiDAUvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Apr 2022 16:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiDAUvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:51:02 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3791C2D9E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648846152; x=1680382152;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KV+pFZKLWh422cNJSg0ZSjERIplw9IBD5K8wbfwKPgc=;
  b=PaNRBi3DBKJ40DpUvdvM+6M7bpKy+hQXKYfqdSLj5PTcMLfBhCog5Urb
   xPJ0AzDuwV4z0UaRzSbxTcGNm+Fs43I9f5JOhiL7e71zRU+ilRtKixQeT
   zCPrT6OvMf1xyoLqvGsh2G1BklkCnn0SHP1hioN7IfOPFL1uoAetEroHS
   OvVzRFmHS9eMuqimkNAqu2p+5PYFssWC5rjwT3lNIaAluy5M4WOfi2mAP
   DtBH45/5cqGmgWaxMmdJeSp5odYoczk23IxYiQNjY80I4NzFAPNzYWXgQ
   4OwCqJUGKN6iTdwN8KAwAED3p/fCN9emVlSxysSf2RZdvF603xf0Pbms8
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="346665035"
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="346665035"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 13:49:11 -0700
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="650850877"
Received: from kmislam-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.112.89])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 13:49:11 -0700
Date:   Fri, 1 Apr 2022 13:49:11 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: vc04_services: Convert kmap() to
 kmap_local_page()
Message-ID: <YkdlRw/p4WDKZqvg@iweiny-desk3>
References: <20220330191414.23141-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330191414.23141-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 09:14:14PM +0200, Fabio M. De Francesco wrote:
> The use of kmap() is being deprecated in favor of kmap_local_page()
> where it is feasible. In file interface/vchiq_arm/vchiq_arm.c,
> function free_pagelist() calls kmap() / kunmap() from two places.
> 
> With kmap_local_page(), the mapping is per thread, CPU local and not
> globally visible. Therefore, free_pagelist() is a function where the
> use of kmap_local_page() in place of kmap() is correctly suited.
> 
> Convert to kmap_local_page() but, instead of open coding it, use the
> memcpy_to_page() helper.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

LGTM:

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  .../vc04_services/interface/vchiq_arm/vchiq_arm.c   | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index f0bfacfdea80..efb1383b5218 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -431,21 +431,18 @@ free_pagelist(struct vchiq_pagelist_info *pagelistinfo,
>  			if (head_bytes > actual)
>  				head_bytes = actual;
>  
> -			memcpy((char *)kmap(pages[0]) +
> +			memcpy_to_page(pages[0],
>  				pagelist->offset,
>  				fragments,
>  				head_bytes);
> -			kunmap(pages[0]);
>  		}
>  		if ((actual >= 0) && (head_bytes < actual) &&
> -		    (tail_bytes != 0)) {
> -			memcpy((char *)kmap(pages[num_pages - 1]) +
> -				((pagelist->offset + actual) &
> -				(PAGE_SIZE - 1) & ~(g_cache_line_size - 1)),
> +		    (tail_bytes != 0))
> +			memcpy_to_page(pages[num_pages - 1],
> +				(pagelist->offset + actual) &
> +				(PAGE_SIZE - 1) & ~(g_cache_line_size - 1),
>  				fragments + g_cache_line_size,
>  				tail_bytes);
> -			kunmap(pages[num_pages - 1]);
> -		}
>  
>  		down(&g_free_fragments_mutex);
>  		*(char **)fragments = g_free_fragments;
> -- 
> 2.34.1
> 
