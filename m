Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A50C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Mar 2022 06:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiCQG0L (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Mar 2022 02:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiCQG0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 02:26:00 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243E6B7C78;
        Wed, 16 Mar 2022 23:18:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0V7QBtbp_1647497928;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V7QBtbp_1647497928)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Mar 2022 14:18:51 +0800
Date:   Thu, 17 Mar 2022 14:18:48 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        gregkh@linuxfoundation.org, tao.peng@linux.alibaba.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
        eguan@linux.alibaba.com, gerry@linux.alibaba.com,
        torvalds@linux-foundation.org
Subject: Re: [Linux-cachefs] [PATCH v5 17/22] erofs: implement fscache-based
 data read for non-inline layout
Message-ID: <YjLSyLGDtSrwJLHN@B-P7TQMD6M-0146.local>
Mail-Followup-To: Jeffle Xu <jefflexu@linux.alibaba.com>,
        dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        gregkh@linuxfoundation.org, tao.peng@linux.alibaba.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
        eguan@linux.alibaba.com, gerry@linux.alibaba.com,
        torvalds@linux-foundation.org
References: <20220316131723.111553-1-jefflexu@linux.alibaba.com>
 <20220316131723.111553-18-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220316131723.111553-18-jefflexu@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 09:17:18PM +0800, Jeffle Xu wrote:
> This patch implements the data plane of reading data from bootstrap blob
> file over fscache for non-inline layout.
> 
> Be noted that compressed layout is not supported yet.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/erofs/fscache.c  | 94 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/erofs/inode.c    |  6 ++-
>  fs/erofs/internal.h |  1 +
>  3 files changed, 100 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 654414aa87ad..df56562f33c4 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -4,6 +4,12 @@
>   */
>  #include "internal.h"
>  
> +struct erofs_fscache_map {
> +	struct erofs_fscache_context *m_ctx;
> +	erofs_off_t m_pa, m_la, o_la;
> +	u64 m_llen;

Can we directly use "struct erofs_map_blocks map"?
So "erofs_fscache_get_map" can be avoided then.

Thanks,
Gao Xiang
