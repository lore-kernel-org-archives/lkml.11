Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B005C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 08:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237832AbiFGIAs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 04:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbiFGIAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 04:00:46 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB63CC148
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 01:00:45 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 487BF423; Tue,  7 Jun 2022 10:00:43 +0200 (CEST)
Date:   Tue, 7 Jun 2022 10:00:38 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        vasant.hegde@amd.com, jon.grimm@amd.com
Subject: Re: [PATCH v2] iommu/amd: Set translation valid bit only when IO
 page tables are in used
Message-ID: <Yp8FpnMrlJcXIHqq@8bytes.org>
References: <20220509074815.11881-1-suravee.suthikulpanit@amd.com>
 <Yn5YIfzmerwAM30M@8bytes.org>
 <1dfaf07e-040e-848b-db7c-86a107fd5cb3@amd.com>
 <YodMvV/8eii4KCLg@8bytes.org>
 <dac2c654-cb9c-6554-0afd-9e8db012374a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dac2c654-cb9c-6554-0afd-9e8db012374a@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 10:29:09AM +0700, Suravee Suthikulpanit wrote:
> Actually, I am referring to when user uses the IOMMU v2 table for shared virtual address
> in current iommu_v2 driver (e.g. amd_iommu_init_device(), amd_iommu_bind_pasid).

From what I can see this is not handled yet and needs an additional
check. I think the best solution is to set iommu->iommu_v2 to false when
the SNP feature bit is set.
But that is probably not enough, all functions that are called from the
IOMMUv2 driver need to fail.

Regards,

	Joerg
