Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4C3C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jun 2022 11:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350252AbiFUL5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jun 2022 07:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350206AbiFUL5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 07:57:12 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816A52AE38
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 04:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655812631; x=1687348631;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bs/0j/OtFGIBL6GNtWcTVuEeu+2d9SQNaMwWjvKuGwM=;
  b=DsO29diPhujQa5/Ce1z2ZA8xi9z1tfd0kTzWBozOM6+xuh3y7sW4LEA0
   8eXXKvlanIAQf6aFnZP5TbXdJKgAU/h9QLs7TjoB7eI9xoHhJKhfWQCcm
   jU4A+C0b7aXp/ImElrWz8gDNnvVF/r6n2DAFX1Wr7vebheAbiA5ziQx2f
   2iPweEs4tzSzjQfEtdvc5F2brPwldcRqAIr1f0ss4qMWCiIL9hXO5lHbW
   kgUFA6ESBkZeN8JeFS0QIa5qJD+cPHoEjB3+M9na4YL1TbyNZwWGozgLS
   X/ikeli1biS8HzybHMD4bozWslocTCVsHDhQwNMXnkcS5lJgBydtwpbW2
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="366423450"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="366423450"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 04:57:11 -0700
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="614719605"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 04:57:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o3cVG-000r00-Cp;
        Tue, 21 Jun 2022 14:57:06 +0300
Date:   Tue, 21 Jun 2022 14:57:06 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] nvdimm/namespace: drop nested variable in
 create_namespace_pmem()
Message-ID: <YrGyEgXM9pvCTEc1@smile.fi.intel.com>
References: <20220607164937.33967-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607164937.33967-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 07:49:37PM +0300, Andy Shevchenko wrote:
> Kernel build bot reported:
> 
>   namespace_devs.c:1991:10: warning: Local variable 'uuid' shadows outer variable [shadowVariable]
> 
> Refactor create_namespace_pmem() by dropping a nested version of
> the same variable.

Any comments on this and other two patches?

-- 
With Best Regards,
Andy Shevchenko


