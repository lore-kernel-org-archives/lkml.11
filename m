Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1C7C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 06:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbiF0GPk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 02:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiF0GPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 02:15:38 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D522AE8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 23:15:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VHTNMzH_1656310531;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VHTNMzH_1656310531)
          by smtp.aliyun-inc.com;
          Mon, 27 Jun 2022 14:15:33 +0800
Date:   Mon, 27 Jun 2022 14:15:31 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Yue Hu <zbestahu@gmail.com>, Yuwen Chen <chenyuwen1@meizu.com>
Cc:     xiang@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] erofs: Wake up all waiters after z_erofs_lzma_head ready.
Message-ID: <YrlLA5kDpprL0klA@B-P7TQMD6M-0146.local>
References: <20220625145000.2720-1-chenyuwen1@meizu.com>
 <20220627135754.00000999.zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220627135754.00000999.zbestahu@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 01:57:54PM +0800, Yue Hu wrote:
> On Sat, 25 Jun 2022 22:50:00 +0800
> Yuwen Chen <chenyuwen1@meizu.com> wrote:
> 

...

> > 
> > Signed-off-by: Yuwen Chen <chenyuwen1@meizu.com>
> > ---
> >  fs/erofs/decompressor_lzma.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
> > index 05a3063cf2bc..5e59b3f523eb 100644
> > --- a/fs/erofs/decompressor_lzma.c
> > +++ b/fs/erofs/decompressor_lzma.c
> > @@ -143,6 +143,7 @@ int z_erofs_load_lzma_config(struct super_block *sb,
> >  	DBG_BUGON(z_erofs_lzma_head);
> >  	z_erofs_lzma_head = head;
> >  	spin_unlock(&z_erofs_lzma_lock);
> > +	wake_up_all(&z_erofs_lzma_wq);
> >  
> >  	z_erofs_lzma_max_dictsize = dict_size;
> >  	mutex_unlock(&lzma_resize_mutex);
> 
> Please do not end the summary line(title) with a period.

Okay, that is a good point, also it'd be better to de-capitalize the 'W'
in "Wake" since they are common practices for kernel patches.

If it's convenient to you to send another version, please go with my
r-v-b tag.

Thanks,
Gao Xiang
