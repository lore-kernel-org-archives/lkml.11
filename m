Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F143C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 16:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237681AbiDFQYk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 12:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237581AbiDFQYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:24:12 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6D03858E2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 06:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649252785; x=1680788785;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pFQJLYTSIUtGGDkRMNXfH9mNCTySCEkxZaPD/bR+QOY=;
  b=St3UJLK29tiLsgVL5o0JTowrDvcsLMMr170noz0lMdGMA0WLxVHERHVs
   l5BdL88N9WH3ees92sGdLuDNVJ+50ur8jMIHsQfnE/WVfJ+APBXyDlmkF
   vI74fs+zHeQqMGG5qHsY9YLvtw1SrqzLKX6GQZWb+qUSnBVKsEOf1fXmv
   gsP9Xf/APmbR9RMF8bh9fZuD+lxm3VwZQdjbPojYk8dXoZvUi9Q4Be47Y
   1ijyHyuBITlAgQI+4pwL2pY02oFpJFJwVsRC8pyNdmIAo9YsIaX5Ugm2A
   3sfH7OkjUzvTIjeWWB5N6KSqMBV2xRAXrmIR//bDpTYeHKJiBSsbwK0SC
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="261214425"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="261214425"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 06:02:41 -0700
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="524459107"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 06:02:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nc5HX-000EG4-V0;
        Wed, 06 Apr 2022 16:01:07 +0300
Date:   Wed, 6 Apr 2022 16:01:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] powerpc/83xx/mpc8349emitx: Get rid of of_node
 assignment
Message-ID: <Yk2PE7+oEEtGri95@smile.fi.intel.com>
References: <20220323174342.56187-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdbUWE8knM=9uUVLTX792Y8_J1aPj4KtFh=yJxaKi+ZqRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbUWE8knM=9uUVLTX792Y8_J1aPj4KtFh=yJxaKi+ZqRw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 03:16:08PM +0200, Linus Walleij wrote:
> On Wed, Mar 23, 2022 at 6:43 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Let GPIO library to assign of_node from the parent device.
> > This allows to move GPIO library and drivers to use fwnode
> > APIs instead of being stuck with OF-only interfaces.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> That's a nice patch.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks!

Can we have this applied now?

-- 
With Best Regards,
Andy Shevchenko


