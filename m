Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACF6C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 01:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236621AbiBYB53 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 20:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236616AbiBYB51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:57:27 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F66EB7175
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 17:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645754216; x=1677290216;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TcpmV4noUFBiGEZ3o4FCce8aCYiup32Bd4REqfq6nEg=;
  b=hDlIZtLXSW40HSRhRcVDtlL811gse+DeJOmJVOcEpfXgcqRQEJKIqgHw
   OmVUZceQD4Q/9TkiFotn+zWOal5OozYR4vzxGFaRFiMlH5ndVaLlCP5dO
   sBNT5nNjAzzxKoLzoidXsEul09QHLEkgSc0kyaaAMH7Oz8/oqE82VEnx0
   Uphj39aUxF7zWmtBvtmk4W3CV4ARo5tlw2nP2PQzIBS1Stz6x5wUiO902
   DZQnIqd57TglqHElHLTjKJw7RlegmQ0/Jlb5WmAlfXuPB9q0XP7ZYxwAy
   mgxfLBe1JVGLEyXt66DqQMEXO9Ref6yR4GXiWdj4sicTVys1TUPm9KnTJ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="251226726"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="251226726"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 17:56:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="533385717"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga007.jf.intel.com with ESMTP; 24 Feb 2022 17:56:33 -0800
Message-ID: <21befc9a-ff72-154f-9fad-3a11ff9b91a6@linux.intel.com>
Date:   Fri, 25 Feb 2022 09:55:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/11] iommu/vt-d: Remove DEFER_DEVICE_DOMAIN_INFO
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
 <20220214025704.3184654-6-baolu.lu@linux.intel.com>
 <20220224130423.GH6413@nvidia.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220224130423.GH6413@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/22 9:04 PM, Jason Gunthorpe wrote:
> On Mon, Feb 14, 2022 at 10:56:58AM +0800, Lu Baolu wrote:
> 
>> diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
>> index db7a0ca73626..ed796eea4581 100644
>> --- a/drivers/iommu/intel/debugfs.c
>> +++ b/drivers/iommu/intel/debugfs.c
>> @@ -344,7 +344,8 @@ static void pgtable_walk_level(struct seq_file *m, struct dma_pte *pde,
>>   
>>   static int show_device_domain_translation(struct device *dev, void *data)
>>   {
>> -	struct dmar_domain *domain = find_domain(dev);
>> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
>> +	struct dmar_domain *domain = info->domain;
> 
> It might be nice to someday call 'struct device_domain_info' something
> clearer since it is now the dev_iommu_priv..

I have the same idea. :-) I will rename it later.

> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Jason

Best regards,
baolu
