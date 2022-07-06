Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABEDC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Jul 2022 10:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbiGFK4Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Jul 2022 06:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbiGFK4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:56:23 -0400
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C0427CD4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 03:56:22 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 504BD4CC; Wed,  6 Jul 2022 12:56:21 +0200 (CEST)
Date:   Wed, 6 Jul 2022 12:56:20 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     will@kernel.org, iommu@lists.linux-foundation.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] iommu: More internal ops cleanup
Message-ID: <YsVqVDLvE4q+NIbn@8bytes.org>
References: <cover.1655822151.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1655822151.git.robin.murphy@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 04:14:24PM +0100, Robin Murphy wrote:
> Robin Murphy (3):
>   iommu: Use dev_iommu_ops() for probe_finalize
>   iommu: Make .release_device optional
>   iommu: Clean up release_device checks

Applied to core branch, thanks.
