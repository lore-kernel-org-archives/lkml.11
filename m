Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A955AC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jun 2022 13:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244393AbiFVNmW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jun 2022 09:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344776AbiFVNmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:42:13 -0400
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFBD2E0A5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 06:42:12 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 314092D0; Wed, 22 Jun 2022 15:42:10 +0200 (CEST)
Date:   Wed, 22 Jun 2022 15:42:08 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     yf.wang@mediatek.com, Miles Chen <miles.chen@mediatek.com>,
        wsd_upstream@mediatek.com,
        open list <linux-kernel@vger.kernel.org>,
        Libo Kang <Libo.Kang@mediatek.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Ning Li <ning.li@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] iommu/dma: Fix race condition during iova_domain
 initialization
Message-ID: <YrMcMOVSQtLqJ3kp@8bytes.org>
References: <20220530120748.31733-1-yf.wang@mediatek.com>
 <YrMPG4dIEnFkCbi9@8bytes.org>
 <a0f0d3da-6992-7033-5262-156ffa5316e7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0f0d3da-6992-7033-5262-156ffa5316e7@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 02:27:57PM +0100, Robin Murphy wrote:
> Apologies, I did spot this before, I've just been tied up with other things
> and dropping everything non-critical on the floor, so didn't get round to
> replying before it slipped my mind again.
> 
> In summary, I hate it, but mostly because the whole situation of calling
> iommu_probe_device off the back of driver probe is fundamentally broken. I'm
> still a few steps away from fixing that properly, at which point I can just
> as well rip all these little bodges out again. If it really does need
> mitigating in the meantime (i.e. this is real-world async probe, not just
> some contrived testcase), then I can't easily think of any cleaner hack, so,
> 
> Acked-by: Robin Murphy <robin.murphy@arm.com>

Alright, applied this now.
