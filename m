Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806C6C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Apr 2022 16:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbiDMQ55 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Apr 2022 12:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiDMQ5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:57:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED62694BC;
        Wed, 13 Apr 2022 09:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649868931; x=1681404931;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qKLsSmM8C2ANbxcduOTHPpWcCwOoYNAktF5KlwQD/vg=;
  b=hRY2N2dykpEvQo9nFLdi1vc/NodeFY2bpyljvdyFY1Qw+wjz3u5xzURP
   gDWEk/tNZI6tCbix3wZO8bajRAAuUjpvhIWqpmtEg3fhUzyix33IcpS0Z
   g09VdQkocXQj7Z+n+O1VDAbNy1gynpnKqIOZr1kv7uI3UnP82VA6x8hst
   AgUrTl/Lv1RPSWug2jIsU6nbPdUnWvlxl8nmkV9Y9JrosHQMFtSmu/X/2
   SgXeFD97ZG6Ssyprn+muo0JMYTspVgcVFIzn75ESBKCz0tSxOPjWHkDfB
   nWC88qY4EfF6bpk2nolZrwZkfXHzE2WsX7kZbxaOf9n9JCFdFuurhuSv7
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="262159465"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="262159465"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 09:55:30 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="508050744"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 09:55:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1negDd-001vtf-J4;
        Wed, 13 Apr 2022 19:51:49 +0300
Date:   Wed, 13 Apr 2022 19:51:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Allen Pais <apais@linux.microsoft.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 1/1] firmware: tee_bnxt: Use UUID API for exporting
 the UUID
Message-ID: <Ylb/pczsmQWCD3bz@smile.fi.intel.com>
References: <20220412113250.57997-1-andriy.shevchenko@linux.intel.com>
 <e9c81a3d-d03a-5b13-ee14-9ba6103093f7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9c81a3d-d03a-5b13-ee14-9ba6103093f7@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 08:38:41AM -0700, Florian Fainelli wrote:
> On 4/12/2022 4:32 AM, Andy Shevchenko wrote:

...

> > v3: rebased on the latest vanilla, added Andrew since it has no move for 1y+
> 
> I don't think this is going to be picked up unless we designate a entry in
> the MAINTAINERS file, I don't mind taking this via the Broadcom ARM SoCs
> pull request if this does not move.

Please do, seems above mentioned tree is the best choice for this driver.

Thanks!

-- 
With Best Regards,
Andy Shevchenko


