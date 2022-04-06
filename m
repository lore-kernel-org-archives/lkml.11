Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2CAC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 07:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347935AbiDFHOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 03:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347287AbiDFHAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 03:00:16 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC98ECB36;
        Tue,  5 Apr 2022 22:28:55 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D801268AFE; Wed,  6 Apr 2022 07:28:52 +0200 (CEST)
Date:   Wed, 6 Apr 2022 07:28:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, baolu.lu@linux.intel.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        mika.westerberg@linux.intel.com, YehezkelShB@gmail.com,
        iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, mario.limonciello@amd.com, hch@lst.de
Subject: Re: [PATCH v3 4/4] iommu/amd: Indicate whether DMA remap support
 is enabled
Message-ID: <20220406052852.GB10507@lst.de>
References: <cover.1649089693.git.robin.murphy@arm.com> <674846bcefe8d85c1c4675cabaf507f09ab45514.1649089693.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <674846bcefe8d85c1c4675cabaf507f09ab45514.1649089693.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
