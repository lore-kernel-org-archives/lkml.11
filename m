Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8444EC433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 May 2022 08:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbiEQIhG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 04:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiEQIhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:37:02 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE0A65BC
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:37:01 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C2D2667373; Tue, 17 May 2022 10:36:57 +0200 (CEST)
Date:   Tue, 17 May 2022 10:36:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH] iommu/dma: Fix check for error return from
 iommu_map_sg_atomic()
Message-ID: <20220517083657.GA16377@lst.de>
References: <20220513153948.310119-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513153948.310119-1-schnelle@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 05:39:48PM +0200, Niklas Schnelle wrote:
> In __iommu_dma_alloc_noncontiguous() the value returned by
> iommu_map_sg_atomic() is checked for being smaller than size. Before
> commit ad8f36e4b6b1 ("iommu: return full error code from
> iommu_map_sg[_atomic]()") this simply checked if the requested size was
> successfully mapped.
> 
> After that commit iommu_map_sg_atomic() may also return a negative
> error value. In principle this too would be covered by the existing
> check. There is one problem however, as size is of type size_t while the
> return type of iommu_map_sg_atomic() is now of type ssize_t the latter gets
> converted to size_t and negative error values end up as very large
> positive values making the check succeed. Fix this by making the return
> type visible with a local variable and add an explicit cast to ssize_t.
> 
> Fixes: ad8f36e4b6b1 ("iommu: return full error code from iommu_map_sg[_atomic]()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

I don't see what the point of the newly added local variable is here.
Just casting size should be all that is needed as far as I can tell.
