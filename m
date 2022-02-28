Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE21C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Feb 2022 12:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbiB1M1B (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Feb 2022 07:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiB1M1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:27:00 -0500
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7D91275D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:26:21 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 32A604B0; Mon, 28 Feb 2022 13:26:20 +0100 (CET)
Date:   Mon, 28 Feb 2022 13:26:19 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/9] iommu cleanup and refactoring
Message-ID: <Yhy/awfTOkQLLZ95@8bytes.org>
References: <20220216025249.3459465-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216025249.3459465-1-baolu.lu@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 10:52:40AM +0800, Lu Baolu wrote:
> Lu Baolu (9):
>   iommu/vt-d: Remove guest pasid related callbacks
>   iommu: Remove guest pasid related interfaces and definitions
>   iommu/vt-d: Remove aux-domain related callbacks
>   iommu: Remove aux-domain related interfaces and iommu_ops
>   iommu: Remove apply_resv_region
>   drm/nouveau/device: Get right pgsize_bitmap of iommu_domain
>   iommu: Use right way to retrieve iommu_ops
>   iommu: Remove unused argument in is_attach_deferred
>   iommu: Split struct iommu_ops

Applied to core branch, thanks Baolu!
