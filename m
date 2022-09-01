Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7F7ECAAD3
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Sep 2022 13:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbiIANUb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Sep 2022 09:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbiIANTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:19:52 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38A0EAC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 06:18:49 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="295718673"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="295718673"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 06:18:49 -0700
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="563460497"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 06:18:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1oTk3e-006tEK-2N;
        Thu, 01 Sep 2022 16:16:34 +0300
Date:   Thu, 1 Sep 2022 16:16:34 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] regmap: introduce value tracing for regmap bulk
 operations
Message-ID: <YxCwstzaKm7qhCWV@smile.fi.intel.com>
References: <20220816181451.5628-1-ddrokosov@sberdevices.ru>
 <CAHp75VfSOL5R1JdH-RS4PEXT1dEwuFGsmUPfkAp7zdDEMGzzjw@mail.gmail.com>
 <20220831004530.zhvd7ehndqwmqgve@Rockosov-MBP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831004530.zhvd7ehndqwmqgve@Rockosov-MBP>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 03:45:30AM +0300, Dmitry Rokosov wrote:

...

> > > +               if (val)
> > > +                       memcpy(__get_dynamic_array(buf), val, val_len);
> > 
> > I'm probably missing something, but what this condition prevents from?
> 
> In general, this condition prevents memcpy from being executed when
> tracepoint is called with a null pointed buffer.

If we got a NULL pointer here, we already in a lot of troubles.
I believe the check is not needed.

Otherwise the function prints garbage.

I will send a series to remove that and clean up the file.

-- 
With Best Regards,
Andy Shevchenko


