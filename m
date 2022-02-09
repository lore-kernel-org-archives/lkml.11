Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93151C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 07:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbiBIHHA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Feb 2022 02:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235839AbiBIHGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 02:06:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524A5C0612BF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 23:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+z8eCcqE9dbOC+gW13dx1B6dfCic13ISPvvQnd/UNzw=; b=hrVPnKU36nuaAo3miL0rswd0hN
        wMpyoIrMK6Wz0lWMULb+B8tvJXituESayQpYAsmshaIokMeOFi28pEFzJtO0Yf37wbaXxSn7Qaunt
        wUA9JWS+ivEAlm6OuIp+3sMtnve8AlmxHhb8cJlxlHN/nQyS/dgZs2jYa2J9vFrwU+X0vgOGXtzKj
        o+oNig+qgTYsbvij/yVdn2+6XW7BooUF8gOUA5AJt+H/mPQhHF/5lnawFFHlTunhqvJ+ZDkyCM7gr
        zwHPqlRjN55vGiDXnsMftS99hyv8MPObJ0UX4IDszzLEfGJ8CEaDeMB8zHRUVJR+xhVddO8G1KZJ7
        mBGylzFQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHh44-00GQTd-2d; Wed, 09 Feb 2022 07:06:56 +0000
Date:   Tue, 8 Feb 2022 23:06:56 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 1/1] iommu/dma: Use DMA ops setter instead of direct
 assignment
Message-ID: <YgNoENf1EIFmaeDD@infradead.org>
References: <20220207141321.8293-1-andriy.shevchenko@linux.intel.com>
 <58e77093-51e2-59a2-e413-164d83ecd9b8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58e77093-51e2-59a2-e413-164d83ecd9b8@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 03:55:32PM +0000, Robin Murphy wrote:
> On 2022-02-07 14:13, Andy Shevchenko wrote:
> > Use DMA ops setter instead of direct assignment. Even we know that
> > this module doesn't perform access to the dma_ops member of struct device,
> > it's better to use setter to avoid potential problems in the future.
> 
> What potential problems are you imagining? This whole file is a DMA ops
> implementation, not driver code (and definitely not a module); if anyone
> removes the "select DMA_OPS" from CONFIG_IOMMU_DMA they deserve whatever
> breakage they get.
> 
> I concur that there's no major harm in using the helper here, but I also see
> no point in pretending that there's any value to abstracting the operation
> in this particular context.

Yeah.  Killing off the the wrapper is actually on my todo list, mostly
because it leads to people doing completely broken things like the VDPA
private dma ops that should not exist.
