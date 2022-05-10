Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4BEC433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 May 2022 09:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239276AbiEJJvT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 May 2022 05:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239287AbiEJJvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:51:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B67402317E2
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 02:47:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 837E91063;
        Tue, 10 May 2022 02:47:08 -0700 (PDT)
Received: from [10.57.80.111] (unknown [10.57.80.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B83D3F66F;
        Tue, 10 May 2022 02:47:06 -0700 (PDT)
Message-ID: <9da605e9-2cbd-6d8f-7425-fdfe2e744d3a@arm.com>
Date:   Tue, 10 May 2022 10:47:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v1] ARM: A9: Add ARM ERRATA 764319 workaround
Content-Language: en-GB
To:     Arnd Bergmann <arnd@arndb.de>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
References: <20220506192957.24889-1-nick.hawkins@hpe.com>
 <CAK8P3a045Di_zRomezeah0ZoSGPw0Z6YoYkZtoxx1qOXAtKbbw@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAK8P3a045Di_zRomezeah0ZoSGPw0Z6YoYkZtoxx1qOXAtKbbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-10 08:19, Arnd Bergmann wrote:
> On Fri, May 6, 2022 at 9:29 PM <nick.hawkins@hpe.com> wrote:
>>
>> From: Nick Hawkins <nick.hawkins@hpe.com>
>>
>> Enable the workaround for the 764319 Cortex A-9 erratum.
>> CP14 read accesses to the DBGPRSR and DBGOSLSR registers generate an
>> unexpected Undefined Instruction exception when the DBGSWENABLE external
>> pin is set to 0, even when the CP14 accesses are performed from a
>> privileged mode. The work around catches the exception in a way
>> the kernel does not stop execution with the use of undef_hook. This
>> has been found to effect the HPE GXP SoC.
>>
>> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
>> ---
>>   arch/arm/Kconfig                | 11 +++++++++++
>>   arch/arm/kernel/hw_breakpoint.c | 26 ++++++++++++++++++++++++++
>>   2 files changed, 37 insertions(+)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 13f77eec7c40..6944adfb0fae 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -974,6 +974,17 @@ config ARM_ERRATA_764369
>>            relevant cache maintenance functions and sets a specific bit
>>            in the diagnostic control register of the SCU.
>>
>> +config ARM_ERRATA_764319
>> +       bool "ARM errata: Read to DBGPRSR and DBGOSLSR may generate Undefined instruction"
>> +       depends on CPU_V7
>> +       help
>> +         This option enables the workaround for the 764319 Cortex A-9 erratum.
>> +         CP14 read accesses to the DBGPRSR and DBGOSLSR registers generate an
>> +         unexpected Undefined Instruction exception when the DBGSWENABLE
>> +         external pin is set to 0, even when the CP14 accesses are performed
>> +         from a privileged mode. This work around catches the exception in a
>> +         way the kernel does not stop execution.
>> +
>>   config ARM_ERRATA_775420
>>          bool "ARM errata: A data cache maintenance operation which aborts, might lead to deadlock"
>>          depends on CPU_V7
>> diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
>> index b1423fb130ea..c41a8436a796 100644
>> --- a/arch/arm/kernel/hw_breakpoint.c
>> +++ b/arch/arm/kernel/hw_breakpoint.c
>> @@ -941,6 +941,23 @@ static int hw_breakpoint_pending(unsigned long addr, unsigned int fsr,
>>          return ret;
>>   }
>>
>> +#ifdef CONFIG_ARM_ERRATA_764319
>> +int oslsr_fault;
>> +
>> +static int debug_oslsr_trap(struct pt_regs *regs, unsigned int instr)
>> +{
>> +       oslsr_fault = 1;
>> +       instruction_pointer(regs) += 4;
>> +       return 0;
>> +}
>> +
>> +static struct undef_hook debug_oslsr_hook = {
>> +       .instr_mask  = 0xffffffff,
>> +       .instr_val = 0xee115e91,
>> +       .fn = debug_oslsr_trap,
>> +};
>> +#endif
>> +
> 
> Hi Nick,
> 
> This seems a bit more complex than necessary. Can't you just use a custom
> inline asm with an ex_table entry to catch the fault? Have a look at
> __get_user_asm() for an example.

Indeed, according to the Cortex-A9 documentation the register should 
always read as zero anyway, so all we should need to do is initialise 
the local oslsr variable to 0 and have the fault handler just return to 
the next instruction.

Robin.
