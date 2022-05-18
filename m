Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8844C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 18 May 2022 13:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237562AbiERNOA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 May 2022 09:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237454AbiERNN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:13:57 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32801B0924
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:13:56 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9033A68AFE; Wed, 18 May 2022 15:13:53 +0200 (CEST)
Date:   Wed, 18 May 2022 15:13:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, hch@lst.de, m.szyprowski@samsung.com,
        chenxiang66@hisilicon.com, thunder.leizhen@huawei.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        liyihang6@hisilicon.com
Subject: Re: [RFC PATCH] dma-iommu: Add iommu_dma_max_mapping_size()
Message-ID: <20220518131353.GB26019@lst.de>
References: <1652706361-92557-1-git-send-email-john.garry@huawei.com> <f5b78c9c-312e-70ab-ecbb-f14623a4b6e3@arm.com> <9160031b-50be-6993-5a8e-f238391962c5@huawei.com> <8f193bdd-3a0a-f9ed-0726-e6081f374320@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f193bdd-3a0a-f9ed-0726-e6081f374320@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 01:02:00PM +0100, Robin Murphy wrote:
>> So how to inform the SCSI driver of this caching limit then so that it may 
>> limit the SGL length?
>
> Driver-specific mechanism; block-layer-specific mechanism; redefine this 
> whole API to something like dma_opt_mapping_size(), as a limit above which 
> mappings might become less efficient or start to fail (callback to my 
> thoughts on [1] as well, I suppose); many options. Just not imposing a 
> ridiculously low *maximum* on everyone wherein mapping calls "should not be 
> larger than the returned value" when that's clearly bollocks.

Well, for swiotlb it is a hard limit.  So if we want to go down that
route we need two APIs, one for the optimal size and one for the
hard limit.
