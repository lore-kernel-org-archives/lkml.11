Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F034BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 02:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235961AbiCNCuU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Mar 2022 22:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiCNCuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 22:50:17 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C18D35DE7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 19:49:07 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KH18B2pRgz1GCMN;
        Mon, 14 Mar 2022 10:44:10 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Mar 2022 10:49:05 +0800
Subject: Re: [PATCH] mm/mlock: fix potential imbalanced rlimit ucounts
 adjustment
To:     Hugh Dickins <hughd@google.com>
CC:     <akpm@linux-foundation.org>, <Herbert.van.den.Bergh@oracle.com>,
        <chris.mason@oracle.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220310132417.41189-1-linmiaohe@huawei.com>
 <268b3146-2963-15b6-6d6-95a96853314@google.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <bcfc2048-93ce-b357-8671-7070614db36a@huawei.com>
Date:   Mon, 14 Mar 2022 10:49:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <268b3146-2963-15b6-6d6-95a96853314@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/14 10:40, Hugh Dickins wrote:
> On Thu, 10 Mar 2022, Miaohe Lin wrote:
> 
>> user_shm_lock forgets to set allowed to 0 when get_ucounts fails. So
>> the later user_shm_unlock might do the extra dec_rlimit_ucounts. Fix
>> this by resetting allowed to 0.
>>
>> Fixes: 5ed44a401ddf ("do not limit locked memory when RLIMIT_MEMLOCK is RLIM_INFINITY")
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> NAK.  user_shm_lock() remembers to declare "int allowed = 0" on entry.
> 

If lock_limit is RLIM_INFINITY, "allowed" will be set to 1. And if get_ucounts fails
in some corner cases, "allowed" will remain to be 1 while the user_shm_lock ops indeed
fails. Or am I miss something?

Many thanks for comment.

>> ---
>>  mm/mlock.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/mm/mlock.c b/mm/mlock.c
>> index 29372c0eebe5..efd2dd2943de 100644
>> --- a/mm/mlock.c
>> +++ b/mm/mlock.c
>> @@ -733,6 +733,7 @@ int user_shm_lock(size_t size, struct ucounts *ucounts)
>>  	}
>>  	if (!get_ucounts(ucounts)) {
>>  		dec_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, locked);
>> +		allowed = 0;
>>  		goto out;
>>  	}
>>  	allowed = 1;
>> -- 
>> 2.23.0
>>
>>
>>
> .
> 

