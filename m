Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984F6C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 13:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348876AbiCON6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 09:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237474AbiCON6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:58:39 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558BF53E1B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647352648; x=1678888648;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ML2HWARvWUXFi+l0xLCWwy/yF0B8zA3fmPR4ZIQ+ywM=;
  b=RAhpxa1Kf6K1riusJMZEHHZl8+SSRlOAj1bPHh+P2l9BEfY9es+qbPVE
   RzB6WwV/mO8jBitAWsIoAgISWF8gFjUcwJoogHvmgDR0L0quPnA2QwQne
   aUbd0vXm/FoyFejAUozUfdRcqZGDMUMFC2d+LyPVvbwsjm0l1UxnGiEW8
   KjeiQlT01dunkaHFbgC2oKfWliFSNxIHMpflSvaCrUm6f2i1pKO0mOYr0
   RqeAgMzbBS/RE5fNqCxcBciAZ+2yZEzMoBVPAblc3FZJwQZbMMpAeOfux
   npmWqzHIfBvdP1QhlZBiKUM6TTyawY3QZTcjua7VgBdRmqnBmEj5xXDOd
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="236911007"
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="236911007"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 06:57:28 -0700
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="644264425"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 06:57:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nU7fI-000ICH-LB;
        Tue, 15 Mar 2022 15:56:44 +0200
Date:   Tue, 15 Mar 2022 15:56:44 +0200
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
Subject: Re: [PATCH 5/5] drm/repaper: Reduce temporary buffer size in
 repaper_fb_dirty()
Message-ID: <YjCbHK1uQCmNBpo5@smile.fi.intel.com>
References: <20220315110707.628166-1-geert@linux-m68k.org>
 <20220315110707.628166-6-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315110707.628166-6-geert@linux-m68k.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 12:07:07PM +0100, Geert Uytterhoeven wrote:
> As the temporary buffer is no longer used to store 8-bit grayscale data,
> its size can be reduced to the size needed to store the monochrome
> bitmap data.

bitmap API?

-- 
With Best Regards,
Andy Shevchenko


