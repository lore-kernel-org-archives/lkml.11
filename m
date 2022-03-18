Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18402C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Mar 2022 16:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238448AbiCRQHY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Mar 2022 12:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238533AbiCRQHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:07:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694F52DF3C0;
        Fri, 18 Mar 2022 09:04:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B154621101;
        Fri, 18 Mar 2022 16:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647619489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NJ7rJ9a1MkPoaCF3v1N1Mm2BXlsL1if5z9Q1yyTlgQc=;
        b=Muo3o4Zg5mXCsjft5ZqW+yfRZ/1bGpADvnHiFhfcVtp0VpxbBDk3x4rL+bw3lo6zsiCl+F
        Mz46/+y2/rsHKOUnqU5Bw84dNFfrM/RxdSs1eAwg4pZawQo9mUAexd0IjrCOe7BGdb/aWM
        ucAHHvd02HMAoEnWfVTUf1pwaPIbHdE=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 40E27A3B8A;
        Fri, 18 Mar 2022 16:04:49 +0000 (UTC)
Date:   Fri, 18 Mar 2022 17:04:45 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gary Guo <gary@garyguo.net>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v5 12/20] vsprintf: add new `%pA` format specifier
Message-ID: <YjStnb7nNTC3kYw6@alley>
References: <20220317181032.15436-1-ojeda@kernel.org>
 <20220317181032.15436-13-ojeda@kernel.org>
 <YjSSI4cmGblm+6j7@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjSSI4cmGblm+6j7@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-03-18 16:07:31, Andy Shevchenko wrote:
> On Thu, Mar 17, 2022 at 07:10:00PM +0100, Miguel Ojeda wrote:
> > From: Gary Guo <gary@garyguo.net>
> > 
> > This patch adds a format specifier `%pA` to `vsprintf` which formats
> > a pointer as `core::fmt::Arguments`. Doing so allows us to directly
> > format to the internal buffer of `printf`, so we do not have to use
> > a temporary buffer on the stack to pre-assemble the message on
> > the Rust side.
> > 
> > This specifier is intended only to be used from Rust and not for C, so
> > `checkpatch.pl` is intentionally unchanged to catch any misuse.
> 
> ...
> 
> > +	case 'A':
> > +		if (!IS_ENABLED(CONFIG_RUST)) {
> > +			WARN_ONCE(1, "Please remove %%pA from non-Rust code\n");
> > +			return error_string(buf, end, "(%pA?)", spec);
> > +		}
> 
> I'm wondering if the Big Scary Banner as trace_printk() does would be better
> (in case we can tell that %pA is used in the code when RUST=n).

Good question!

The advantage of WARN_ONCE() is that it shows the stack so that it is
easier to locate the caller.

On the other hand, WARN_ONCE() is a bit misused here. It should be
used only in situations that might be potentially fatal. It might
even cause panic() with "panic_on_warn" kernel parameter.

Well, I am not sure if it is worth huge effort. WARN_ONCE() is
practical in this case because of the backtrace. We could always
create something better if people hit it more frequently and
it causes real life problems.

Best Regards,
Petr
