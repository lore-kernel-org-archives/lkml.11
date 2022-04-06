Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CF7C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 07:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbiDFHMv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 03:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344558AbiDFG7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 02:59:52 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795CB19BE51;
        Tue,  5 Apr 2022 22:28:16 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AEE8F68AFE; Wed,  6 Apr 2022 07:28:12 +0200 (CEST)
Date:   Wed, 6 Apr 2022 07:28:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, baolu.lu@linux.intel.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        mika.westerberg@linux.intel.com, YehezkelShB@gmail.com,
        iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, mario.limonciello@amd.com, hch@lst.de
Subject: Re: [PATCH v3 1/4] iommu: Introduce device_iommu_capable()
Message-ID: <20220406052812.GA10507@lst.de>
References: <cover.1649089693.git.robin.murphy@arm.com> <37ec2f9f67098d0caf60dcec558fbe1756ea2621.1649089693.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37ec2f9f67098d0caf60dcec558fbe1756ea2621.1649089693.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 11:41:01AM +0100, Robin Murphy wrote:
> iommu_capable() only really works for systems where all IOMMU instances
> are completely homogeneous, and all devices are IOMMU-mapped. Implement
> the new variant which can give an accurate answer for whichever device
> the caller is actually interested in.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v3: New patch; now that the dev_iommu_ops() work has landed we can go
>     straight to a proper implementation. Also s/dev/device/ to match
>     the precedent of device_iommu_mapped() for the public API.

I'm a little worrited about a method with a parameter than can be
NULL.

Also usnic, vmd, and vdpa really want to use your new
device_iommu_capable as they check based on a device.  Just VFIO
is special as usual..
