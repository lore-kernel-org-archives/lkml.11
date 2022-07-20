Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552E8C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jul 2022 04:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiGTEy6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jul 2022 00:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGTEyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 00:54:55 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2313866BB6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 21:54:52 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 26K4soLE003307;
        Wed, 20 Jul 2022 06:54:50 +0200
Date:   Wed, 20 Jul 2022 06:54:50 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        "Fernanda Ma'rouf" <fernandafmr12@gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH nolibc v1] selftests/nolibc: Avoid generated files being
 committed
Message-ID: <20220720045450.GF3106@1wt.eu>
References: <20220720033745.GC3106@1wt.eu>
 <20220720035940.GD1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720035940.GD1790663@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 08:59:40PM -0700, Paul E. McKenney wrote:
> On Wed, Jul 20, 2022 at 05:37:45AM +0200, Willy Tarreau wrote:
> > From: "Fernanda Ma'rouf" <fernandafmr12@gnuweeb.org>
> > 
> > After running the nolibc tests, the "git status" is not clean because
> > the generated files are not ignored. Create a `.gitignore` inside the
> > selftests/nolibc directory to ignore them.
> > 
> > Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> > Cc: Fernanda Ma'rouf <fernandafmr2@gmail.com>
> > Signed-off-by: Fernanda Ma'rouf <fernandafmr12@gnuweeb.org>
> > Signed-off-by: Willy Tarreau <w@1wt.eu>
> > ---
> > 
> > Paul,
> > 
> > Fernanda sent me this which I think is a desirable cleanup to the
> > series I sent you. If you're fine with adding it on top of what you
> > already have, that's great. Otherwise I can queue it here for next
> > time, but this should improve the user's experience.
> 
> I queued it on top of the others.  ;-)

Thank you!
Willy
