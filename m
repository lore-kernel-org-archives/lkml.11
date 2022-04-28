Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2FCC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Apr 2022 08:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344081AbiD1IYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Apr 2022 04:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344064AbiD1IXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:23:50 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D3F7E08A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:20:36 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 01CB72FB; Thu, 28 Apr 2022 10:20:34 +0200 (CEST)
Date:   Thu, 28 Apr 2022 10:20:33 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH] iommu/fsl_pamu: Prepare cleanup of powerpc's asm/prom.h
Message-ID: <YmpOUeH7RwoyIVw3@8bytes.org>
References: <06862cca930068e8fa4fdd0b20d74872d3b929d6.1648833431.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06862cca930068e8fa4fdd0b20d74872d3b929d6.1648833431.git.christophe.leroy@csgroup.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2022 at 12:08:38PM +0200, Christophe Leroy wrote:
> powerpc's asm/prom.h brings some headers that it doesn't
> need itself.
> 
> In order to clean it up, first add missing headers in
> users of asm/prom.h
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  drivers/iommu/fsl_pamu.c        | 3 +++
>  drivers/iommu/fsl_pamu_domain.c | 1 +
>  2 files changed, 4 insertions(+)

Applied, thanks.
