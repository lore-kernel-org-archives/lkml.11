Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AF8C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jun 2022 13:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347722AbiFANeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jun 2022 09:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbiFANep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 09:34:45 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D1D6D4DE
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 06:34:43 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LCqpP3SF3zgYSY;
        Wed,  1 Jun 2022 21:33:01 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 1 Jun 2022 21:34:41 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 1 Jun 2022 21:34:41 +0800
Message-ID: <8ad1aa0b-ff8d-6a9a-d516-16425b45a55a@huawei.com>
Date:   Wed, 1 Jun 2022 21:34:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/4] mm/shmem: check return value of shmem_init_inodecache
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Chen Wandun <chenwandun@huawei.com>
CC:     <hughd@google.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220601124417.2872001-1-chenwandun@huawei.com>
 <20220601124417.2872001-2-chenwandun@huawei.com>
 <YpdhehYSyJFOj3Tq@casper.infradead.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <YpdhehYSyJFOj3Tq@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/6/1 20:54, Matthew Wilcox wrote:
> On Wed, Jun 01, 2022 at 08:44:14PM +0800, Chen Wandun wrote:
>> -static void shmem_init_inodecache(void)
>> +static struct kmem_cache *shmem_init_inodecache(void)
>>   {
>>   	shmem_inode_cachep = kmem_cache_create("shmem_inode_cache",
>>   				sizeof(struct shmem_inode_info),
>>   				0, SLAB_PANIC|SLAB_ACCOUNT, shmem_init_inode);
>> +
>> +	return shmem_inode_cachep;
>>   }
>>   
>>   static void shmem_destroy_inodecache(void)
>> @@ -3924,7 +3926,10 @@ void __init shmem_init(void)
>>   {
>>   	int error;
>>   
>> -	shmem_init_inodecache();
>> +	if (!shmem_init_inodecache()) {
>> +		error = -ENOMEM;
>> +		goto out2;
>> +	}
> better to return the errno from shmem_init_inodecache():
>
> 	error = shmem_init_inodecache();

kmem_cache_create return a pointer to the cache on success, NULL on failure，
so error = -ENOMEM; is right  :)

> 	if (error)
> 		goto out2;
>
> .
