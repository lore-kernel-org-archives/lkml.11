Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C444FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Apr 2022 16:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237102AbiDMQ6Q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Apr 2022 12:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbiDMQ6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:58:06 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0295069704;
        Wed, 13 Apr 2022 09:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649868945; x=1681404945;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+nqYzv4g8eqFem8dbdxen/mrdhveQU0Ba+F0FwPncek=;
  b=gUbi0K5wOepAlSIlJKSFxNejT+G5Irn8npykzM8ADfGpGxOwKd+HgSjS
   rd2NpPPSXXmypXS4Pa8+FN21n2dL1f60lglRcbls3NRAKYWuCdCza7lub
   4I1mauxsX5h99SVimZPxRJAtZs0vHVmOxJTxGkNZxBWyL5Sf4umaYXy9K
   LhrLZHLP9BnzjSeP1xRImAgXBlKgD8DkPBty7CE3DiN25wdXMkN1GTSZD
   ucffIRsVOBD5NsRCbkPa1XpfD/+XDcPBKOakQc2PmhDsXcIExGsy5EB+F
   gnvCU0uqJBZ0t+cSkdPoJywmn89rYTLZbeTVoZPoqCiMro2bLZdeNiZWp
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="262159522"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="262159522"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 09:55:44 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="590824572"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 09:55:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1negDs-001vud-Dz;
        Wed, 13 Apr 2022 19:52:04 +0300
Date:   Wed, 13 Apr 2022 19:52:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Allen Pais <apais@linux.microsoft.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 1/1] firmware: tee_bnxt: Use UUID API for exporting
 the UUID
Message-ID: <Ylb/tJKaPbskV1L8@smile.fi.intel.com>
References: <20220412113250.57997-1-andriy.shevchenko@linux.intel.com>
 <20220413164319.GA31604@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413164319.GA31604@lst.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 06:43:19PM +0200, Christoph Hellwig wrote:
> On Tue, Apr 12, 2022 at 02:32:50PM +0300, Andy Shevchenko wrote:

...

> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks!

-- 
With Best Regards,
Andy Shevchenko


