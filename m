Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525D3C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Apr 2022 09:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbiDHJUk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Apr 2022 05:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbiDHJOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:14:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3660B1E4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 02:11:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C7A761C47
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 09:11:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C19BC385A3;
        Fri,  8 Apr 2022 09:11:51 +0000 (UTC)
Date:   Fri, 8 Apr 2022 10:11:47 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] mm/slab: Decouple ARCH_KMALLOC_MINALIGN from
 ARCH_DMA_MINALIGN
Message-ID: <Yk/8U9WLd06CLyMa@arm.com>
References: <20220405135758.774016-1-catalin.marinas@arm.com>
 <20220405135758.774016-2-catalin.marinas@arm.com>
 <Yk/ZRTggY3wZ00o4@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk/ZRTggY3wZ00o4@hyeyoo>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 03:42:13PM +0900, Hyeonggon Yoo wrote:
> On Tue, Apr 05, 2022 at 02:57:49PM +0100, Catalin Marinas wrote:
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index 373b3ef99f4e..d58211bdeceb 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -187,17 +187,30 @@ bool kmem_valid_obj(void *object);
> >  void kmem_dump_obj(void *object);
> >  #endif
> >  
> > +/*
> > + * slob does not support independent control of ARCH_KMALLOC_MINALIGN and
> > + * ARCH_DMA_MINALIGN.
> > + */
> > +#ifdef CONFIG_SLOB
> > +#undef ARCH_KMALLOC_MINALIGN
> > +#endif
> 
> I think you should replace ARCH_KMALLOC_MINALIGN with ARCH_DMA_MINALIGN
> in mm/slob.c too? Or detect minimum kmalloc alignment in runtime like SLAB/SLUB?

One step at a time. The slob approach is a bit different, doesn't
generate kmalloc-* caches, so I did not look at it yet. Also based on
Vlastimil's email, there is some reworking going on in there already.

> current code seem to break with SLOB on machines that has 128 byte cache lines
> because ARCH_KMALLOC_MINALIGN is 64?

Does it? The point of the #undef above was precisely to make sure
ARCH_KMALLOC_MINALIGN stays the same as ARCH_DMA_MINALIGN when
CONFIG_SLOB is enabled.

-- 
Catalin
