Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC08C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 13:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348830AbiCONw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 09:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346656AbiCONw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:52:28 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F2253704
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647352276; x=1678888276;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z8cDmbmlZNdInmwIqDtaFr4bVtO7m8JUzG7iHYr21qA=;
  b=IXXfXQTheWdiLCuMIXd95S/VN6FT/J0hvA6S9nxdaddLZKx7fzGIvYt/
   2iYkcxuZrfbtvcoX/Tp0zFWMCOUF964pc+aL0hs9PqKaE8E7WphUJjhMz
   TubOIdYsDecn99Q9erIlat+HAxIDfjmSuJdOWzHiyBI1KBghaPV4bWjJZ
   NG8oxVFGlvNktOaLpBrwwDSbNQXb+YKJ9jOvcuJmG7ftafXcRWvIYxuLn
   oBH2Of4v9XFutZhCNPSCuKnPiQdfmoiEDoYPcGXghMVbmaigkXKaecAs5
   Re8AyTkzuxUCrL9F8xc+aiL+uxX3c7/A49a5W3AO013I9VYBOoQmODR2k
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="342732429"
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="342732429"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 06:50:54 -0700
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="690201870"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 06:50:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nU7Yx-000I0A-0v;
        Tue, 15 Mar 2022 15:50:11 +0200
Date:   Tue, 15 Mar 2022 15:50:10 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] drm: ssd130x: Reduce temporary buffer sizes
Message-ID: <YjCZkkv//EhvxszH@smile.fi.intel.com>
References: <20220315110707.628166-1-geert@linux-m68k.org>
 <20220315110707.628166-5-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315110707.628166-5-geert@linux-m68k.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 12:07:06PM +0100, Geert Uytterhoeven wrote:
> ssd130x_clear_screen() allocates a temporary buffer sized to hold one
> byte per pixel, while it only needs to hold one bit per pixel.
> 
> ssd130x_fb_blit_rect() allocates a temporary buffer sized to hold one
> byte per pixel for the whole frame buffer, while it only needs to hold
> one bit per pixel for the part that is to be updated.
> Pass dst_pitch to drm_fb_xrgb8888_to_mono_reversed(), as we have already
> calculated it anyway.

Can we use bitmap API? bitmap_zalloc() / etc ?


-- 
With Best Regards,
Andy Shevchenko


