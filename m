Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7D0C32772
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Aug 2022 09:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344227AbiHTJW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Aug 2022 05:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244085AbiHTJW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 05:22:26 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7D1B69C7;
        Sat, 20 Aug 2022 02:22:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VMj1MZi_1660987338;
Received: from 192.168.31.65(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VMj1MZi_1660987338)
          by smtp.aliyun-inc.com;
          Sat, 20 Aug 2022 17:22:19 +0800
Message-ID: <da9573d7-cc79-1a75-da52-480c9aac827e@linux.alibaba.com>
Date:   Sat, 20 Aug 2022 17:22:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v3] cachefiles: fix error return code in
 cachefiles_ondemand_copen()
Content-Language: en-US
To:     Sun Ke <sunke32@huawei.com>, dhowells@redhat.com
Cc:     linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20220818125038.2247720-1-sunke32@huawei.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220818125038.2247720-1-sunke32@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/22 8:50 PM, Sun Ke wrote:
> The cache_size field of copen is specified by the user daemon.
> If cache_size < 0, then the OPEN request is expected to fail,
> while copen itself shall succeed. However, returning 0 is indeed
> unexpected when cache_size is an invalid error code.
> 
> Fix this by returning error when cache_size is an invalid error code.
> 
> Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
> Signed-off-by: Sun Ke <sunke32@huawei.com>

LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

> ---
> v3: update the commit log suggested by Jingbo.
> 
>  fs/cachefiles/ondemand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 1fee702d5529..ea8a1e8317d9 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -159,7 +159,7 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>  	/* fail OPEN request if daemon reports an error */
>  	if (size < 0) {
>  		if (!IS_ERR_VALUE(size))
> -			size = -EINVAL;
> +			ret = size = -EINVAL;
>  		req->error = size;
>  		goto out;
>  	}

-- 
Thanks,
Jingbo
