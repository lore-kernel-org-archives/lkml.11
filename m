Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BF0C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 20:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbiBVUA0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 15:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235385AbiBVT7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:59:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF778E7F6A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 11:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aRVJAANOsC10dJ0998zCbenF+8pqHZX+lNyjxaw/Qfk=; b=Z6c3tbfng6/e48jDlayJS7QvuT
        89RIH3AHlxz3EjtDqZMSU7Gt4J4we1XXPncRxY+nNaP52I+h1nL9mO4DIaj6149wVT1JmvG7eLNJz
        XpkRDzIlb0pkw91fSckO6vPAMZ7s9hA2rjqKHH2a2Y5STVeSeNXW0En0wF9FhIrpm+mg6n+QVVxPb
        ppqJeI3dEDD9XORTRGBDRmJwwusoQoXxbsuZDw5IBQVWlKUtQyTC/XBpR4KxZmiBAe/zYnKC8OYC4
        yP2o3jHdiVQmjRF2nTT1Uafzf5J6pwDmchP74pltAvknasYlvNFLondS8ZEBtuAj6bgCT8W5CuF2y
        NuDQqKLQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMbJU-0036Sc-Bq; Tue, 22 Feb 2022 19:59:08 +0000
Date:   Tue, 22 Feb 2022 19:59:08 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH 3/5] mm/slab: Do not call kmalloc_large() for unsupported
 size
Message-ID: <YhVAjMqYPNUBC4rY@casper.infradead.org>
References: <20220221105336.522086-1-42.hyeyoo@gmail.com>
 <20220221105336.522086-4-42.hyeyoo@gmail.com>
 <YhO1g3k00TeM8PTQ@casper.infradead.org>
 <YhSaeKIBNbG81I07@ip-172-31-19-208.ap-northeast-1.compute.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhSaeKIBNbG81I07@ip-172-31-19-208.ap-northeast-1.compute.internal>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 08:10:32AM +0000, Hyeonggon Yoo wrote:
> On Mon, Feb 21, 2022 at 03:53:39PM +0000, Matthew Wilcox wrote:
> > On Mon, Feb 21, 2022 at 10:53:34AM +0000, Hyeonggon Yoo wrote:
> > > SLAB's kfree() does not support freeing an object that is allocated from
> > > kmalloc_large(). Fix this as SLAB do not pass requests larger than
> > > KMALLOC_MAX_CACHE_SIZE directly to page allocator.
> > 
> > I was wondering if we wanted to go in the other direction and get rid of
> > kmalloc cache sizes larger than, say, 64kB from the SLAB allocator.
> 
> Good point.
> 
> Hmm.. I don't think SLAB is benefiting from queueing that large objects,
> and maximum size is still limited to what buddy allocator supports.
> 
> I'll try reducing kmalloc caches up to order-1 page like SLUB.
> That would be easier to maintain.

If you have time to investigate these kinds of things, I think SLUB would
benefit from caching order-2 and order-3 slabs as well.  Maybe not so much
now that Mel included order-2 and order-3 caching in the page allocator.
But it'd be interesting to have numbers.
