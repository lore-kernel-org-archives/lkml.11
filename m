Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A21CC43334
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jul 2022 17:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbiGRRxz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jul 2022 13:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbiGRRxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 13:53:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA681B4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 10:53:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD894B816D9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:53:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7CC5C341CA;
        Mon, 18 Jul 2022 17:53:46 +0000 (UTC)
Date:   Mon, 18 Jul 2022 18:53:43 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Isaac Manjarres <isaacmanjarres@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Saravana Kannan <saravanak@google.com>, kernel-team@android.com
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of
 ARCH_KMALLOC_MINALIGN
Message-ID: <YtWeJ12GI7LxQ4IK@arm.com>
References: <CAMj1kXFW_zC-U5Ox9_=4gKCwWOmkR7wPNb6UQhiz8viNWTRU-w@mail.gmail.com>
 <YlkkGpVx8rhcsBot@gondor.apana.org.au>
 <YllALIgZcQJ6asdA@arm.com>
 <YlllpH+PB8XVUn6h@arm.com>
 <YlvLqkIdrCp/rOsG@gondor.apana.org.au>
 <YlvSEHul1Rv3Ap34@arm.com>
 <YlvTNQGh+MfZFWKW@gondor.apana.org.au>
 <YlxATW56ZoNtmxlk@arm.com>
 <YtHo3Xu33jovwpFt@google.com>
 <YtIvr7t8A/OlIXrT@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtIvr7t8A/OlIXrT@gondor.apana.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2022 at 11:25:35AM +0800, Herbert Xu wrote:
> On Fri, Jul 15, 2022 at 03:23:25PM -0700, Isaac Manjarres wrote:
> > isn't present. So, the current behavior that crypto is relying on
> > wouldn't change, so I agree with Catalin that we wouldn't be lying to
> > the compiler if we move forward with getting rid of kmalloc-192.
> 
> There is no guarantee that crypto will always be allocating
> structures > 128 bytes.
> 
> But thanks for the reminder, I do need to push the patches along.

So do I but holidays get in the way ;). I plan to refresh my kmalloc
minalign series at the end of August.

One significant change I have though is that now ARCH_KMALLOC_MINALIGN
now goes down all the way to 8 and using swiotlb bounce buffering if the
DMA mapping size is small.

-- 
Catalin
