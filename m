Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BD2C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 May 2022 13:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237538AbiERNMx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 May 2022 09:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237484AbiERNMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:12:47 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477BB93451
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:12:41 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 63B0568AFE; Wed, 18 May 2022 15:12:37 +0200 (CEST)
Date:   Wed, 18 May 2022 15:12:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, hch@lst.de, m.szyprowski@samsung.com,
        chenxiang66@hisilicon.com, thunder.leizhen@huawei.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        liyihang6@hisilicon.com
Subject: Re: [RFC PATCH] dma-iommu: Add iommu_dma_max_mapping_size()
Message-ID: <20220518131237.GA26019@lst.de>
References: <1652706361-92557-1-git-send-email-john.garry@huawei.com> <f5b78c9c-312e-70ab-ecbb-f14623a4b6e3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5b78c9c-312e-70ab-ecbb-f14623a4b6e3@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 11:40:52AM +0100, Robin Murphy wrote:
> Indeed, sorry but NAK for this being nonsense. As I've said at least once 
> before, if the unnecessary SAC address allocation attempt slows down your 
> workload, make it not do that in the first place. If you don't like the 
> existing command-line parameter then fine, there are plenty of other 
> options, it just needs to be done in a way that doesn't break x86 systems 
> with dodgy firmware, as my first attempt turned out to.

What broke x86?
