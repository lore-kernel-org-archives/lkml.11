Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCB4C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Apr 2022 13:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350329AbiDZNWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Apr 2022 09:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347888AbiDZNWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:22:49 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE44713975F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:19:42 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="352015460"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="352015460"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 06:19:42 -0700
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="730245502"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 06:19:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1njL6P-008Kz0-6l;
        Tue, 26 Apr 2022 16:19:37 +0300
Date:   Tue, 26 Apr 2022 16:19:36 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        device-mapper development <dm-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Snitzer <msnitzer@redhat.com>,
        Milan Broz <gmazyland@gmail.com>
Subject: Re: [PATCH v2] hex2bin: fix access beyond string end
Message-ID: <YmfxaB1j65p8dOyj@smile.fi.intel.com>
References: <alpine.LRH.2.02.2204241643030.17244@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHp75VdHnvv6FH1BKcs8WgGF3nJpj77TsrmsQGBSpsAQU_S-bw@mail.gmail.com>
 <alpine.LRH.2.02.2204260759540.2737@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2204260759540.2737@file01.intranet.prod.int.rdu2.redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 08:07:44AM -0400, Mikulas Patocka wrote:
> On Tue, 26 Apr 2022, Andy Shevchenko wrote:
> > On Sun, Apr 24, 2022 at 10:48 PM Mikulas Patocka <mpatocka@redhat.com> wrote:

...

> > You need to provide a Fixes tag.
> 
> OK. Here I resend it with the "Fixes" tag.

Still shadows error codes.

> +			return -EINVAL;

>  			return -EINVAL;

-- 
With Best Regards,
Andy Shevchenko


