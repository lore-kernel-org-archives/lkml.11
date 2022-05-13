Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A05DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 May 2022 15:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382186AbiEMPtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 May 2022 11:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbiEMPtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:49:49 -0400
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B632612E310
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:49:47 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C919D4D2; Fri, 13 May 2022 17:49:45 +0200 (CEST)
Date:   Fri, 13 May 2022 17:49:44 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Qian Cai <quic_qiancai@quicinc.com>,
        Kevin Tian <kevin.tian@intel.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RESEND PATCH v8 00/11] Fix BUG_ON in vfio_iommu_group_notifier()
Message-ID: <Yn5+GKHlQlX5bszi@8bytes.org>
References: <20220418005000.897664-1-baolu.lu@linux.intel.com>
 <20220502161204.GA22@qian>
 <YnI8Xy54M3XQpS0T@8bytes.org>
 <20220504102956.0f5b5302.alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504102956.0f5b5302.alex.williamson@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Wed, May 04, 2022 at 10:29:56AM -0600, Alex Williamson wrote:
> Done, and thanks for the heads-up.  Please try to cc me when the
> vfio-notifier-fix branch is merged back into your next branch.  Thanks,

This has happened now, the vfio-notifier-fix branch got the fix and is
merged back into my next branch.

Regards,

	Joerg
