Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B75BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 03:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344563AbiDLDiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 23:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiDLDiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 23:38:14 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0589186D2;
        Mon, 11 Apr 2022 20:35:57 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0V9sqOTP_1649734551;
Received: from 30.225.24.141(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V9sqOTP_1649734551)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 12 Apr 2022 11:35:53 +0800
Message-ID: <a20ca50f-1d1a-d09e-75da-f6ced65f6c93@linux.alibaba.com>
Date:   Tue, 12 Apr 2022 11:35:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v8 04/20] cachefiles: notify user daemon when withdrawing
 cookie
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org, luodaowen.backend@bytedance.com,
        tianzichen@kuaishou.com, fannaihao@baidu.com
References: <542f749c-b0f1-1de6-cb41-26e296afb2df@linux.alibaba.com>
 <20220406075612.60298-5-jefflexu@linux.alibaba.com>
 <20220406075612.60298-1-jefflexu@linux.alibaba.com>
 <1091405.1649680508@warthog.procyon.org.uk>
 <1094493.1649684554@warthog.procyon.org.uk>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <1094493.1649684554@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/11/22 9:42 PM, David Howells wrote:
> JeffleXu <jefflexu@linux.alibaba.com> wrote:
> 
>>>
>>>> +	if (fd == 0)
>>>> +		return -ENOENT;
>>>
>>> 0 is a valid fd.
>>
>> Yeah, but IMHO fd 0 is always for stdin? I think the allocated anon_fd
>> won't install at fd 0. Please correct me if I'm wrong.
> 
> If someone has closed 0, then you'll get 0 next, I'm pretty sure.  Try it and
> see.

Good catch.

> 
>> In fact I wanna use "fd == 0" as the initial state as struct
>> cachefiles_object is allocated with kmem_cache_zalloc().
> 
> I would suggest presetting it to something like -2 to avoid confusion.

Okay, as described in the previous email, I'm going to replace @fd to
@object_id. I will define some symbols to make it more readable,
something like

```
struct cachefiles_object {
	...
#ifdef CONFIG_CACHEFILES_ONDEMAND
#define CACHEFILES_OBJECT_ID_DEFAULT -2
#define CACHEFILES_OBJECT_ID_DEAD    -1
	int object_id;
#endif
	...
}
```

Thanks for your time.

-- 
Thanks,
Jeffle
