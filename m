Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D37BC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 May 2022 12:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242524AbiEKMhr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 May 2022 08:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242526AbiEKMhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:37:39 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF991FD878
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:37:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0VCwIZRf_1652272646;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VCwIZRf_1652272646)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 11 May 2022 20:37:28 +0800
Subject: Re: [PATCH] RISC-V: Remove IORESOURCE_BUSY flag for no-map reserved
 memory
To:     David Hildenbrand <david@redhat.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        akpm@linux-foundation.org, anup@brainfault.org,
        wangkefeng.wang@huawei.com, rppt@kernel.org, alex@ghiti.fr,
        twd2.me@gmail.com, seanjc@google.com, petr.pavlu@suse.com,
        atishp@rivosinc.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        guoren@kernel.org, jianghuaming.jhm@alibaba-inc.com,
        Nick Kossifidis <mick@ics.forth.gr>
References: <20220511112413.559734-1-xianting.tian@linux.alibaba.com>
 <4407c84b-a64f-51b0-fa96-388aaf3b3e35@redhat.com>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <f12c2576-1bd4-970d-4435-59273c5de0fc@linux.alibaba.com>
Date:   Wed, 11 May 2022 20:37:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <4407c84b-a64f-51b0-fa96-388aaf3b3e35@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/5/11 下午8:27, David Hildenbrand 写道:
> On 11.05.22 13:24, Xianting Tian wrote:
>> Commit 00ab027a3b82 ("RISC-V: Add kernel image sections to the resource tree")
>> added IORESOURCE_BUSY flag for no-map reserved memory, this casued
>> devm_ioremap_resource() failed for the no-map reserved memory in subsequent
>> operations of related driver, so remove the IORESOURCE_BUSY flag.
>>
>> The code to reproduce the issue,
>> dts:
>> 	mem0: memory@a0000000 {
>>                  reg = <0x0 0xa0000000 0 0x1000000>;
>>                  no-map;
>>          };
>>
>> 	&test {
>> 		status = "okay";
>> 		memory-region = <&mem0>;
>> 	};
>>
>> code:
>> 	np = of_parse_phandle(pdev->dev.of_node, "memory-region", 0);
>> 	ret = of_address_to_resource(np, 0, &r);
>> 	base = devm_ioremap_resource(&pdev->dev, &r);
>> 	// base = -EBUSY
>>
>> Fixes: 00ab027a3b82 ("RISC-V: Add kernel image sections to the resource tree")
>> Reported-by: Huaming Jiang <jianghuaming.jhm@alibaba-inc.com>
>> Reviewed-by: Guo Ren <guoren@kernel.org>
>> CC: Nick Kossifidis <mick@ics.forth.gr>
>> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
>> ---
>>   arch/riscv/kernel/setup.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>> index 834eb652a7b9..71f2966b1474 100644
>> --- a/arch/riscv/kernel/setup.c
>> +++ b/arch/riscv/kernel/setup.c
>> @@ -214,7 +214,7 @@ static void __init init_resources(void)
>>   
>>   		if (unlikely(memblock_is_nomap(region))) {
>>   			res->name = "Reserved";
>> -			res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
>> +			res->flags = IORESOURCE_MEM;
>>   		} else {
>>   			res->name = "System RAM";
>>   			res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> I assume the "Reserved" part is essentially unused by the kernel correct?

I think we may use it, actually we found the issue in our product after 
merged kdump functionality.

Actually, the code didn't add IORESOURCE_BUSY for no-map reserved memory 
before 00ab027a3b82 merged,  so it is a typo for commit 00ab027a3b82 to 
add IORESOURCE_BUSY?

>
