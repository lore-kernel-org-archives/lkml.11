Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC598C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jun 2022 04:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343660AbiFUE2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jun 2022 00:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343662AbiFUE21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 00:28:27 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1046563BB;
        Mon, 20 Jun 2022 21:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655785705; x=1687321705;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DkFRRkmJt7PsIWwIUdSoJXbh9kQg9crtwrrbrg/6TSU=;
  b=DlPvM2x8w0JMxSN5/yrRp+9MHNTz7FRXyhYD4zxJO8gM0frOo5D6TbW6
   ZR6O5FRxIPAHD50brcIjC8RbPzpQxR0WbxLMs0DAev11Pb6vxMYKUzg6W
   lcL9pPekhvBL8JIMXYoLOqvY/0P0HYzVRRF0FTaG64Hf5tR/OmvNNTrgt
   Vee7CX2s3vxcEw/Pe8kFlJABne3wL0wlzGGk3UihKbU7nwmwSWBniJmIJ
   7WPviYm5PVqnkZrqWvzT37dG+euDIR2kSchQdlxFPdtrRI/LtdrE8C/WC
   d2w6gdtKbiuxjbBgRzVHmPcBgxJG1f8SunwHVDoLTI4psQOix2ZAYW827
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="344017660"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="344017660"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 21:28:24 -0700
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="833395659"
Received: from zequnyu-mobl1.ccr.corp.intel.com (HELO [10.255.31.162]) ([10.255.31.162])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 21:28:22 -0700
Message-ID: <80457871-a760-69ba-70be-5e95344182ea@linux.intel.com>
Date:   Tue, 21 Jun 2022 12:28:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, "Qiang, Chenyi" <chenyi.qiang@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix RID2PASID setup failure
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Raj, Ashok" <ashok.raj@intel.com>
References: <20220620081729.4610-1-baolu.lu@linux.intel.com>
 <BN9PR11MB52764F60972DF52EEF945D408CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <5d13cab5-1f0a-51c7-78a3-fb5d3d793ab1@linux.intel.com>
 <BN9PR11MB527671B3B4C1F786E40D67408CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527671B3B4C1F786E40D67408CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/21 11:46, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, June 21, 2022 11:39 AM
>>
>> On 2022/6/21 10:54, Tian, Kevin wrote:
>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Sent: Monday, June 20, 2022 4:17 PM
>>>> @@ -2564,7 +2564,7 @@ static int domain_add_dev_info(struct
>>>> dmar_domain *domain, struct device *dev)
>>>>    			ret = intel_pasid_setup_second_level(iommu,
>>>> domain,
>>>>    					dev, PASID_RID2PASID);
>>>>    		spin_unlock_irqrestore(&iommu->lock, flags);
>>>> -		if (ret) {
>>>> +		if (ret && ret != -EBUSY) {
>>>>    			dev_err(dev, "Setup RID2PASID failed\n");
>>>>    			dmar_remove_one_dev_info(dev);
>>>>    			return ret;
>>>> --
>>>> 2.25.1
>>>
>>> It's cleaner to avoid this error at the first place, i.e. only do the
>>> setup when the first device is attached to the pasid table.
>>
>> The logic that identifies the first device might introduce additional
>> unnecessary complexity. Devices that share a pasid table are rare. I
>> even prefer to give up sharing tables so that the code can be
>> simpler.:-)
>>
> 
> It's not that complex if you simply move device_attach_pasid_table()
> out of intel_pasid_alloc_table(). Then do the setup if
> list_empty(&pasid_table->dev) and then attach device to the
> pasid table in domain_add_dev_info().

The pasid table is part of the device, hence a better place to
allocate/free the pasid table is in the device probe/release paths.
Things will become more complicated if we change relationship between
device and it's pasid table when attaching/detaching a domain. That's
the reason why I thought it was additional complexity.

--
Best regards,
baolu
