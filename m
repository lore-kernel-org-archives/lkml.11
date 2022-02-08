Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB53C433FE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 05:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347315AbiBHFdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 00:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347083AbiBHE4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 23:56:22 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6206C0401DC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 20:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644296181; x=1675832181;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4UHp9b3HCNBC/b2FQ4096XNfzyJtrjHTTByZZ54WrXk=;
  b=JJyMifrqAhBMCSDsdKk45n0aAhUb0afXWCHbHxJ2O2sNIT67KS5L+J3G
   6N+W7UKhShp/M3d2jPzI+oL6KchZFEz6JDjSxHEqzgWDqaI8a1PPk7Ooz
   Jf6dNofP3rxm1YmbLZESre7OwxOQlE+5lxhX2+pPr6L0P+eS6ylAv7oTR
   Z43tBBJ43xdY0ipiYFd5X9wLrV+qcSvk+c/KYR1DVCgwlj16bUR9F1E3Z
   xIyMAt5el+ngr95dwFyMHakS6viCY4DMw2p9uXURyTy1vmw3Jy7bwyngY
   hYVhEGSk0mY2eSgV0QGyilayzH/elSABPQMo3OPj1h/m93ZVA/AmxZID3
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="335273603"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="335273603"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 20:56:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="677988831"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2022 20:56:17 -0800
Message-ID: <6c650dcb-294b-975a-9836-05973f9ea852@linux.intel.com>
Date:   Tue, 8 Feb 2022 12:55:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 09/10] iommu/vt-d: Refactor dmar_insert_one_dev_info()
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
 <20220207064142.1092846-10-baolu.lu@linux.intel.com>
 <20220207102725.3ce9320d@jacob-builder>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220207102725.3ce9320d@jacob-builder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/22 2:27 AM, Jacob Pan wrote:
> Hi BaoLu,

Hi Jacob,
> 
> On Mon,  7 Feb 2022 14:41:41 +0800, Lu Baolu <baolu.lu@linux.intel.com>
> wrote:
> 
>>   static void intel_iommu_release_device(struct device *dev)
>>   {
>> -	struct intel_iommu *iommu;
>> -
>> -	iommu = device_to_iommu(dev, NULL, NULL);
>> -	if (!iommu)
>> -		return;
>> -
>> -	dmar_remove_one_dev_info(dev);
>> +	struct device_domain_info *info = get_domain_info(dev);
>> +	unsigned long index = DEVI_IDX(info->segment, info->bus,
>> info->devfn);
>> +	xa_erase(&device_domain_array, index);
>> +	dev_iommu_priv_set(info->dev, NULL);
>>   	set_dma_ops(dev, NULL);
>> +	kfree(info);
> Now that info and sinfo are under RCU, should we use kfree_rcu?

Yes. We should use kfree_rcu.

Best regards,
baolu
