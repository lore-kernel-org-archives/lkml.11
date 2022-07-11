Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD40C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jul 2022 16:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiGKQzQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jul 2022 12:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiGKQzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 12:55:13 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78D8D3E762
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:55:10 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 26BGorGZ007522;
        Mon, 11 Jul 2022 11:50:54 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 26BGort6007521;
        Mon, 11 Jul 2022 11:50:53 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 11 Jul 2022 11:50:53 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 2/5] powerpc/32: Don't always pass -mcpu=powerpc to the compiler
Message-ID: <20220711165053.GF25951@gate.crashing.org>
References: <8abab4888da69ff78b73a56f64d9678a7bf684e9.1657549153.git.christophe.leroy@csgroup.eu> <d4df724691351531bf46d685d654689e5dfa0d74.1657549153.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4df724691351531bf46d685d654689e5dfa0d74.1657549153.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 04:19:30PM +0200, Christophe Leroy wrote:
> Since commit 4bf4f42a2feb ("powerpc/kbuild: Set default generic
> machine type for 32-bit compile"), when building a 32 bits kernel
> with a bi-arch version of GCC, or when building a book3s/32 kernel,
> the option -mcpu=powerpc is passed to GCC at all time, relying on it
> being eventually overriden by a subsequent -mcpu=xxxx.
> 
> But when building the same kernel with a 32 bits only version of GCC,
> that is not done, relying on gcc being built with the expected default
> CPU.
> 
> This logic has two problems. First, it is a bit fragile to rely on
> whether the GCC version is bi-arch or not, because today we can have
> bi-arch versions of GCC configured with a 32 bits default. Second,
> there are some versions of GCC which don't support -mcpu=powerpc,
> for instance for e500 SPE-only versions.

More fundamentally, the *only* thing you should check biarch for is
for determining if you can use both -m32 and -m64 with the same
compiler.  Everything behaves identically in a biarch and a non-biarch
compiler, other than the latter screams bloody murder if you try to
change the architecture from 32 to 64 bit or vice versa.

> So, stop relying on this approximative logic and allow the user to
> decide whether he/she wants to use the toolchain's default CPU or if
> he/she wants to set one, and allow only possible CPUs based on the
> selected target.
> 
> Reported-by: Pali Rohár <pali@kernel.org>
> Tested-by: Pali Rohár <pali@kernel.org>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Segher Boessenkool <segher@kernel.crashing.org>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>

Looks good to me.  This untangles/demystifies quite some code :-)


Segher
