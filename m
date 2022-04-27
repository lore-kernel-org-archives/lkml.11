Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FE6C433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Apr 2022 07:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359101AbiD0H4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Apr 2022 03:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359090AbiD0H4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:56:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6CC1B13FDA0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:52:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 383FCED1;
        Wed, 27 Apr 2022 00:52:54 -0700 (PDT)
Received: from [10.57.7.196] (unknown [10.57.7.196])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF4A63F5A1;
        Wed, 27 Apr 2022 00:52:52 -0700 (PDT)
Message-ID: <38c8a684-5fcc-cfb3-424c-d353a7bafe03@arm.com>
Date:   Wed, 27 Apr 2022 08:52:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3] arch_topology: Trace the update thermal pressure
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        rafael@kernel.org, rostedt@goodmis.org, mingo@redhat.com
References: <20220427073551.19032-1-lukasz.luba@arm.com>
 <Ymj0ZZeUnhq4W/Ws@kroah.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <Ymj0ZZeUnhq4W/Ws@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/27/22 08:44, Greg KH wrote:
> On Wed, Apr 27, 2022 at 08:35:51AM +0100, Lukasz Luba wrote:
>> Add trace event to capture the moment of the call for updating the thermal
>> pressure value. It's helpful to investigate how often those events occur
>> in a system dealing with throttling. This trace event is needed since the
>> old 'cdev_update' might not be used by some drivers.
>>
>> The old 'cdev_update' trace event only provides a cooling state
>> value: [0, n]. That state value then needs additional tools to translate
>> it: state -> freq -> capacity -> thermal pressure. This new trace event
>> just stores proper thermal pressure value in the trace buffer, no need
>> for additional logic. This is helpful for cooperation when someone can
>> simply sends to the list the trace buffer output from the platform (no
>> need from additional information from other subsystems).
>>
>> There are also platforms which due to some design reasons don't use
>> cooling devices and thus don't trigger old 'cdev_update' trace event.
>> They are also important and measuring latency for the thermal signal
>> raising/decaying characteristics is in scope. This new trace event
>> would cover them as well.
>>
>> We already have a trace point 'pelt_thermal_tp' which after a change to
>> trace event can be paired with this new 'thermal_pressure_update' and
>> derive more insight what is going on in the system under thermal pressure
>> (and why).
>>
>> Reported-by: kernel test robot <lkp@intel.com>
> 
> The kernel test robot did not report that you needed to add a new trace
> event :(
> 

I got feedback from the test robot for v1, which figured out that
the riscv configuration is broken. You can find it here
https://lore.kernel.org/lkml/202204201654.vcszVDGb-lkp@intel.com/

So, I've added that tag following:
"If you fix the issue, kindly add following tag as appropriate"

Should this only be honored when a patch actually got into next
and then following patch with a fix would have that tag?
