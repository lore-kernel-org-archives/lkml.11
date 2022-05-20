Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429F4C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 May 2022 08:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347400AbiETIwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 May 2022 04:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344968AbiETIwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:52:01 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C335DD00
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 01:52:00 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id BC47C1E9; Fri, 20 May 2022 10:51:58 +0200 (CEST)
Date:   Fri, 20 May 2022 10:51:57 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>, will@kernel.org,
        m.szyprowski@samsung.com, chenxiang66@hisilicon.com,
        thunder.leizhen@huawei.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, liyihang6@hisilicon.com
Subject: Re: [RFC PATCH] dma-iommu: Add iommu_dma_max_mapping_size()
Message-ID: <YodWrRFircbmh1bN@8bytes.org>
References: <1652706361-92557-1-git-send-email-john.garry@huawei.com>
 <f5b78c9c-312e-70ab-ecbb-f14623a4b6e3@arm.com>
 <9160031b-50be-6993-5a8e-f238391962c5@huawei.com>
 <8f193bdd-3a0a-f9ed-0726-e6081f374320@arm.com>
 <20220518131353.GB26019@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518131353.GB26019@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 03:13:53PM +0200, Christoph Hellwig wrote:
> On Tue, May 17, 2022 at 01:02:00PM +0100, Robin Murphy wrote:
> >> So how to inform the SCSI driver of this caching limit then so that it may 
> >> limit the SGL length?
> >
> > Driver-specific mechanism; block-layer-specific mechanism; redefine this 
> > whole API to something like dma_opt_mapping_size(), as a limit above which 
> > mappings might become less efficient or start to fail (callback to my 
> > thoughts on [1] as well, I suppose); many options. Just not imposing a 
> > ridiculously low *maximum* on everyone wherein mapping calls "should not be 
> > larger than the returned value" when that's clearly bollocks.
> 
> Well, for swiotlb it is a hard limit.  So if we want to go down that
> route we need two APIs, one for the optimal size and one for the
> hard limit.

I agree with Robin, and if it really helps some drivers I am all for
doing a dma_opt_mapping_size() instead. Limiting DMA mapping sizes to
make drivers perform better gets a clear NAK from my side.

Regards,

	Joerg
