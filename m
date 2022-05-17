Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE934C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 May 2022 09:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237189AbiEQJLz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 05:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244406AbiEQJLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:11:08 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED1C1EEE8
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:11:05 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7FE9E67373; Tue, 17 May 2022 11:11:02 +0200 (CEST)
Date:   Tue, 17 May 2022 11:11:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     John Garry <john.garry@huawei.com>
Cc:     Christoph Hellwig <hch@lst.de>, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, m.szyprowski@samsung.com,
        chenxiang66@hisilicon.com, thunder.leizhen@huawei.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        liyihang6@hisilicon.com
Subject: Re: [RFC PATCH] dma-iommu: Add iommu_dma_max_mapping_size()
Message-ID: <20220517091102.GB18723@lst.de>
References: <1652706361-92557-1-git-send-email-john.garry@huawei.com> <20220517083834.GA16965@lst.de> <3e7c4d27-a0cb-2d9e-ca79-248ce26c6787@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e7c4d27-a0cb-2d9e-ca79-248ce26c6787@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 10:02:00AM +0100, John Garry wrote:
> BTW, on a separate topic, I noticed that even with this change my ATA 
> devices have max_hw_sectors_kb of 32767, as opposed to 128 for SAS devices. 
> It seems that libata-scsi - specifically ata_scsi_dev_config() - doesn't 
> honour the shost max_sectors limit. I guess that is not intentional.

I don't think it is.  the libsas/libsata integration is a bit messy
sometimes..
