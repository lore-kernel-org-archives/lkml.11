Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7F6C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Feb 2022 14:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359381AbiBDOmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Feb 2022 09:42:22 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43692 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbiBDOmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 09:42:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB036B83743
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 14:42:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A89C004E1;
        Fri,  4 Feb 2022 14:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643985738;
        bh=TwXD7tWstaryhVZtIAOSczNJa9Bq/OTxOzYseqNrG44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IcU20drU506bBQz+c/byrc7Iuo3EUGAZBq+hUtVS653a0kdZV3+u6tEGNAotzEz3O
         LmQMwa5MN72Z1Pq2+lX/6mfv/Iy39SPX7+LTGb6B3jJozyRZi3RGg+3eurZ8htQWiI
         vkZZvuDZJv1jMymNezqDkRcyHtEmPbzZiLlldtH0=
Date:   Fri, 4 Feb 2022 15:42:15 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] tty: Drop duplicate NULL check in TTY port
 functions
Message-ID: <Yf07R9xdUtmcHU7m@kroah.com>
References: <20220202165704.5680-1-andriy.shevchenko@linux.intel.com>
 <37e31d03-eee6-7052-fe32-1f37f1b460e1@kernel.org>
 <YfuxANmSQDfIQZO4@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfuxANmSQDfIQZO4@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 12:40:00PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 03, 2022 at 09:36:55AM +0100, Jiri Slaby wrote:
> > On 02. 02. 22, 17:57, Andy Shevchenko wrote:
> > > The free_page(addr), which becomes free_pages(addr, 0) checks addr against 0.
> > > No need to repeat this check in the callers, i.e.  tty_port_free_xmit_buf()
> > > and tty_port_destructor().
> > > 
> > > Note, INIT_KFIFO() is safe without that check, because it's aware of kfifo PTR
> > > versus embedded kfifo.
> > 
> > Not sure what you mean here ^^^? But it might be one of the morning brain
> > parser errors.
> 
> Or maybe my evening weren't working...
> 
> Actually INIT_KFIFO() can be outside of that check from day 1 because it
> operates on a separate member and does not rely on the FIFO itself to be
> allocated.
> 
> I tried to explain that, while kfifo allocation goes together with buffer,
> there is no dependency to any of those allocations.

Can you rewrite the changelog to say this?

thanks,

greg k-h
