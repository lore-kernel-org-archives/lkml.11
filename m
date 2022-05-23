Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AF1C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 May 2022 13:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbiEWNKk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 May 2022 09:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235951AbiEWNKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:10:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B97D54183
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:10:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76FF41063;
        Mon, 23 May 2022 06:10:35 -0700 (PDT)
Received: from [10.57.82.55] (unknown [10.57.82.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA1543F70D;
        Mon, 23 May 2022 06:10:33 -0700 (PDT)
Message-ID: <1c90b375-e738-95b3-6904-8c373a0b28d6@arm.com>
Date:   Mon, 23 May 2022 14:10:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Avoid leak OF node on error
Content-Language: en-GB
To:     Johan Hovold <johan@kernel.org>, cgel.zte@gmail.com
Cc:     linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        iommu@lists.linux-foundation.org, will@kernel.org,
        Zeal Robot <zealci@zte.com.cn>
References: <20220523111145.2976-1-chi.minghao@zte.com.cn>
 <Yot13L7XgvxTkgnE@hovoldconsulting.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Yot13L7XgvxTkgnE@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-23 12:54, Johan Hovold wrote:
> On Mon, May 23, 2022 at 11:11:45AM +0000, cgel.zte@gmail.com wrote:
>> From: Minghao Chi <chi.minghao@zte.com.cn>
>>
>> The OF node should be put before returning error in ipmmu_init(),
>> otherwise node's refcount will be leaked.
>>
>> Reported-by: Zeal Robot <zealci@zte.com.cn>
>> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
>> ---
>>   drivers/iommu/ipmmu-vmsa.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
>> index 8fdb84b3642b..f6440b106f46 100644
>> --- a/drivers/iommu/ipmmu-vmsa.c
>> +++ b/drivers/iommu/ipmmu-vmsa.c
>> @@ -1179,11 +1179,10 @@ static int __init ipmmu_init(void)
>>   		return 0;
>>   
>>   	np = of_find_matching_node(NULL, ipmmu_of_ids);
>> +	of_node_put(np);
>>   	if (!np)
>>   		return 0;
>>   
>> -	of_node_put(np);
>> -
>>   	ret = platform_driver_register(&ipmmu_driver);
>>   	if (ret < 0)
>>   		return ret;
> 
> NAK

Indeed. How exactly can we hold a refcount on NULL, let alone leak it?

Static checkers are great for flagging up code that *might* have issues, 
but please actually *look* at the code and apply some thought before 
sending a patch.

Robin.
