Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2966FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 11:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241892AbiDLLk4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 07:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355644AbiDLLj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:39:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E097949925
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:20:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEACD618BB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 10:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E7EC385A5;
        Tue, 12 Apr 2022 10:20:12 +0000 (UTC)
Date:   Tue, 12 Apr 2022 11:20:08 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of
 ARCH_KMALLOC_MINALIGN
Message-ID: <YlVSWGxIUQq8rk0s@arm.com>
References: <Yk5o/lNTyiJWD4Ae@gondor.apana.org.au>
 <Yk7EbvYhwnQy+pAf@arm.com>
 <Yk7Ny/iFi0NrMXTg@gondor.apana.org.au>
 <Yk8RGvF6ik34C6BO@arm.com>
 <Yk+rKWEcc9rO+A25@gondor.apana.org.au>
 <Yk/6ts5sVDMDpKj3@arm.com>
 <Yk/8QExHlggU8KgC@gondor.apana.org.au>
 <YlVHSvkyUBXZPUr2@arm.com>
 <YlVJKjXkcHqkwyt4@gondor.apana.org.au>
 <YlVOTsaTVkBOxthG@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlVOTsaTVkBOxthG@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 11:02:54AM +0100, Catalin Marinas wrote:
> On Tue, Apr 12, 2022 at 05:40:58PM +0800, Herbert Xu wrote:
> > I think if CRYPTO_MINALIGN makes those drivers work then so
> > should cra_alignmask.  And that would be a relatively easy
> > patch to do.
> 
> Yes, the patch would be simple, subject to figuring out which drivers
> and what alignment they actually need (any help appreciated).
> 
> There are already arm64 vendor kernels that change ARCH_DMA_MINALIGN to
> 64, hence ARCH_KMALLOC_MINALIGN and CRYPTO_MINALIGN become 64. We also
> discussed a Kconfig option for this in the past. Would that have broken
> any crypto drivers that rely on a strict 128 byte alignment?

Actually, I think with a cra_alignmask of 127 (the arm64
CRYPTO_MINALIGN-1), crypto_check_alg() will fail since
MAX_ALGAPI_ALIGNMASK is 63.

-- 
Catalin
