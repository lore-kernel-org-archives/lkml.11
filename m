Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D46C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 13:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348673AbiCONlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 09:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236089AbiCONlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:41:42 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9D352E49
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647351631; x=1678887631;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DdbAPj3nXXTBOseL7TETjlOXpTqLIR2bDFn56wnS9No=;
  b=RkBQCdHDVPJu4bbE6h9tXhMlxw5G7C3R+O7eAZL3R/fz8Dplsowm3qwJ
   8byEZTgmI9mPTHaS86WrwSI1ar84FAqm3VwVhUpeoKthXqWnbqs0U5v4U
   BULLOSHFswDNhrKn0ZkYJsg3wnx8k9AzismJQwKEWDS4TmlbmDJpitPuT
   6wybzK4M8gFu7O+2EX+NBk3YyE5TV9Fd8D6dCk5dq8z84yr6cm3VHbBuG
   aEhDehIwvA9hQ3YM6Mi2rSxoBMg3vMfLOa9/OR4jI5ivkTAFThxSKEIj6
   eYvo2Y17lh3UwSM+Vuug5geRKSNtAkzx7MTEb8Eill1niPPdBOeJYPMoL
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="238469603"
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="238469603"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 06:40:30 -0700
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="498016944"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 06:40:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nU7Op-000HiZ-9q;
        Tue, 15 Mar 2022 15:39:43 +0200
Date:   Tue, 15 Mar 2022 15:39:42 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] drm/format-helper: Fix XRGB888 to monochrome
 conversion
Message-ID: <YjCXHg9lWs8LVAGs@smile.fi.intel.com>
References: <20220315110707.628166-1-geert@linux-m68k.org>
 <20220315110707.628166-3-geert@linux-m68k.org>
 <27e1c911-798a-c14b-e5a0-622a7c5d8755@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27e1c911-798a-c14b-e5a0-622a7c5d8755@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 01:18:00PM +0100, Javier Martinez Canillas wrote:
> On 3/15/22 12:07, Geert Uytterhoeven wrote:

> > +		for (i = 0; i < bits; i++, pixels--) {
> 
> I think is worth to add a comment here explaining that the pixel is set to
> 1 for brightness > 127 and to 0 for brightness < 128. Or as kernel-doc for
> this helper function.
> 
> > +			if (*src++ & BIT(7))
> 
> Pekka also mentioned that if (*src++ > 127) would make this easier to read.

>= 128 ?

> > +				byte |= BIT(i);
> >  		}
> >  		*dst++ = byte;
> >  	}

-- 
With Best Regards,
Andy Shevchenko


