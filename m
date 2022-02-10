Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A0FC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Feb 2022 01:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbiBJBUy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Feb 2022 20:20:54 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiBJBUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:20:52 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEE91EC58
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 17:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644456054; x=1675992054;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ei+VnaHpgHPJ+c/nKei5uKtauvdLXQwFHwki6nRTPGM=;
  b=BDU1ZcBL1MW853h1ajSCh5uc7huldjSzh92bbDcuPG7DBasiEbJbotA0
   AaYf4aeL6ndhge2SDLmOCcCu7IjpckcXK6Lux/CKSWqR4e9msluQQ3Hc/
   Bj8SJAGPM/eki9Ott2xNYZwWv8YyQyiUcpgu7dplqqDkaZZmg1lmUPyzX
   y4N+LunSl9ZlZr6oAXVdH5XTcd87R1DDlV/WFz9pb9uOqxfmnuA5XdRab
   oe0Xwdzm9c6+7z4T2+qfTzqfLr7cViAHzWXvQKTOVZcPuRu3uwUzFklVa
   HhZf7m0POKSx+73ExdM+waX22cq/QHGf3J8wsa6kRQbXlkf1BJ98FNsz1
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="248210543"
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="248210543"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 16:49:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="678967443"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 09 Feb 2022 16:49:34 -0800
Message-ID: <b8ccaf6f-e374-ecd8-ee86-5f415a33a4a9@linux.intel.com>
Date:   Thu, 10 Feb 2022 08:48:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
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
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 06/10] drm/nouveau/device: Get right pgsize_bitmap of
 iommu_domain
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220208012559.1121729-1-baolu.lu@linux.intel.com>
 <20220208012559.1121729-7-baolu.lu@linux.intel.com>
 <20220209133139.GX4160@nvidia.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220209133139.GX4160@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/22 9:31 PM, Jason Gunthorpe wrote:
> On Tue, Feb 08, 2022 at 09:25:55AM +0800, Lu Baolu wrote:
>> The supported page sizes of an iommu_domain are saved in the pgsize_bitmap
>> field. Retrieve the value from the right place.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> Reviewed-by: Robin Murphy<robin.murphy@arm.com>
>> Link:https://lore.kernel.org/r/20211218074546.1772553-1-baolu.lu@linux.intel.com
>> Reviewed-by: Christoph Hellwig<hch@lst.de>
>> ---
>>   drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> IMHO it is weird that the ops have a pgsize_bitmap at all.

Agreed. Christoph doesn't like it either. The domain->pgsize_bitmap
should be initialized during domain_alloc(). We plan to make this happen
in or after domain_alloc() refactoring.

Best regards,
baolu
