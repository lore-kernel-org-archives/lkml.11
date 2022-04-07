Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F78C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Apr 2022 02:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238556AbiDGCrB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 22:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbiDGCq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 22:46:56 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE02020D535;
        Wed,  6 Apr 2022 19:44:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0V9O8VBd_1649299490;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V9O8VBd_1649299490)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 07 Apr 2022 10:44:52 +0800
Date:   Thu, 7 Apr 2022 10:44:50 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com
Subject: Re: [PATCH v8 08/20] erofs: make erofs_map_blocks() generally
 available
Message-ID: <Yk5QIsUKie+dI8KR@B-P7TQMD6M-0146.local>
Mail-Followup-To: Jeffle Xu <jefflexu@linux.alibaba.com>,
        dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com
References: <20220406075612.60298-1-jefflexu@linux.alibaba.com>
 <20220406075612.60298-9-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220406075612.60298-9-jefflexu@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 03:56:00PM +0800, Jeffle Xu wrote:
> ... so that it can be used in the following introduced fscache mode.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>  fs/erofs/data.c     | 4 ++--
>  fs/erofs/internal.h | 2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 780db1e5f4b7..bc22642358ec 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -110,8 +110,8 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
>  	return 0;
>  }
>  
> -static int erofs_map_blocks(struct inode *inode,
> -			    struct erofs_map_blocks *map, int flags)
> +int erofs_map_blocks(struct inode *inode,
> +		     struct erofs_map_blocks *map, int flags)
>  {
>  	struct super_block *sb = inode->i_sb;
>  	struct erofs_inode *vi = EROFS_I(inode);
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 5298c4ee277d..fe9564e5091e 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -486,6 +486,8 @@ void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
>  int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *dev);
>  int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  		 u64 start, u64 len);
> +int erofs_map_blocks(struct inode *inode,
> +		     struct erofs_map_blocks *map, int flags);
>  
>  /* inode.c */
>  static inline unsigned long erofs_inode_hash(erofs_nid_t nid)
> -- 
> 2.27.0
