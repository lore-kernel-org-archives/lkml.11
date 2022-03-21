Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84688C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 14:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347400AbiCUOZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 10:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352856AbiCUOXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:23:08 -0400
Received: from out199-4.us.a.mail.aliyun.com (out199-4.us.a.mail.aliyun.com [47.90.199.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88201AF51C;
        Mon, 21 Mar 2022 07:17:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0V7rRN9d_1647872182;
Received: from 192.168.31.65(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V7rRN9d_1647872182)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 21 Mar 2022 22:16:23 +0800
Message-ID: <eb558006-e5f2-59fe-9c58-844c6deff4dd@linux.alibaba.com>
Date:   Mon, 21 Mar 2022 22:16:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v5 03/22] cachefiles: introduce on-demand read mode
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org, luodaowen.backend@bytedance.com
References: <20220316131723.111553-4-jefflexu@linux.alibaba.com>
 <20220316131723.111553-1-jefflexu@linux.alibaba.com>
 <1027872.1647869684@warthog.procyon.org.uk>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <1027872.1647869684@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for reviewing.


On 3/21/22 9:34 PM, David Howells wrote:
> Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> 
>> Fscache/cachefiles used to serve as a local cache for remote fs. This
>> patch, along with the following patches, introduces a new on-demand read
>> mode for cachefiles, which can boost the scenario where on-demand read
>> semantics is needed, e.g. container image distribution.
>>
>> The essential difference between the original mode and on-demand read
>> mode is that, in the original mode, when cache miss, netfs itself will
>> fetch data from remote, and then write the fetched data into cache file.
>> While in on-demand read mode, a user daemon is responsible for fetching
>> data and then writing to the cache file.
>>
>> This patch only adds the command to enable on-demand read mode. An optional
>> parameter to "bind" command is added. On-demand mode will be turned on when
>> this optional argument matches "ondemand" exactly, i.e.  "bind
>> ondemand". Otherwise cachefiles will keep working in the original mode.
> 
> You're not really adding a command, per se.  Also, I would recommend
> starting the paragraph with a verb.  How about:
> 
> 	Make it possible to enable on-demand read mode by adding an
> 	optional parameter to the "bind" command.  On-demand mode will be
> 	turned on when this parameter is "ondemand", i.e. "bind ondemand".
> 	Otherwise cachefiles will work in the original mode.
> 
> Also, I'd add a note something like the following:
> 
> 	This is implemented as a variation on the bind command so that it
> 	can't be turned on accidentally in /etc/cachefilesd.conf when
> 	cachefilesd isn't expecting it.	

Alright, looks much better :)

> 
>> The following patches will implement the data plane of on-demand read
>> mode.
> 
> I would remove this line.  If ondemand mode is not fully implemented in
> cachefiles at this point, I would be tempted to move this to the end of the
> cachefiles subset of the patchset.  That said, I'm not sure it can be made
> to do anything much before that point.


Alright.

> 
>> +#ifdef CONFIG_CACHEFILES_ONDEMAND
>> +static inline void cachefiles_ondemand_open(struct cachefiles_cache *cache)
>> +{
>> +	xa_init_flags(&cache->reqs, XA_FLAGS_ALLOC);
>> +	rwlock_init(&cache->reqs_lock);
>> +}
> 
> Just merge that into the caller.
> 
>> +static inline void cachefiles_ondemand_release(struct cachefiles_cache *cache)
>> +{
>> +	xa_destroy(&cache->reqs);
>> +}
> 
> Ditto.
> 
>> +static inline
>> +bool cachefiles_ondemand_daemon_bind(struct cachefiles_cache *cache, char *args)
>> +{
>> +	if (!strcmp(args, "ondemand")) {
>> +		set_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags);
>> +		return true;
>> +	}
>> +
>> +	return false;
>> +}
>> ...
>> +	if (!cachefiles_ondemand_daemon_bind(cache, args) && *args) {
>> +		pr_err("'bind' command doesn't take an argument\n");
>> +		return -EINVAL;
>> +	}
>> +
> 
> I would merge these together, I think, and say something like "Ondemand
> mode not enabled in kernel" if CONFIG_CACHEFILES_ONDEMAND=n.
> 

The reason why I extract all these logic into small sized function is
that, the **callers** can call cachefiles_ondemand_daemon_bind()
directly without any clause like:

```
#ifdef CONFIG_CACHEFILES_ONDEMAND
	...
#else
	...
```



Another choice is like

```
if (IS_ENABLED(CONFIG_CACHEFILES_ONDEMAND))
	...
else
	...
```


-- 
Thanks,
Jeffle
