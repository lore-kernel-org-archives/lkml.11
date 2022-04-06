Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352A7C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 10:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357877AbiDFKOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 06:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343518AbiDFKNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 06:13:40 -0400
Received: from out199-17.us.a.mail.aliyun.com (out199-17.us.a.mail.aliyun.com [47.90.199.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912171CFF92
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 19:47:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V9JnNKo_1649213237;
Received: from 30.225.24.86(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V9JnNKo_1649213237)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 06 Apr 2022 10:47:18 +0800
Message-ID: <74e81f65-171c-804a-a8ca-fa5452c5ad77@linux.alibaba.com>
Date:   Wed, 6 Apr 2022 10:47:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [Linux-cachefs] [PATCH] fscache: Use wrapper
 fscache_set_cache_state() directly when relinquishing
Content-Language: en-US
To:     Yue Hu <huyue2@coolpad.com>, dhowells@redhat.com,
        linux-cachefs@redhat.com
Cc:     zhangwen@coolpad.com, linux-kernel@vger.kernel.org,
        zbestahu@163.com, zbestahu@gmail.com
References: <20220401063643.7340-1-huyue2@coolpad.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220401063643.7340-1-huyue2@coolpad.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/1/22 2:37 PM, Yue Hu wrote:
> We already have the wrapper function to set cache state.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> ---
>  fs/fscache/cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fscache/cache.c b/fs/fscache/cache.c
> index 2749933852a9..d645f8b302a2 100644
> --- a/fs/fscache/cache.c
> +++ b/fs/fscache/cache.c
> @@ -214,7 +214,7 @@ void fscache_relinquish_cache(struct fscache_cache *cache)
>  
>  	cache->ops = NULL;
>  	cache->cache_priv = NULL;
> -	smp_store_release(&cache->state, FSCACHE_CACHE_IS_NOT_PRESENT);
> +	fscache_set_cache_state(cache, FSCACHE_CACHE_IS_NOT_PRESENT);
>  	fscache_put_cache(cache, where);
>  }
>  EXPORT_SYMBOL(fscache_relinquish_cache);

Looks good to me.
Reviewed-by: Jeffle Xu <jefflexu@linux.alibaba.com>

-- 
Thanks,
Jeffle
