Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2109C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 May 2022 09:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbiEYJdV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 May 2022 05:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiEYJdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 05:33:19 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03B08A30C
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 02:33:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VEMuPXj_1653471193;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VEMuPXj_1653471193)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 25 May 2022 17:33:15 +0800
Date:   Wed, 25 May 2022 17:33:13 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] erofs: leave compressed inodes unsupported in fscache
 mode for now
Message-ID: <Yo332UXnrZ+HVQZ7@B-P7TQMD6M-0146.local>
References: <20220525075950.21535-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220525075950.21535-1-jefflexu@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeffle,

On Wed, May 25, 2022 at 03:59:50PM +0800, Jeffle Xu wrote:
> erofs over fscache doesn't support the compressed layout yet. It will
> cause NULL crash if there are compressed inodes contained when working
> in fscache mode.
> 
> So far in the erofs based container image distribution scenarios
> (RAFS v6), the compressed images are downloaded to local and then

... the compressed RAFS v6 images are downloaded and then decompressed
on demand as an uncompressed erofs image.

> decompressed as a erofs image of uncompressed layout. Then the erofs
> image is mounted in fscache mode and serves as the container image. Thus

... in fscache mode for containers to use. IOWs

> the current implementation won't break the container image distribution
> scenarios.

IOWs, currently compressed data is decompressed on the userspace side
instead and uncompressed erofs images will be finally cached.

> 
> The fscache support for the compressed layout is still under
> development. Anyway, to avoid the potential crash, let's leave the

The fscache support for the compressed layout is still under
development and it will be used for runtime decompression feature.
Anyway..

> compressed inodes unsupported in fscache mode until we support it later.
> 
> Fixes: 1442b02b66ad ("erofs: implement fscache-based data read for non-inline layout")

Otherwise looks good to me,

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
