Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49414C433FE
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 12:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiDFMuH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 08:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbiDFMth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:49:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEB048B848
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:53:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49F4061372
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 08:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A69C385A5;
        Wed,  6 Apr 2022 08:53:05 +0000 (UTC)
Date:   Wed, 6 Apr 2022 09:53:02 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, cl@linux.com, vbabka@suse.cz,
        iamjoonsoo.kim@lge.com, rientjes@google.com, penberg@kernel.org,
        roman.gushchin@linux.dev
Subject: Re: [PATCH 01/10] mm/slab: Decouple ARCH_KMALLOC_MINALIGN from
 ARCH_DMA_MINALIGN
Message-ID: <Yk1U7gpxNtlpQfmk@arm.com>
References: <20220405135758.774016-1-catalin.marinas@arm.com>
 <20220405135758.774016-2-catalin.marinas@arm.com>
 <YkzX1nM0Ca7apVBt@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkzX1nM0Ca7apVBt@hyeyoo>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 08:59:18AM +0900, Hyeonggon Yoo wrote:
> On Tue, Apr 05, 2022 at 02:57:49PM +0100, Catalin Marinas wrote:
> > In preparation for supporting a dynamic kmalloc() minimum alignment,
> > allow architectures to define ARCH_KMALLOC_MINALIGN independently of
> > ARCH_DMA_MINALIGN. In addition, always define ARCH_DMA_MINALIGN even if
> > an architecture does not override it.
> 
> [ +Cc slab maintainer/reviewers ]
> 
> I get why you want to set minimum alignment of kmalloc() dynamically.
> That's because cache line size can be different and we cannot statically
> know that, right?
> 
> But I don't get why you are trying to decouple ARCH_KMALLOC_MINALIGN
> from ARCH_DMA_MINALIGN. kmalloc'ed buffer is always supposed to be DMA-safe.

Arnd already replied. With this series, kmalloc'ed buffers are still
DMA-safe for the SoC the kernel is running on.

-- 
Catalin
