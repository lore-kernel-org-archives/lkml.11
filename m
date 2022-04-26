Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E30C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Apr 2022 13:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348197AbiDZNaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Apr 2022 09:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348045AbiDZNaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:30:15 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0339418D6A7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650979627; x=1682515627;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d7bkgmZnJMhnPyUymkC1XeAvQ2myhgXmgRziaJNPH8Q=;
  b=Ml+u2YCluVgC4w8yiaPN+AcoHeGxMKQw9cMtLr7l3jiepUmgtZ2xVKfI
   ZEMIQklhvrTecYkt2e8DCcRL2SvFCEfIrRKWo1dw9mXWm6VwfasBtF6aF
   GkXdFv3iGGE4VkeVY70CjM5zhvthBxdrm/nnAwFrSM0cGBz678FgHZF+P
   nPzjfMyBMfPajZo4zeMiXZIyujuoSrWCS/x45X4c6A5l1jJS/BELK9CVw
   dCGCzQYW889PgMoNO5EfAhWDvQSJ49W/bSCugjk2uTVR3+6YZZYuRckkX
   zY/MktgQLhLCHTX35GJmhhQKLpSoX8Y738+908s5GLUOMixYswKbtGCTy
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="264421122"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="264421122"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 06:27:07 -0700
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="730248354"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 06:27:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1njLDa-008L8S-7M;
        Tue, 26 Apr 2022 16:27:02 +0300
Date:   Tue, 26 Apr 2022 16:27:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jagdish Gediya <jvgediya@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ying.huang@intel.com, dave.hansen@intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2] lib/kstrtox.c: Add "false"/"true" support to
 kstrtobool
Message-ID: <YmfzJVPng1U8X+jV@smile.fi.intel.com>
References: <20220426064001.14241-1-jvgediya@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426064001.14241-1-jvgediya@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 12:10:01PM +0530, Jagdish Gediya wrote:
> At many places in kernel, It is necessary to convert sysfs input
> to corrosponding bool value e.g. "false" or "0" need to be converted
> to bool false, "true" or "1" need to be converted to bool true,
> places where such conversion is needed currently check the input
> string manually, kstrtobool can be utilized at such places but

kstrtobool()

> currently kstrtobool doesn't have support to "false"/"true".


Ditto.

> Add "false"/"true" support to kstrtobool while string conversion

Ditto.

> to bool. Modify existing manual sysfs conversions to use kstrtobool().

> This patch doesn't have any functionality change.

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Richard Fitzgerald <rf@opensource.cirrus.com>
> Cc: Petr Mladek <pmladek@suse.com>

You may use --cc parameter to `git send-email`.

...

>  lib/kstrtox.c   | 7 +++++++
>  mm/migrate.c    | 6 +-----
>  mm/swap_state.c | 6 +-----

Please, split to two.
Also Documentation update is missed.

-- 
With Best Regards,
Andy Shevchenko


