Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FE7ECAAD5
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Sep 2022 14:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbiIBOxC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Sep 2022 10:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236691AbiIBOwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:52:31 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083D632D9D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 07:16:24 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="382287581"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="382287581"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 07:16:24 -0700
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="563975235"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 07:16:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1oU7Sz-007Q79-0B;
        Fri, 02 Sep 2022 17:16:17 +0300
Date:   Fri, 2 Sep 2022 17:16:16 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.com,
        perex@perex.cz, amadeuszx.slawinski@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, hdegoede@redhat.com,
        lgirdwood@gmail.com, kai.vehmanen@linux.intel.com,
        peter.ujfalusi@linux.intel.com, ranjani.sridharan@linux.intel.com,
        yung-chuan.liao@linux.intel.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, andy@kernel.org,
        intel-poland@eclists.intel.com
Subject: Re: [PATCH v5 0/2] lib/string_helpers: Introduce
 parse_int_array_user()
Message-ID: <YxIQMCFX2X3p8teL@smile.fi.intel.com>
References: <20220902133256.789165-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902133256.789165-1-cezary.rojewski@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 03:32:54PM +0200, Cezary Rojewski wrote:
> Continuation of recent upstream discussion [1] regarding user string
> tokenization.
> 
> First, parse_int_array_user() is introduced to allow for splitting
> specified user string into a sequence of integers. Makes use of
> get_options() internally so the parsing logic is not duplicated.
> 
> With that done, redundant parts of the sound driver are removed.
> 
> Originally similar functionality was added for the SOF sound driver. As
> more users are on the horizon, it is desirable to update existing
> string_helpers code and provide a unified solution.

Feel free to route it via SOF or related tree since you have my tag
for the library part.

-- 
With Best Regards,
Andy Shevchenko


