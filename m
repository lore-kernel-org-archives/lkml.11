Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B33C28B2B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Aug 2022 11:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244357AbiHRLOf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Aug 2022 07:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244344AbiHRLOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 07:14:30 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5CE422E0;
        Thu, 18 Aug 2022 04:14:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VMaUvrM_1660821265;
Received: from 30.227.66.106(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VMaUvrM_1660821265)
          by smtp.aliyun-inc.com;
          Thu, 18 Aug 2022 19:14:26 +0800
Message-ID: <e4e18421-7820-f1e3-6762-5959c2bd7ea4@linux.alibaba.com>
Date:   Thu, 18 Aug 2022 19:14:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [v2] cachefiles: fix error return code in
 cachefiles_ondemand_copen()
Content-Language: en-US
To:     Sun Ke <sunke32@huawei.com>, dhowells@redhat.com
Cc:     linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20220818111935.1683062-1-sunke32@huawei.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220818111935.1683062-1-sunke32@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/22 7:19 PM, Sun Ke wrote:
> If size < 0; open request will fail, but cachefiles_ondemand_copen return 0.
> Fix to return a negative error code.

Could you please also update the commit log?

Otherwise LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>


BTW, also cc linux-fsdevel@vger.kernel.org

> 
> Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---
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
