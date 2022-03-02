Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D033C4332F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 15:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237855AbiCBPxV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 10:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240693AbiCBPwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 10:52:47 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D32A5749C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 07:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646236311; x=1677772311;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bzhd/7e+vriazddLYSlaraUHSol5WfmYsrIBC2B4hjk=;
  b=LLun221i7lUMeQaoKcjgLZYdfUMampZnVrnyHozijvPaZ9Pqz2bjpNF+
   u492zPIvOYYVT6Lk8yFJGjsq6jFGJY9cS0sQ+Izz1djufKPtfFxqwhdRH
   ay9e641HhKHWVuu+5ho7wbjM/E8lJQy+Cb2twCiB/FgYtSccWwKKmSzd4
   0q5K5epYIMxyNfFASaS6GzhGLSZRMpK/h7srWp9kqh3WYbDAlxyLPrzQb
   hqLJYOiBh3eHytMR5nWCvP/PTqBf6jiOGqpWX18M2ykbQBxTDompKovHU
   lQVFwM+1wCd6vpXmGDwEPJkw5XPrqMcLJnnDpQ2qwQW+J0gMzjMt51icF
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="253161642"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="253161642"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 07:51:41 -0800
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="576147829"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 07:51:40 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nPRFd-00AMr0-An;
        Wed, 02 Mar 2022 17:50:53 +0200
Date:   Wed, 2 Mar 2022 17:50:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rodolfo Giometti <giometti@enneenne.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 1/1] pps: generators: pps_gen_parport: Switch to use
 module_parport_driver()
Message-ID: <Yh+SXftPLjwPTCI0@smile.fi.intel.com>
References: <20220210134943.62026-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210134943.62026-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 03:49:43PM +0200, Andy Shevchenko wrote:
> Switch to use module_parport_driver() to reduce boilerplate code.
> 
> Note, it doesn't matter when we check the module parameter. If it was
> writable we even would have more flexibility of changing it at runtime
> (when built-in the kernel) after this patch.

Greg, can it be now applied?

-- 
With Best Regards,
Andy Shevchenko


