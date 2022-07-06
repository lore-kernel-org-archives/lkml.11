Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1717AC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Jul 2022 12:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbiGFMBO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Jul 2022 08:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbiGFMBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:01:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E2428E36
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 05:01:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DBE161F44
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 12:01:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4789DC3411C;
        Wed,  6 Jul 2022 12:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657108865;
        bh=SxZ5gPnL1lJYbbdKlvmsQFgB0lgS1A3kcbUqEn7xBRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dOArfIuHLw6DUXMjueXyFAFj2MCvfGU248UeblIvaB8Mdpjk6cKv5QRgDqMx2lFNo
         YPquuSW2tGbSY4szUZ8AsXJ4UhyUu1n+0QYBcu2OKEtSIXoGnTmJMDgFU10bCKD1UL
         kTnHNnB+u3RvZbLvXiZ4nnoDTn7mOJkFjkNN0pgpo/ij/+tCmur3TTu/VtbTwNvhtJ
         tLdFw/1/d+h2fNSstaH8dYTmHFiRXZKq0PA7IBfzs3FJSGEA7r1h/dWZxCuN2gcEEg
         H0JWBi9zioTiZ6u/011hT2D6fRfJ5QMJUeEFfe4rD6K5t9G4KLgqCqr/9rntIR/yjN
         e9jWJXYnSBCpg==
Date:   Wed, 6 Jul 2022 13:00:59 +0100
From:   Will Deacon <will@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     joro@8bytes.org, robin.murphy@arm.com, mst@redhat.com,
        jasowang@redhat.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        chenxiang66@hisilicon.com, thunder.leizhen@huawei.com,
        jean-philippe@linaro.org, linuxarm@huawei.com
Subject: Re: [PATCH RESEND v5 1/5] iommu: Refactor iommu_group_store_type()
Message-ID: <20220706120059.GE2403@willie-the-truck>
References: <1649071634-188535-1-git-send-email-john.garry@huawei.com>
 <1649071634-188535-2-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649071634-188535-2-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 07:27:10PM +0800, John Garry wrote:
> Function iommu_group_store_type() supports changing the default domain
> of an IOMMU group.
> 
> Many conditions need to be satisfied and steps taken for this action to be
> successful.
> 
> Satisfying these conditions and steps will be required for setting other
> IOMMU group attributes, so factor into a common part and a part specific
> to update the IOMMU group attribute.
> 
> No functional change intended.
> 
> Some code comments are tidied up also.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/iommu/iommu.c | 96 ++++++++++++++++++++++++++++---------------
>  1 file changed, 62 insertions(+), 34 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
