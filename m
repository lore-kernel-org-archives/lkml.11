Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554D3C00140
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Aug 2022 10:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244139AbiHRKr2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Aug 2022 06:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbiHRKrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 06:47:24 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFD7816BD;
        Thu, 18 Aug 2022 03:47:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VMabRlS_1660819636;
Received: from 30.227.66.106(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VMabRlS_1660819636)
          by smtp.aliyun-inc.com;
          Thu, 18 Aug 2022 18:47:17 +0800
Message-ID: <0cc3f6d6-ac89-05f6-23f3-68446a32d8b2@linux.alibaba.com>
Date:   Thu, 18 Aug 2022 18:47:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH] cachefiles: fix error return code in
 cachefiles_ondemand_copen()
Content-Language: en-US
To:     Sun Ke <sunke32@huawei.com>, dhowells@redhat.com
Cc:     linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20220818094939.1548183-1-sunke32@huawei.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220818094939.1548183-1-sunke32@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/22 5:49 PM, Sun Ke wrote:
> If size < 0; open request will fail, but cachefiles_ondemand_copen return 0.

Hi, this is a deliberate design. The cache_size field of copen is
specified by the user daemon. If cache_size < 0, then the OPEN request
is expected to fail, while copen itself shall succeed.

> Fix to return a negative error code.
> 
> Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---
>  fs/cachefiles/ondemand.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 1fee702d5529..a31d3ff0ce5f 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -161,6 +161,7 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>  		if (!IS_ERR_VALUE(size))
>  			size = -EINVAL;

However, it is indeed unexpected when cache_size is an invalid error
code. How about:

		if (!IS_ERR_VALUE(size))
-			size= -EINVAL;
+			ret = size = -EINVAL;
		req->error = size;
		goto out;
	}

>  		req->error = size;
> +		ret = -EINVAL;
>  		goto out;
>  	}
>  

-- 
Thanks,
Jingbo
