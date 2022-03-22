Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A18BC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 08:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiCVI3o (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 04:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiCVI3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:29:43 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15875BD3F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:28:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V7v6BSf_1647937689;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V7v6BSf_1647937689)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 22 Mar 2022 16:28:11 +0800
Date:   Tue, 22 Mar 2022 16:28:09 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     xkernel.wang@foxmail.com
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] erofs: fix a potential NULL dereference of alloc_pages()
Message-ID: <YjmImXwknNx4WXDb@B-P7TQMD6M-0146.local>
References: <tencent_010A807048A5F97F0A900866A35C648E2E07@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tencent_010A807048A5F97F0A900866A35C648E2E07@qq.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 04:08:12PM +0800, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> alloc_pages() returns the page on success or NULL if allocation fails,
> while set_page_private() will dereference `newpage`. So it is better to
> catch the memory error in case other errors happen.
> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
>  fs/erofs/zdata.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 11c7a1a..36a5421 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -735,11 +735,15 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>  		struct page *const newpage =
>  				alloc_page(GFP_NOFS | __GFP_NOFAIL);
>  

It's really a nofail allocation, am I missing something?

Thanks,
Gao Xiang

> -		set_page_private(newpage, Z_EROFS_SHORTLIVED_PAGE);
> -		err = z_erofs_attach_page(clt, newpage,
> -					  Z_EROFS_PAGE_TYPE_EXCLUSIVE);
> -		if (!err)
> -			goto retry;
> +		if (!newpage) {
> +			err = -ENOMEM;
> +		} else {
> +			set_page_private(newpage, Z_EROFS_SHORTLIVED_PAGE);
> +			err = z_erofs_attach_page(clt, newpage,
> +						Z_EROFS_PAGE_TYPE_EXCLUSIVE);
> +			if (!err)
> +				goto retry;
> +		}
>  	}
>  
>  	if (err)
> -- 
