Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC09C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Apr 2022 20:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356472AbiDSUSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Apr 2022 16:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237014AbiDSUSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:18:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65D7441981
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 13:15:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F401E1063;
        Tue, 19 Apr 2022 13:15:52 -0700 (PDT)
Received: from [10.57.41.251] (unknown [10.57.41.251])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B021B3F73B;
        Tue, 19 Apr 2022 13:15:50 -0700 (PDT)
Message-ID: <2768d617-1c61-3b12-e32f-3901881ebe3d@arm.com>
Date:   Tue, 19 Apr 2022 21:15:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] iommu/arm-smmu-v3: Align size in __arm_smmu_tlb_inv_range
Content-Language: en-GB
To:     Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     will@kernel.org, joro@8bytes.org, thunder.leizhen@huawei.com,
        tglx@linutronix.de, john.garry@huawei.com,
        jean-philippe@linaro.org, christophe.jaillet@wanadoo.fr,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20220413041745.35174-1-nicolinc@nvidia.com>
 <37c02fc4-d793-b003-f612-206c987a8a42@arm.com>
 <YlcwPG5RXmJ6U7YS@Asurada-Nvidia>
 <13c91dfb-c540-ed8d-daa7-eab7207df221@arm.com>
 <Yloj6GM+yykImKvp@Asurada-Nvidia> <20220419200233.GN64706@ziepe.ca>
 <Yl8WF9R7tubSgREw@Asurada-Nvidia>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Yl8WF9R7tubSgREw@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-19 21:05, Nicolin Chen wrote:
> On Tue, Apr 19, 2022 at 05:02:33PM -0300, Jason Gunthorpe wrote:
> 
>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>>> index d816759a6bcf..e280568bb513 100644
>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>>> @@ -183,7 +183,7 @@ static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
>>>   {
>>>          struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
>>>          struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
>>> -       size_t size = end - start + 1;
>>> +       size_t size = end - start;
>>
>> +1 to this bug fix. You should send a formal patch for stable with a fixes/etc
>>
>> mmu notifiers uses 'end' not 'last' in alignment with how VMA's work:
>>
>> include/linux/mm_types.h:       unsigned long vm_end;           /* The first byte after our end address
> 
> Thanks for the review!
> 
> Yea, I will send a new patch.

Yup, +1 from me too - this is exactly the kind of thing I suspected - 
and I reckon it might even be worth a comment in the code here that mm's 
"end" is an exclusive limit, to help us remember in future. If there 
doesn't look to be any way for completely arbitrarily-aligned addresses 
to slip through then I'd be tempted to leave it at that (i.e. reason 
that if the infinite loop can only happen due to catastrophic failure 
then it's beyond the scope of things that are worth trying to mitigate), 
but I'll let Jean and Will have the final say there.

Cheers,
Robin.
