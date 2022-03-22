Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845FBC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 04:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236458AbiCVEdP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 00:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236452AbiCVEdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 00:33:13 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADF81F636
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 21:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647923506; x=1679459506;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dsKJ5aYjOe1ElqEXDty5bKxW35OhOUL49tF3kSu1rOs=;
  b=Nd90I/VjsBJVCwNdG542o//a6NNhfMKATkwTAeRYEcgOYidBChIuY568
   e48Dzwj/DLplgRbBuTOAuXdY1sYAZNv6ACp2v9sj9ZNLvGSYJIKAMjHak
   t/l6O1KsXNPgGEADw2yFKj93c1KmJV16sS+vjJimaX0IyyHroYoh21jb7
   2rfh6AraHKTNrV4jIJV5FlO5KaiwifcPl6TjW4wgceU8ehUrhKdVB5PWh
   XqgHl1NJ597RxkZqkWBV218gbOpe2s3SVcEKeiWa2ZH4LImp/y//u2/5w
   QW1v7odg4n61RIalTF7ZlM5Ebx5W1Lq+xNUIF+/IXxJ59TDLK++fxLqPK
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="257437066"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="257437066"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 21:31:46 -0700
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="518719355"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.209.186]) ([10.254.209.186])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 21:31:41 -0700
Message-ID: <bdf294e5-b4ed-04dd-1c71-24fada7c9f3d@linux.intel.com>
Date:   Tue, 22 Mar 2022 12:31:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 06/11] iommu/sva: Use attach/detach_pasid_dev in SVA
 interfaces
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-7-baolu.lu@linux.intel.com>
 <20220321120503.GN11336@nvidia.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220321120503.GN11336@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/21 20:05, Jason Gunthorpe wrote:
> On Sun, Mar 20, 2022 at 02:40:25PM +0800, Lu Baolu wrote:
> 
>> +/**
>> + * iommu_sva_bind_device() - Bind a process address space to a device
>> + * @dev: the device
>> + * @mm: the mm to bind, caller must hold a reference to it
>> + * @drvdata: opaque data pointer to pass to bind callback
>> + *
>> + * Create a bond between device and address space, allowing the device to access
>> + * the mm using the returned PASID. If a bond already exists between @device and
>> + * @mm, it is returned and an additional reference is taken. Caller must call
>> + * iommu_sva_unbind_device() to release each reference.
>> + *
>> + * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called first, to
>> + * initialize the required SVA features.
>> + *
>> + * On error, returns an ERR_PTR value.
>> + */
>> +struct iommu_sva *
>> +iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
> The drvdata is never used

Yes. It is cleaned up in Jacob's series.

Best regards,
baolu
