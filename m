Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C77C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Apr 2022 06:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384819AbiDUG3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Apr 2022 02:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384813AbiDUG3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:29:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E7B513F26
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:26:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E71BB1477;
        Wed, 20 Apr 2022 23:26:47 -0700 (PDT)
Received: from [192.168.33.4] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A9A93F73B;
        Wed, 20 Apr 2022 23:26:46 -0700 (PDT)
Message-ID: <57119511-471e-8700-959b-4094e6bd1a76@arm.com>
Date:   Thu, 21 Apr 2022 07:26:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] arch_topology: Trace the update thermal pressure
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com
References: <20220419164801.29078-1-lukasz.luba@arm.com>
 <20220420194451.6b9661a0@gandalf.local.home>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220420194451.6b9661a0@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/21/22 00:44, Steven Rostedt wrote:
> On Tue, 19 Apr 2022 17:48:01 +0100
> Lukasz Luba <lukasz.luba@arm.com> wrote:
> 
>> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
>> index 1d6636ebaac5..4f0392de3081 100644
>> --- a/drivers/base/arch_topology.c
>> +++ b/drivers/base/arch_topology.c
>> @@ -19,6 +19,8 @@
>>   #include <linux/rcupdate.h>
>>   #include <linux/sched.h>
>>   
>> +#include <trace/events/thermal.h>
>> +
>>   static DEFINE_PER_CPU(struct scale_freq_data __rcu *, sft_data);
>>   static struct cpumask scale_freq_counters_mask;
>>   static bool scale_freq_invariant;
>> @@ -195,6 +197,8 @@ void topology_update_thermal_pressure(const struct cpumask *cpus,
>>   
>>   	th_pressure = max_capacity - capacity;
>>   
>> +	trace_thermal_pressure_update(cpu, th_pressure);
>> +
>>   	for_each_cpu(cpu, cpus)
>>   		WRITE_ONCE(per_cpu(thermal_pressure, cpu), th_pressure);
>>   }
>> diff --git a/include/trace/events/thermal.h b/include/trace/events/thermal.h
>> index 8a5f04888abd..1bf08ee1a25b 100644
>> --- a/include/trace/events/thermal.h
>> +++ b/include/trace/events/thermal.h
>> @@ -65,6 +65,25 @@ TRACE_EVENT(cdev_update,
>>   	TP_printk("type=%s target=%lu", __get_str(type), __entry->target)
>>   );
>>   
>> +TRACE_EVENT(thermal_pressure_update,
>> +
>> +	TP_PROTO(int cpu, unsigned long thermal_pressure),
>> +
>> +	TP_ARGS(cpu, thermal_pressure),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(int, cpu)
>> +		__field(unsigned long, thermal_pressure)
> 
> Note, it is always best to place the bigger object before the smaller one
> (when not properly aligned), as that will help to prevent structure
> "holes". That is:
> 
> 		__field(unsigned long, thermal_pressure)
> 		__field(int, cpu)
> 
> 
> Otherwise, you are pretty much guaranteed to have a 4 byte hole between cpu
> and thermal_pressure on 64 bit machines.
> 
> Also, for the warning you got from the test robot, if you are using this in
> a module and defining it in the core kernel, you need to add:
> 
> EXPORT_TRACEPOINT_SYMBOL_GPL(thermal_pressure_update);
> 
> Somewhere in the C file that includes this file and defines
> CREATE_TRACE_POINTS.
> 
> -- Steve
> 
> 

Thank you Steve, I'll swap those fields and add the needed export.
I have to go through those older trace events in that file and
understand if they are correct, since I just followed the pattern
in 'cdev_update'.

Regards,
Lukasz
