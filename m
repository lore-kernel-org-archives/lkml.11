Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08253C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 15:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244969AbiFGPLp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 11:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343871AbiFGPLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:11:39 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0553F3380
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 08:11:38 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 257F47UF002507;
        Tue, 7 Jun 2022 10:04:08 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 257F46r6002505;
        Tue, 7 Jun 2022 10:04:06 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 7 Jun 2022 10:04:06 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: outside array bounds error on ppc64_defconfig, GCC 12.1.0
Message-ID: <20220607150406.GF25951@gate.crashing.org>
References: <YpbUcPrm61RLIiZF@debian.me> <87mtepns81.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtepns81.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 12:05:18PM +1000, Michael Ellerman wrote:
> > arch/powerpc/lib/sstep.c:287:23: error: array subscript [3, 4] is outside array bounds of 'union <anonymous>[1]' [-Werror=array-bounds]
> >   287 |                 up[3] = tmp;
> >       |                 ~~~~~~^~~~~
> 
> This happens because we have a generic byte reverse function
> (do_byte_reverse()), that takes a size as a parameter. So it will
> reverse 8, 16, 32 bytes etc.
> 
> In some cases the compiler can see that we're passing a pointer to
> storage that is smaller than 32 bytes, but it isn't convinced that the
> size parameter is also smaller than 32 bytes.
> 
> Which I think is reasonable, the code that sets the size is separate
> from this code, so the compiler can't really deduce that it's safe.
> 
> I don't see a really simple fix. I tried clamping the size parameter to
> do_byte_reverse() with max(), but that didn't work :/

-Wno-error or at least -Wno-error=array-bounds is a good, simple fix.


Segher
