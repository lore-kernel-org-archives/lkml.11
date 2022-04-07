Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97F8C433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Apr 2022 05:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237717AbiDGFU7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Apr 2022 01:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiDGFU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 01:20:56 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6810AAB5C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 22:18:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V9PKtJ2_1649308730;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V9PKtJ2_1649308730)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 07 Apr 2022 13:18:52 +0800
Date:   Thu, 7 Apr 2022 13:18:50 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Yue Hu <huyue2@coolpad.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, zbesathu@gmail.com,
        zhangwen@coolpad.com
Subject: Re: [PATCH] erofs: do not prompt for risk any more when using big
 pcluster
Message-ID: <Yk50Op9SqCF9CVRc@B-P7TQMD6M-0146.local>
References: <20220407050101.12556-1-huyue2@coolpad.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220407050101.12556-1-huyue2@coolpad.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 01:01:23PM +0800, Yue Hu wrote:
> The big pluster feature has been merged for a year, it has been mostly
> stable now.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

Agreed,
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>  fs/erofs/decompressor.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index 3efa686c7644..0f445f7e1df8 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -46,8 +46,6 @@ int z_erofs_load_lz4_config(struct super_block *sb,
>  			erofs_err(sb, "too large lz4 pclusterblks %u",
>  				  sbi->lz4.max_pclusterblks);
>  			return -EINVAL;
> -		} else if (sbi->lz4.max_pclusterblks >= 2) {
> -			erofs_info(sb, "EXPERIMENTAL big pcluster feature in use. Use at your own risk!");
>  		}
>  	} else {
>  		distance = le16_to_cpu(dsb->u1.lz4_max_distance);
> -- 
> 2.17.1
