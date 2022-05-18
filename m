Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3DFC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 18 May 2022 18:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiERSIb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 May 2022 14:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiERSI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 14:08:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4665192D20
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 11:08:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6E846183B
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 18:08:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D57EC385A5;
        Wed, 18 May 2022 18:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652897307;
        bh=NKLArhvSMJ+eTtwjpjJn4zYvxBCIx4zp3zfmUSJsCz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m9QgQlMPA88JyHOjCpXqTEHAI5k7GI3nMEc5zAVWHwkyRK6AbRFmVvfyMEkRezMhI
         7paFj8sfM3qjWluxE2KuhCrsVw/5iHTAy/xYLrc+kguxv2/mEaaoqAmm61yV5pBibw
         6yYS7wPS6rkeVCOY6Kel9eGKzS7Os5LGrzuhnU4Xe6icAc8Dcffn/XgOfCysG1Iwjj
         uv8kFWpntTdM9Zx6MoQjovd8DxaL54xZLxcpkcaGql+QRqLg48HDHZ85jTAoYYgDPs
         J50+m5LAcgGdIBxkxdFkIozlMPrUuRMYn0SbSm+ZEs8Znen8DHV/vYhTtTJCCfjqB6
         guWfAd0d7BgQw==
Date:   Wed, 18 May 2022 11:08:25 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] objtool: fix objtool regression on x32 systems
Message-ID: <20220518180825.k4pvac42dlfdgdkd@treble>
References: <alpine.LRH.2.02.2205161041260.11556@file01.intranet.prod.int.rdu2.redhat.com>
 <YoJwtCeVzYUm6Uhg@hirez.programming.kicks-ass.net>
 <alpine.LRH.2.02.2205161145070.30905@file01.intranet.prod.int.rdu2.redhat.com>
 <20220516212517.GP76023@worktop.programming.kicks-ass.net>
 <alpine.LRH.2.02.2205180813200.22292@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2205180813200.22292@file01.intranet.prod.int.rdu2.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 09:28:57AM -0400, Mikulas Patocka wrote:
> 
> 
> On Mon, 16 May 2022, Peter Zijlstra wrote:
> 
> > On Mon, May 16, 2022 at 11:56:21AM -0400, Mikulas Patocka wrote:
> > > 
> > > With this patch, the compiled kernel works. With kernels 5.17 or older, it 
> > > also works. I bisected it and the breakage is caused by the commit 
> > > 4abff6d48dbc.
> > 
> > Sure; but it works doesn't mean there aren't more latent issues. ILP32
> > hosted (cross) builds just aren't a thing I've ever considered. If we
> > really want to go support that then we should at least audit the whole
> > thing.
> > 
> > A quick look seems to suggest at least all the 'offset' fields should be
> > u64 or something. The only reason that works is because -mcmodel=kernel
> > keeps everything in the 2G range to make s32 immediates work. But it
> > isn't right.
> 
> There are many 'offset' variables and its hard to determine which should 
> be 64-bit. Would it be possible to commit this patch, so that kernel 5.18 
> can be compiled on x32 distributions? And you can do code refactoring in 
> the next merge window.

I believe Peter is going ahead with merging this for 5.18, and your v2
looks identical to what he already has here:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=objtool/urgent

-- 
Josh
