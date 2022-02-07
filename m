Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA7BC35276
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 14:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391277AbiBGOTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 09:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382372AbiBGOOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:14:41 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316DBC0401C0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 06:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644243281; x=1675779281;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0HnYO7OclOrVsG+5Z5WQVd9GI5Heaz31PmHddPJ8d0Y=;
  b=EChEU4SPuWxJXuHeXcisr8O/xWN9IeJ5D9feWFjgYNbp5F42Av4G3koc
   uTgAU4hzSWNffj1W2TD8UWPC6JbklrY4zz3IcyH6c98UBMOQYMFSO0auS
   jAkdRKQbJKh73PVC3GIqRqfBVeoEk17f3O/tAAc2R7WfJxZ64P3rLvjRb
   fOt76uDD7r/t3qVVQ8ZkRKRpOAVEcb1/p4fMHrEQCiqrzRHqmxzAcrq7z
   x3gM+zOiJ1gracG+I5E3Kir/4h+eiN+NSFS++flFi2CUmOPxfiOhXMXco
   /utV9j0Kwl1TZPLUr+uieHkya0b/G4UDQ+athOybqace8+GlMuGRsJR5/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="335126855"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="335126855"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 06:14:40 -0800
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="484434402"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 06:14:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nH4lw-001vTI-QA;
        Mon, 07 Feb 2022 16:13:40 +0200
Date:   Mon, 7 Feb 2022 16:13:40 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rodolfo Giometti <giometti@enneenne.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 1/1] pps: generators: pps_gen_parport: Switch to use
 module_parport_driver()
Message-ID: <YgEpFCPX+sjDPlU+@smile.fi.intel.com>
References: <20220207131652.13316-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207131652.13316-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 03:16:52PM +0200, Andy Shevchenko wrote:
> Switch to use module_parport_driver() to reduce boilerplate code.

...

> v3: added Ack (Rodolfo), Cc'ed to Greg for picking it up

> +	if (send_delay > SEND_DELAY_MAX) {
> +		pr_err("delay value should be not greater then %d\n", SEND_DELAY_MAX);
> +		return -EINVAL;

Argh!

This has been derived from v1 and not v2, sorry.
v4 will be sent to address this.


> +	}


-- 
With Best Regards,
Andy Shevchenko


