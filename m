Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382CEC4332F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 13:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353890AbiBNNFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 08:05:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344837AbiBNNFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:05:20 -0500
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAF74D609
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:05:13 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 18F206BF; Mon, 14 Feb 2022 14:05:12 +0100 (CET)
Date:   Mon, 14 Feb 2022 14:05:10 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     will@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH] iommu: Remove trivial ops->capable implementations
Message-ID: <YgpThrw8QWgc4GuR@8bytes.org>
References: <8413578c6f8a7cf75530b00cba8f10f5b88f8517.1644495614.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8413578c6f8a7cf75530b00cba8f10f5b88f8517.1644495614.git.robin.murphy@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 12:29:05PM +0000, Robin Murphy wrote:
> Implementing ops->capable to always return false is pointless since it's
> the default behaviour anyway. Clean up the unnecessary implementations.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> Spinning this out of my bus ops stuff (currently 30 patches and
> counting...) since it would be better off alongside Baolu's cleanup
> series to avoid conflicts, and I want to depend on those patches for
> dev_iommu_ops() anyway.
> 
>  drivers/iommu/msm_iommu.c  | 6 ------
>  drivers/iommu/tegra-gart.c | 6 ------
>  drivers/iommu/tegra-smmu.c | 6 ------
>  3 files changed, 18 deletions(-)

Applied, thanks Robin.

