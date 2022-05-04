Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E047C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 May 2022 08:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346396AbiEDIh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 May 2022 04:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241443AbiEDIhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:37:18 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225E3167EB;
        Wed,  4 May 2022 01:33:39 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 662E2477; Wed,  4 May 2022 10:33:37 +0200 (CEST)
Date:   Wed, 4 May 2022 10:33:36 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the iommu tree
Message-ID: <YnI6YBNYKSuAbOa1@8bytes.org>
References: <20220429230138.6647faaf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429230138.6647faaf@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Fri, Apr 29, 2022 at 11:01:38PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   df2a0bccf804 ("iommu/amd: Do not call sleep while holding spinlock")
> 
> Fixes tag
> 
>   Fixes: dc6a709e5123 ("iommu/amd: Improve amd_iommu_v2_exit()")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Maybe you meant
> 
> Fixes: 9f968fc70d85 ("iommu/amd: Improve amd_iommu_v2_exit()")

Thanks for the report, I updated the fixes tag.

Regards,

	Joerg


