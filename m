Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A09C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 09:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbiBOJRs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 04:17:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbiBOJRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:17:46 -0500
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1E1BCAC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:17:35 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 0760136D; Tue, 15 Feb 2022 10:17:33 +0100 (CET)
Date:   Tue, 15 Feb 2022 10:17:32 +0100
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
Subject: Re: [PATCH v3 00/10] iommu cleanup and refactoring
Message-ID: <YgtvrJ2eIUV+U84u@8bytes.org>
References: <20220214015538.2828933-1-baolu.lu@linux.intel.com>
 <YgpjzNtQlOdq+1AB@8bytes.org>
 <1d817995-f89b-a1de-6aff-9a2bfe91367f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d817995-f89b-a1de-6aff-9a2bfe91367f@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu,

On Tue, Feb 15, 2022 at 10:05:42AM +0800, Lu Baolu wrote:
> Do you want me to send a new version with below changes:
> 
> - Remove WARN_ON() in dev_iommu_ops();
> - Merge above two patches.
> 
> Or, you can change above yourself?

Please make the changes and send a new version. I will apply it to the
iommu core branch then. The build-tests with this patch-set went well
and I havn't spotted anything else in my review, so I think it is in
good shape for linux-next testing.

Regards,

	Joerg
