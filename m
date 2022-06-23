Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D52EC43334
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jun 2022 07:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiFWHoY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jun 2022 03:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiFWHoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:44:23 -0400
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C69246658
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 00:44:23 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 83E66447; Thu, 23 Jun 2022 09:44:21 +0200 (CEST)
Date:   Thu, 23 Jun 2022 09:44:20 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] iommu/amd: Use try_cmpxchg64 in alloc_pte and
 free_clear_pte
Message-ID: <YrQZ1PQIXfNYSq5g@8bytes.org>
References: <20220525145416.10816-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525145416.10816-1-ubizjak@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 04:54:16PM +0200, Uros Bizjak wrote:
> Use try_cmpxchg64 instead of cmpxchg64 (*ptr, old, new) != old in
> alloc_pte and free_clear_pte.  cmpxchg returns success in ZF flag, so this
> change saves a compare after cmpxchg (and related move instruction
> in front of cmpxchg). Also, remove racy explicit assignment to pteval
> when cmpxchg fails, this is what try_cmpxchg does implicitly from
> *pte in an atomic way.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: Will Deacon <will@kernel.org>
> ---
>  drivers/iommu/amd/io_pgtable.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Applied, thanks.
