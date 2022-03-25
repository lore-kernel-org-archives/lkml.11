Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE41C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 13:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358158AbiCYNsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 09:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353996AbiCYNsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 09:48:17 -0400
Received: from out199-1.us.a.mail.aliyun.com (out199-1.us.a.mail.aliyun.com [47.90.199.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7177004D;
        Fri, 25 Mar 2022 06:46:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0V8A2H-n_1648215995;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V8A2H-n_1648215995)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 25 Mar 2022 21:46:37 +0800
Date:   Fri, 25 Mar 2022 21:46:35 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        gregkh@linuxfoundation.org, fannaihao@baidu.com,
        tao.peng@linux.alibaba.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, tianzichen@kuaishou.com,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
        eguan@linux.alibaba.com, gerry@linux.alibaba.com,
        torvalds@linux-foundation.org
Subject: Re: [Linux-cachefs] [PATCH v6 13/22] erofs: add anonymous inode
 managing page cache of blob file
Message-ID: <Yj3HuzncvkkwWBvD@B-P7TQMD6M-0146.local>
Mail-Followup-To: Jeffle Xu <jefflexu@linux.alibaba.com>,
        dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        gregkh@linuxfoundation.org, fannaihao@baidu.com,
        tao.peng@linux.alibaba.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, tianzichen@kuaishou.com,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
        eguan@linux.alibaba.com, gerry@linux.alibaba.com,
        torvalds@linux-foundation.org
References: <20220325122223.102958-1-jefflexu@linux.alibaba.com>
 <20220325122223.102958-14-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220325122223.102958-14-jefflexu@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 08:22:14PM +0800, Jeffle Xu wrote:
> Introduce one anonymous inode for managing page cache of corresponding
> blob file. Then erofs could read directly from the address space of the
> anonymous inode when cache hit.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/erofs/fscache.c  | 41 ++++++++++++++++++++++++++++++++++++++++-
>  fs/erofs/internal.h |  7 +++++--
>  2 files changed, 45 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 73235fd43bf6..30383d9adb62 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -7,6 +7,9 @@
>  
>  static struct fscache_volume *volume;
>  
> +static const struct address_space_operations erofs_fscache_blob_aops = {
> +};
> +
>  static int erofs_fscache_init_cookie(struct erofs_fscache *ctx, char *path)
>  {
>  	struct fscache_cookie *cookie;
> @@ -31,6 +34,29 @@ static inline void erofs_fscache_cleanup_cookie(struct erofs_fscache *ctx)
>  	ctx->cookie = NULL;
>  }
>  
> +static int erofs_fscache_get_inode(struct erofs_fscache *ctx,
> +				   struct super_block *sb)

I think it can be folded as well.

> +{
> +	struct inode *const inode = new_inode(sb);
> +
> +	if (!inode)
> +		return -ENOMEM;
> +
> +	set_nlink(inode, 1);
> +	inode->i_size = OFFSET_MAX;
> +	inode->i_mapping->a_ops = &erofs_fscache_blob_aops;
> +	mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
> +
> +	ctx->inode = inode;
> +	return 0;
> +}
> +
> +static inline void erofs_fscache_put_inode(struct erofs_fscache *ctx)

Ditto.

> +{
> +	iput(ctx->inode);
> +	ctx->inode = NULL;
> +}
> +
>  /*
>   * erofs_fscache_get - create an fscache context for blob file
>   * @sb:		superblock
> @@ -38,7 +64,8 @@ static inline void erofs_fscache_cleanup_cookie(struct erofs_fscache *ctx)
>   *
>   * Return: fscache context on success, ERR_PTR() on failure.
>   */
> -struct erofs_fscache *erofs_fscache_get(struct super_block *sb, char *path)
> +struct erofs_fscache *erofs_fscache_get(struct super_block *sb, char *path,
> +					bool need_inode)
>  {
>  	struct erofs_fscache *ctx;
>  	int ret;
> @@ -53,7 +80,18 @@ struct erofs_fscache *erofs_fscache_get(struct super_block *sb, char *path)
>  		goto err;
>  	}
>  
> +	if (need_inode) {
> +		ret = erofs_fscache_get_inode(ctx, sb);
> +		if (ret) {
> +			erofs_err(sb, "failed to get anonymous inode");

				       failed to get fscache inode of [path].

Thanks,
Gao Xiang
