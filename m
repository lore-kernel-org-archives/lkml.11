Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947FAC25B0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 12:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbiHOMOy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 08:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiHOMOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 08:14:45 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20322558A;
        Mon, 15 Aug 2022 05:14:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VMJKe7S_1660565679;
Received: from 30.227.73.152(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VMJKe7S_1660565679)
          by smtp.aliyun-inc.com;
          Mon, 15 Aug 2022 20:14:40 +0800
Message-ID: <9dc534eb-e083-f2cd-404e-9fb56230def2@linux.alibaba.com>
Date:   Mon, 15 Aug 2022 20:14:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH] erofs: fix error return code in
 erofs_fscache_meta_read_folio and erofs_fscache_read_folio
Content-Language: en-US
To:     Sun Ke <sunke32@huawei.com>, xiang@kernel.org, chao@kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, yinxin.x@bytedance.com
References: <20220815034829.3940803-1-sunke32@huawei.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220815034829.3940803-1-sunke32@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/15/22 11:48 AM, Sun Ke via Linux-erofs wrote:
> If erofs_fscache_alloc_request fail and then goto out, it will return 0.
> it should return a negative error code instead of 0.
> 
> Fixes: d435d53228dd ("erofs: change to use asynchronous io for fscache readpage/readahead")
> Signed-off-by: Sun Ke <sunke32@huawei.com>

LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

> ---
>  fs/erofs/fscache.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 8e01d89c3319..b5fd9d71e67f 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -222,8 +222,10 @@ static int erofs_fscache_meta_read_folio(struct file *data, struct folio *folio)
>  
>  	rreq = erofs_fscache_alloc_request(folio_mapping(folio),
>  				folio_pos(folio), folio_size(folio));
> -	if (IS_ERR(rreq))
> +	if (IS_ERR(rreq)) {
> +		ret = PTR_ERR(rreq);
>  		goto out;
> +	}
>  
>  	return erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
>  				rreq, mdev.m_pa);
> @@ -301,8 +303,10 @@ static int erofs_fscache_read_folio(struct file *file, struct folio *folio)
>  
>  	rreq = erofs_fscache_alloc_request(folio_mapping(folio),
>  				folio_pos(folio), folio_size(folio));
> -	if (IS_ERR(rreq))
> +	if (IS_ERR(rreq)) {
> +		ret = PTR_ERR(rreq);
>  		goto out_unlock;
> +	}
>  
>  	pstart = mdev.m_pa + (pos - map.m_la);
>  	return erofs_fscache_read_folios_async(mdev.m_fscache->cookie,

-- 
Thanks,
Jingbo
