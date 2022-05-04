Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498EFC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 May 2022 13:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350157AbiEDNWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 May 2022 09:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbiEDNWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:22:17 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C358F2DB
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 06:18:40 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C8EA13FA; Wed,  4 May 2022 15:18:38 +0200 (CEST)
Date:   Wed, 4 May 2022 15:18:37 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     will@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, baolu.lu@linux.intel.com,
        Jan Stancek <jstancek@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH] iommu: Make sysfs robust for non-API groups
Message-ID: <YnJ9LaBlARYSE4Y/@8bytes.org>
References: <86ada41986988511a8424e84746dfe9ba7f87573.1651667683.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86ada41986988511a8424e84746dfe9ba7f87573.1651667683.git.robin.murphy@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 01:39:58PM +0100, Robin Murphy wrote:
> Groups created by VFIO backends outside the core IOMMU API should never
> be passed directly into the API itself, however they still expose their
> standard sysfs attributes, so we can still stumble across them that way.
> Take care to consider those cases before jumping into our normal
> assumptions of a fully-initialised core API group.
> 
> Fixes: 3f6634d997db ("iommu: Use right way to retrieve iommu_ops")
> Reported-by: Jan Stancek <jstancek@redhat.com>
> Tested-by: Jan Stancek <jstancek@redhat.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> /me has a vested interest in not going backwards on dev_iommu_ops() :)
> 
>  drivers/iommu/iommu.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Applied, thanks.

