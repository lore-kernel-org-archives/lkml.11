Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE6AC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jun 2022 15:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349466AbiFJPr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jun 2022 11:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349347AbiFJPrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 11:47:17 -0400
Received: from smtp8.emailarray.com (smtp8.emailarray.com [65.39.216.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16511203F7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 08:46:49 -0700 (PDT)
Received: (qmail 23031 invoked by uid 89); 10 Jun 2022 15:46:47 -0000
Received: from unknown (HELO localhost) (amxlbW9uQGZsdWdzdmFtcC5jb21AMTYzLjExNC4xMzIuNw==) (POLARISLOCAL)  
  by smtp8.emailarray.com with SMTP; 10 Jun 2022 15:46:47 -0000
Date:   Fri, 10 Jun 2022 08:46:45 -0700
From:   Jonathan Lemon <jonathan.lemon@gmail.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net-next v1 1/5] ptp_ocp: use dev_err_probe()
Message-ID: <20220610154645.ujvjvrdqvjwvvwoq@bsd-mbp.dhcp.thefacebook.com>
References: <20220608120358.81147-1-andriy.shevchenko@linux.intel.com>
 <20220608120358.81147-2-andriy.shevchenko@linux.intel.com>
 <20220609224523.78b6a6e6@kernel.org>
 <YqMmZBEsCv+f19se@smile.fi.intel.com>
 <20220610083918.65f3baeb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610083918.65f3baeb@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 08:39:18AM -0700, Jakub Kicinski wrote:
> On Fri, 10 Jun 2022 14:09:24 +0300 Andy Shevchenko wrote:
> > I have just checked that if you drop this patch the rest will be still
> > applicable. If you have no objections, can you apply patches 2-5 then?
> 
> It's tradition in netdev to ask people to repost. But looks completely
> safe for me to drop patch 1, so applied 2-5. Don't tell anyone I did this.

I see what you did there.  :)
-- 
Jonathan
