Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CCEC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jun 2022 08:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiFWIYC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jun 2022 04:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiFWIYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:24:00 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF79AC0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 01:23:59 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 4EBD2447; Thu, 23 Jun 2022 10:23:58 +0200 (CEST)
Date:   Thu, 23 Jun 2022 10:23:57 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        robin.murphy@arm.com, ashish.kalra@amd.com, vasant.hegde@amd.com,
        thomas.lendacky@amd.com
Subject: Re: [PATCH v3 7/7] iommu/amd: Do not support IOMMUv2 APIs when SNP
 is enabled
Message-ID: <YrQjHYsEIGN0mtO2@8bytes.org>
References: <20220622171131.11870-1-suravee.suthikulpanit@amd.com>
 <20220622171131.11870-8-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622171131.11870-8-suravee.suthikulpanit@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 12:11:31PM -0500, Suravee Suthikulpanit wrote:
>  bool amd_iommu_v2_supported(void)
>  {
> -	return amd_iommu_v2_present;
> +	/*
> +	 * Since DTE[Mode]=0 is prohibited on SNP-enabled system
> +	 * (i.e. EFR[SNPSup]=1), IOMMUv2 page table cannot be used without
> +	 * setting up IOMMUv1 page table.
> +	 */
> +	return amd_iommu_v2_present && !amd_iommu_snp_en;

IOMMU_v2 APIs could actually be supported with GIOV and IOMMUv2
page-tables in-use, no?

Regards,

	Joerg

