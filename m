Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A80DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 01:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbiCVBwJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 21:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbiCVBwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 21:52:05 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F0F3BA5B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 18:50:37 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KMvXv1j8KzfZSf;
        Tue, 22 Mar 2022 09:49:03 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Mar 2022 09:50:35 +0800
Subject: Re: [PATCH v2] mm/mempolicy: fix mpol_new leak in
 shared_policy_replace
To:     Michal Hocko <mhocko@suse.com>
CC:     <akpm@linux-foundation.org>, <kosaki.motohiro@jp.fujitsu.com>,
        <mgorman@suse.de>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220322083456.16563-1-linmiaohe@huawei.com>
 <YjhrkDlvOnmqIP6n@dhcp22.suse.cz>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <8c7d2ef2-08d7-ea50-a82b-9e9800c5f54c@huawei.com>
Date:   Tue, 22 Mar 2022 09:50:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YjhrkDlvOnmqIP6n@dhcp22.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/21 20:12, Michal Hocko wrote:
> On Tue 22-03-22 16:34:56, Miaohe Lin wrote:
>> If mpol_new is allocated but not used in restart loop, mpol_new will be
>> freed via mpol_put before returning to the caller.  But refcnt is not
>> initialized yet, so mpol_put could not do the right things and might leak
>> the unused mpol_new.
> 
> I would just add:
> 
> This would happen if mempolicy was updated on the shared shmem file
> while the sp->lock has been dropped during the memory allocation.
> 

Do you mean the below commit log?

"""
If mpol_new is allocated but not used in restart loop, mpol_new will be
freed via mpol_put before returning to the caller.  But refcnt is not
initialized yet, so mpol_put could not do the right things and might leak
the unused mpol_new. This would happen if mempolicy was updated on the
shared shmem file while the sp->lock has been dropped during the memory
allocation.

This issue could be triggered easily with the below code snippet if
there're many processes doing the below work at the same time:

  shmid = shmget((key_t)5566, 1024 * PAGE_SIZE, 0666|IPC_CREAT);
  shm = shmat(shmid, 0, 0);
  loop many times {
    mbind(shm, 1024 * PAGE_SIZE, MPOL_LOCAL, mask, maxnode, 0);
    mbind(shm + 128 * PAGE_SIZE, 128 * PAGE_SIZE, MPOL_DEFAULT, mask,
          maxnode, 0);
  }
"""

>> This issue could be triggered easily with the below
>> code snippet if there're many processes doing the below work at the same
>> time:
>>
>>   shmid = shmget((key_t)5566, 1024 * PAGE_SIZE, 0666|IPC_CREAT);
>>   shm = shmat(shmid, 0, 0);
>>   loop many times {
>>     mbind(shm, 1024 * PAGE_SIZE, MPOL_LOCAL, mask, maxnode, 0);
>>     mbind(shm + 128 * PAGE_SIZE, 128 * PAGE_SIZE, MPOL_DEFAULT, mask,
>>           maxnode, 0);
>>   }
>>
>> Fixes: 42288fe366c4 ("mm: mempolicy: Convert shared_policy mutex to spinlock")
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> Cc: <stable@vger.kernel.org> # 3.8
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Thanks a lot!

Many thanks for comment and Acked-by tag! :)

>> ---
>> v1->v2:
>>   Add reproducer snippet and Cc stable.
>>   Thanks Michal Hocko for review and comment!
>> ---
>>  mm/mempolicy.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
>> index a2516d31db6c..4cdd425b2752 100644
>> --- a/mm/mempolicy.c
>> +++ b/mm/mempolicy.c
>> @@ -2733,6 +2733,7 @@ static int shared_policy_replace(struct shared_policy *sp, unsigned long start,
>>  	mpol_new = kmem_cache_alloc(policy_cache, GFP_KERNEL);
>>  	if (!mpol_new)
>>  		goto err_out;
>> +	refcount_set(&mpol_new->refcnt, 1);
>>  	goto restart;
>>  }
>>  
>> -- 
>> 2.23.0
> 

