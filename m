Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94B7C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 06:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239755AbiCJGYm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 01:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbiCJGYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 01:24:39 -0500
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D587A3F8B4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 22:23:38 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V6nNtMc_1646893414;
Received: from 30.97.48.73(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V6nNtMc_1646893414)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 10 Mar 2022 14:23:35 +0800
Message-ID: <be249da5-1f10-165a-02a4-a2342cd18692@linux.alibaba.com>
Date:   Thu, 10 Mar 2022 14:24:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] mm: Only re-generate demotion targets when a numa node
 changes its N_CPU state
To:     Oscar Salvador <osalvador@suse.de>,
        "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220309144644.4278-1-osalvador@suse.de>
 <87bkyefxnq.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <YimRJS9XFE8nswkd@localhost.localdomain>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <YimRJS9XFE8nswkd@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oscar,

On 3/10/2022 1:48 PM, Oscar Salvador wrote:
> On Thu, Mar 10, 2022 at 08:39:53AM +0800, Huang, Ying wrote:
>> We need to call set_migration_target_nodes() during system boot
>> somewhere, either here or in init_mm_internals().
> 
> Hi Huang Ying,
> 
> vmstat_cpu_online() already gets called during boot:
> 
> static struct cpuhp_step cpuhp_hp_states[] = {
> ...
> 	#ifdef CONFIG_SMP
> 	[CPUHP_CREATE_THREADS]= {
> 		.name			= "threads:prepare",
> 		.startup.single		= smpboot_create_threads,
> 		.teardown.single	= NULL,
> 		.cant_stop		= true,
> 	},
> ...
> 
> smpboot_create_threads
>   __smpboot_create_thread
>    smpboot_thread_fn
>     ht->thread_fn()
>      cpuhp_thread_fun
>       cpuhp_invoke_callback
>        vmstat_cpu_online
> 
> That for every CPU that is brought up during boot.
> 
> So unless I am missing something, I would say we are already covered
> there, right?

I've tested your patch, unfortunately it can not work. It already set 
the node with N_CPU state in init_cpu_node_state() earlier, so in 
vmstat_cpu_online() ,the sentence 'if(!node_state(cpu_to_node(cpu), 
N_CPU))' is always false, which means it will not call 
set_migration_target_nodes().

Like Huang Ying said, we should call set_migration_target_nodes() in 
migrate_on_reclaim_init() or init_mm_internals().
