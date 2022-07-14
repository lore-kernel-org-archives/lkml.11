Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D08C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jul 2022 09:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238352AbiGNJkd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jul 2022 05:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238127AbiGNJkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:40:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6768246DA0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=MX1HLjZl06EVeBckFH+LH0/sb/LjoVBfdYkNEHMl7Ds=; b=jTGiw/CXC6l9jPjUkP0G7dK9K+
        kF+Y/rvE8V3do1tcA1zdDJQjueM7tMxxjjPKTKBd5IEmS6fS3cKqW5NLdSnx4PX9ULYUOg87KHuDR
        Hedr0YnwcUKf7u7+iwV0gNC/ckeKvPtYUhCp8q1wlgMk4azI/HpqmB3uB1zplBPwnlL4/O0ero9i3
        6o4ZU7OI5zmBFOfWqsslrC6e2TCUWJqsqmZVbinicKV8/SAfoph+Ll0LAsn0YLble7j+xf72spUyR
        F2UdPFbdwh6xHnChesgRhIsNkcYSzSF31Cl3+Mp++a0DRFHglmxEerjv78JiF/nZJjPQcLi7DHyn5
        0tug9oxA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBvKV-009GGg-0q; Thu, 14 Jul 2022 09:40:19 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C9440980120; Thu, 14 Jul 2022 11:40:12 +0200 (CEST)
Date:   Thu, 14 Jul 2022 11:40:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, lkft-triage@lists.linaro.org,
        Borislav Petkov <bp@suse.de>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: RETBleed: WARNING: Spectre v2 mitigation leaves CPU vulnerable
 to RETBleed attacks, data leaks possible!
Message-ID: <Ys/kfDk7mVE09N3L@worktop.programming.kicks-ass.net>
References: <CA+G9fYv0N0FcYRp5irO_7TpheLcUY8LRMQbcZqwEmiRTEccEjA@mail.gmail.com>
 <Ys/bWIk0F5srkkpF@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ys/bWIk0F5srkkpF@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 11:01:12AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Jul 14, 2022 at 02:15:07PM +0530, Naresh Kamboju wrote:
> > Results from Linaro’s test farm.
> > 
> > We are booting the i386 kernel on an x86 machine.
> > With Spectre V2 patches merged into Linux mainline we have been noticing
> > RETBleed: WARNING: Spectre v2 mitigation leaves CPU vulnerable to
> > RETBleed attacks, data leaks possible!
> 
> That's funny.  I don't think that's a valid combination that should be
> cared about, but I'll leave it to Pawan to comment if it is something
> that is "real" to be concerned for.

Yeah, so far nobody cared to fix 32bit. If someone *realllllly* cares
and wants to put the effort in I suppose I'll review the patches, but
seriously, you shouldn't be running 32bit kernels on Skylake / Zen based
systems, that's just silly.
