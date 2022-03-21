Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC125C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 14:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349560AbiCUOo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 10:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349508AbiCUOow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:44:52 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4898E3BBC6;
        Mon, 21 Mar 2022 07:43:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0V7rWiGy_1647873800;
Received: from 192.168.31.65(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V7rWiGy_1647873800)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 21 Mar 2022 22:43:22 +0800
Message-ID: <a1543a27-7f52-266b-dd67-972902e80e8e@linux.alibaba.com>
Date:   Mon, 21 Mar 2022 22:43:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v5 04/22] cachefiles: notify user daemon with anon_fd when
 looking up cookie
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org, luodaowen.backend@bytedance.com
References: <20220316131723.111553-5-jefflexu@linux.alibaba.com>
 <20220316131723.111553-1-jefflexu@linux.alibaba.com>
 <1029248.1647871294@warthog.procyon.org.uk>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <1029248.1647871294@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/21/22 10:01 PM, David Howells wrote:
> Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> 
>> +	read_lock(&cache->reqs_lock);
>> +
>> +	/* recheck dead state under lock */
>> +	if (test_bit(CACHEFILES_DEAD, &cache->flags)) {
>> +		read_unlock(&cache->reqs_lock);
>> +		ret = -EIO;
>> +		goto out;
>> +	}
>> +
>> +	xa_lock(xa);
>> +	ret = __xa_alloc(xa, &id, req, xa_limit_32b, GFP_KERNEL);
> 
> You're holding a spinlock.  You can't use GFP_KERNEL.

Oh yes... I've dropped into this for second time... Sorry for that.

> 
>> +static int cachefiles_ondemand_cinit(struct cachefiles_cache *cache, char *args)
>> +{
>> ...
>> +	tmp = kstrdup(args, GFP_KERNEL);
> 
> No need to copy the string.  The caller already did that and added a NUL for
> good measure.

Right.


> 
> I would probably move most of the functions added in this patch to
> fs/cachefiles/ondemand.c.

Alright.


-- 
Thanks,
Jeffle
