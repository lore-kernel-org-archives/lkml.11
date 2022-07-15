Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EE1C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jul 2022 08:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbiGOIoz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jul 2022 04:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiGOIox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 04:44:53 -0400
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D84814A8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 01:44:53 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C69C7535; Fri, 15 Jul 2022 10:44:51 +0200 (CEST)
Date:   Fri, 15 Jul 2022 10:44:50 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        robin.murphy@arm.com, vasant.hegde@amd.com, ashish.kalra@amd.com,
        jon.grimm@amd.com
Subject: Re: [PATCH v4 0/9] iommu/amd: Enforce IOMMU restrictions for
 SNP-enabled system
Message-ID: <YtEpAgSGz+Linner@8bytes.org>
References: <20220713225651.20758-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713225651.20758-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 05:56:42PM -0500, Suravee Suthikulpanit wrote:
> Brijesh Singh (1):
>   iommu/amd: Introduce function to check and enable SNP
> 
> Suravee Suthikulpanit (8):
>   iommu/amd: Change macro for IOMMU control register bit shift to
>     decimal value
>   iommu/amd: Introduce Support for Extended Feature 2 Register
>   iommu/amd: Introduce global variable for storing common EFR and EFR2
>   iommu/amd: Process all IVHDs before enabling IOMMU features
>   iommu/amd: Globally detect SNP support
>   iommu/amd: Set translation valid bit only when IO page tables are in
>     use
>   iommu/amd: Do not support IOMMU_DOMAIN_IDENTITY after SNP is enabled
>   iommu/amd: Do not support IOMMUv2 APIs when SNP is enabled

Applied, thanks Suravee.

