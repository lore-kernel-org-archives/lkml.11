Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C658C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 07:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241360AbiBNHep (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 02:34:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiBNHee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 02:34:34 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31C4593BC
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 23:34:26 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5509068AFE; Mon, 14 Feb 2022 08:34:24 +0100 (CET)
Date:   Mon, 14 Feb 2022 08:34:24 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/11] iommu/vt-d: Remove commented code
Message-ID: <20220214073424.GE17411@lst.de>
References: <20220214025704.3184654-1-baolu.lu@linux.intel.com> <20220214025704.3184654-10-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214025704.3184654-10-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 10:57:02AM +0800, Lu Baolu wrote:
> This removes unnecessary commented code.

Removing dead code is always good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But someone might really want to take a look if draining makes sense here
or not.
