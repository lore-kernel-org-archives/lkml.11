Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB736C433FE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 May 2022 11:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349061AbiEDMAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 May 2022 08:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiEDMAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:00:43 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23122167E7
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 04:57:08 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id BB1F667B; Wed,  4 May 2022 13:57:06 +0200 (CEST)
Date:   Wed, 4 May 2022 13:57:05 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Qian Cai <quic_qiancai@quicinc.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v8 00/11] Fix BUG_ON in vfio_iommu_group_notifier()
Message-ID: <YnJqER3qbzHucfkx@8bytes.org>
References: <20220418005000.897664-1-baolu.lu@linux.intel.com>
 <20220502161204.GA22@qian>
 <YnI8Xy54M3XQpS0T@8bytes.org>
 <20220504115135.GA49344@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504115135.GA49344@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 08:51:35AM -0300, Jason Gunthorpe wrote:
> Nicolin and Eric have been testing with this series on ARM for a long
> time now, it is not like it is completely broken.

Yeah, I am also optimistic this can be fixed soon. But the rule is that
the next branch should only contain patches which I would send to Linus.
And with a known issue in it I wouldn't, so it is excluded at least from
my next branch for now. The topic branch is still alive and I will merge
it again when the fix is in.

Regards,

	Joerg
