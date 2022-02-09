Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BD8C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 06:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbiBIGqY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Feb 2022 01:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbiBIGqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 01:46:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B3FC03E911
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 22:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ONTS7St04dYKZSb41uvAWiQCmSInXPwUYUtislefmq4=; b=VZJiRrQeB48HFZnSa/fhbxKsFB
        C4BMEqt+yDaUAzT87IJQ2b7k9TyAbf37oBKHaMVuDQSXk6KsFtGTagdL6DGwxyvATZTbkiUAOkt1T
        akmmuoUcINkURUTgP96pVskBiEgvrpEyGDnSzcTCOf/m+ZF5fGLpbI8YB6/pe6ZLK0DCtsbFRptlK
        oKIOw5D2hc3kaA4+N9AoIluvFSm8FS+bH+86pPVi8og1oayTVWZCYliz5+XHNbNcvZtQFPS72vLl0
        daTdEpaYY2sf5KotPDQgu0kfg1lEhN0m9ZrhJsrRcaKR+XHO5q7qEYP74DXOHjFfcSNKKQjTUEO8a
        89sxfnmQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHgk2-00GO1d-Ft; Wed, 09 Feb 2022 06:46:14 +0000
Date:   Tue, 8 Feb 2022 22:46:14 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/10] iommu: Split struct iommu_ops
Message-ID: <YgNjNu4kVbkruvZN@infradead.org>
References: <20220208012559.1121729-1-baolu.lu@linux.intel.com>
 <20220208012559.1121729-11-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208012559.1121729-11-baolu.lu@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 09:25:59AM +0800, Lu Baolu wrote:
> Move the domain specific operations out of struct iommu_ops into a new
> structure that only has domain specific operations. This solves the
> problem of needing to know if the method vector for a given operation
> needs to be retrieved from the device or the domain. Logically the domain
> ops are the ones that make sense for external subsystems and endpoint
> drivers to use, while device ops, with the sole exception of domain_alloc,
> are IOMMU API internals.

I can't say I like the default_domain_ops concept all that much, but
the split itself looks like a good idea and done nicely.
