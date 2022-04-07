Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68565C433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Apr 2022 13:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343711AbiDGNng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Apr 2022 09:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343880AbiDGNnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 09:43:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6F127B38
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 06:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=74PS8gP8R7QSv7wDPjxMrGmI/chpbWr92QAHIh9FKHQ=; b=IkEHrck5evsyXCvHJjhJFDqRe7
        MKO4XbmW1buUih3ZFgYRb+doKN2RDmupP3AtpfjaSAvRxJBSJ6Kq5eILoGdRBkllRwMckLuLlTdw1
        IejvFTj3E4nxW3OrdBOkSAj7dDTJMbj9aPKzR+J9hcwy1kczQeCsXFCXLDJ8jscKrXFJ1HqFeJTyG
        XK3GnMYtx24bwuLTwd474UEXgIeZcMP9cviBdDt5xGgUM+eh4B3AMyFgtYbUCPvUx2/DH+3Y1jWgq
        BPfSAVO0NuwqPxVNWiE1pr7sqv9/ieP+7IvvDpUuCMxG2ovM4PPzGnh/2LVFcu5P9p9e4s5804xqt
        gHJwozxA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncSNp-00CCNM-SL; Thu, 07 Apr 2022 13:41:09 +0000
Date:   Thu, 7 Apr 2022 06:41:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Suthikulpanit Suravee <Suravee.Suthikulpanit@amd.com>,
        Hegde Vasant <Vasant.Hegde@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] iommu/amd: Enable swiotlb in all cases
Message-ID: <Yk7p9fhIhvaHw9dF@infradead.org>
References: <20220404204723.9767-1-mario.limonciello@amd.com>
 <20220404204723.9767-2-mario.limonciello@amd.com>
 <f7039f1f-81ef-2fab-4ade-728316b54942@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7039f1f-81ef-2fab-4ade-728316b54942@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 02:31:44PM +0100, Robin Murphy wrote:
> FWIW it's also broken for another niche case where
> iommu_default_passthrough() == false at init, but the user later changes a
> 32-bit device's default domain type to passthrough via sysfs, such that it
> starts needing regular dma-direct bouncing.

Yeah.

We also have yet another issue:  swiotlb is not allocate if there is
no memory outside the 4GB physical address space.  I think I can fix
that easily after my swiotlb init series goes in, before that it
would be a bit of a mess spread over all the architectures.
