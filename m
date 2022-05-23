Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5AFC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 May 2022 22:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiEWWBb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 May 2022 18:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiEWWB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 18:01:28 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D392E19C2A
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 15:01:27 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 24NM1Kne029640;
        Tue, 24 May 2022 00:01:20 +0200
Date:   Tue, 24 May 2022 00:01:20 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [GIT PULL] nolibc changes for v5.19
Message-ID: <20220523220120.GG25949@1wt.eu>
References: <20220520182428.GA3791250@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wgpAHhPVSqBWb4gYT=CRJzKAZ4inmrL_kcpeNWGkcg3pg@mail.gmail.com>
 <20220523195605.GA13032@1wt.eu>
 <20220523202336.GB13032@1wt.eu>
 <CAHk-=wiX8P8atcx9at_N=-8pjU-d5cG509E=oZHfsVb1R41RZQ@mail.gmail.com>
 <20220523205043.GA25949@1wt.eu>
 <20220523210443.GD25949@1wt.eu>
 <CAHk-=wiFJKNPqLw1LW2pbfWxY50AGqBPJRMk2_KfpODD=-z5ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiFJKNPqLw1LW2pbfWxY50AGqBPJRMk2_KfpODD=-z5ng@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 02:13:20PM -0700, Linus Torvalds wrote:
(...)
> Does it work? No.
> 
> > work the same on all commands but actually:
> >
> >    make -C tools/ nolibc_headers
> 
> Put another way: where did you find that "nolibc_headers"?
> 
> THAT is what I'm talking about. You are mentioning all these magical
> things that don't match the documentation you yourself added.

OK thanks so now at least I have all the elements I was looking for,
I'm on it and will shortly provide fixes (in short, the main makefile's
variables not being set when doing make -C tools/ requires that some of
them are set as well under the target makefile).

For the second one I totally agree and as I said I think the problem
is wider, so I'll likely add a suggestion in tools/Makefile to also
try "make -C tools/ foo_help", which will allow different sub-projects
to provide a help target that enumerates their respective commands.
We'll start with nolibc and others could then follow, because clearly
for several other ones it's not obvious either and I think the lack
of standard way to display a tool's help doesn't help here.

thanks,
Willy
