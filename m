Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F353C32774
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 17:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiHWRck (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 13:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbiHWRa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:30:58 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55798D25EF;
        Tue, 23 Aug 2022 08:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661267285; x=1692803285;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gWEpIuQrv6G7/Vjm7oq9A8FilFd6z/lOUmdAyJru9sE=;
  b=ge17pMe34KL59eikDImifyXp6FNzDYzYDdAanA2LO5KQ4/N85DrPbbMZ
   uyCK86AoiYxw4Y2v0gl5E+cQyXcq3KaLKqeKBKyTKCI6RIxUdHjAMdtGz
   PVq+zpMM12kt3W9wGHiQqdhcxg60k4qGw9yS4oTKMKHut3wJqHHcyORFQ
   dl/UId7G3Hkt59mEzpJUC82ZrQpCtiz4yHUeZeP3Cs6O2U0PBNL8NVSPa
   RAhuFhhKephrOge8Og9ivv9eMa6eFFuPERp0abSXlcQO1VcjX/zW958HM
   9YqnM1URQT8eDOw2eOE9JhzEMQ7oXtZw4noY8buyH66gcljyQyB24STJR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="294995301"
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="294995301"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 08:07:36 -0700
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="612439077"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 08:07:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oQVV6-002UOC-1i;
        Tue, 23 Aug 2022 18:07:32 +0300
Date:   Tue, 23 Aug 2022 18:07:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v1 1/4] dmaengine: hsu: Finish conversion to managed
 resources
Message-ID: <YwTtNKCLb3NbXelj@smile.fi.intel.com>
References: <20220713172235.22611-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713172235.22611-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 08:22:32PM +0300, Andy Shevchenko wrote:
> With help of devm_add_action_or_reset() we may finish conversion
> the driver to use managed resources.

Vinod, can these be applied?


-- 
With Best Regards,
Andy Shevchenko


