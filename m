Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FE2C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 May 2022 08:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346412AbiEDIkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 May 2022 04:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbiEDIkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:40:36 -0400
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7441DA4F
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 01:37:00 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 2265267B; Wed,  4 May 2022 10:36:59 +0200 (CEST)
Date:   Wed, 4 May 2022 10:36:57 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Will Deacon <will@kernel.org>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: dart: Add missing module owner to ops structure
Message-ID: <YnI7KQ6qwwCKC6Hc@8bytes.org>
References: <20220502092238.30486-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502092238.30486-1-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 06:22:38PM +0900, Hector Martin wrote:
> This is required to make loading this as a module work.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/iommu/apple-dart.c | 1 +
>  1 file changed, 1 insertion(+)

Applied for v5.18, thanks.
