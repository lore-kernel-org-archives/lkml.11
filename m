Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F29C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Apr 2022 05:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbiDMFwA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Apr 2022 01:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbiDMFv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 01:51:57 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AD51160
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 22:49:37 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AD46968B05; Wed, 13 Apr 2022 07:49:33 +0200 (CEST)
Date:   Wed, 13 Apr 2022 07:49:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chao Gao <chao.gao@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        m.szyprowski@samsung.com,
        Wang Zhaoyang1 <zhaoyang1.wang@intel.com>,
        Gao Liang <liang.gao@intel.com>,
        Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH] dma-direct: avoid redundant memory sync for swiotlb
Message-ID: <20220413054933.GA32020@lst.de>
References: <20220412113805.3210-1-chao.gao@intel.com> <e25fbb7e-a67e-5421-b7be-700fd0209b0d@arm.com> <20220413010157.GA10502@gao-cwp> <20220413045958.GA31209@lst.de> <20220413054600.GA23023@gao-cwp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413054600.GA23023@gao-cwp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 01:46:06PM +0800, Chao Gao wrote:
> On Wed, Apr 13, 2022 at 06:59:58AM +0200, Christoph Hellwig wrote:
> >So for now I'd be happy with the one liner presented here, but
> >eventually the whole area could use an overhaul.
> 
> Thanks. Do you want me to post a new version with the Fixes tag or you
> will take care of it?

I can add the fixes tag.  I'll wait another day or two for more feedback,
though.

> 
> Fixes: 55897af63091 ("dma-direct: merge swiotlb_dma_ops into the dma_direct code")
---end quoted text---
