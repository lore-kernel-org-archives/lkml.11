Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607B2C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jun 2022 19:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245165AbiFCTxE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jun 2022 15:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiFCTw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 15:52:59 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C165818B08
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 12:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654285977; x=1685821977;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bwZS9fM1j608qGijOGH6qy5ZVrEpBHDkEYemfQnRjio=;
  b=dStBLs8TxKFA82IKrWBtHzq2FqBcvhJ/eQb3pmIkB+Fx3t3+uhKA+8to
   ryJggUHVUnHZD7O4vkck2LrtpKqxwtOTrZ74Y55eYynY3O9S/f4gxugie
   hWMMmSvwIrsS7FSnaPAbBxWS3wT4r8UL7haRrPIEVLuYfcUVUkyK1NJgp
   N7XKNORJhO/eskqshl2Del7Cjjrmww+q4akd7vmg+fcQ+C56QXhOO8L0r
   BHIIbngHEVCfKhq5sHSTt5m5xITx1QM0sEqkYNzFaAqjDArBHGrCAdAFE
   C5fDHuWKV6cWyy2uAdVCnCBJYtBSnzC1HUQ39qFvJpZ0ZGUBBg1n7+6AH
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10367"; a="273897774"
X-IronPort-AV: E=Sophos;i="5.91,275,1647327600"; 
   d="scan'208";a="273897774"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 12:52:56 -0700
X-IronPort-AV: E=Sophos;i="5.91,275,1647327600"; 
   d="scan'208";a="708195670"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 12:52:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nxDLo-000Sl3-EF;
        Fri, 03 Jun 2022 22:52:52 +0300
Date:   Fri, 3 Jun 2022 22:52:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] kernel.h: Move sysfs related macro to sysfs.h
Message-ID: <Yppmk94fTWCM3NjZ@smile.fi.intel.com>
References: <20220603172101.49950-1-andriy.shevchenko@linux.intel.com>
 <20220603121511.78aa66b02376d02557c29819@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603121511.78aa66b02376d02557c29819@linux-foundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 12:15:11PM -0700, Andrew Morton wrote:
> On Fri,  3 Jun 2022 20:21:01 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > As stated in the comment of VERIFY_OCTAL_PERMISSIONS() it's related to sysfs.
> > Move it to the corresponding header.
> 
> arm allmodconfig:

Thanks

x86 builds :(

I will look into it later on.

-- 
With Best Regards,
Andy Shevchenko


