Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92BEC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jun 2022 02:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349141AbiFFCg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jun 2022 22:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbiFFCgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 22:36:25 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA64A30542
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 19:36:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VFQ-rv7_1654482979;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VFQ-rv7_1654482979)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 06 Jun 2022 10:36:21 +0800
Date:   Mon, 6 Jun 2022 10:36:19 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH] MAINTAINERS: erofs: add myself as reviewer
Message-ID: <Yp1oIye4FM+uU0a+@B-P7TQMD6M-0146.local>
References: <20220606021103.89211-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220606021103.89211-1-jefflexu@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 10:11:03AM +0800, Jeffle Xu wrote:
> Glad to contribute the fscache mode to erofs. Sincerely I recommend
> myself as the reviewer to maintain these codes.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Thanks for taking time on EROFS and looking after this.
Acked-by: Gao Xiang <xiang@kernel.org>

Thanks,
Gao Xiang

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1309e1496c23..6cd8b3631cc0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7388,6 +7388,7 @@ EROFS FILE SYSTEM
>  M:	Gao Xiang <xiang@kernel.org>
>  M:	Chao Yu <chao@kernel.org>
>  R:	Yue Hu <huyue2@coolpad.com>
> +R:	Jeffle Xu <jefflexu@linux.alibaba.com>
>  L:	linux-erofs@lists.ozlabs.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
> -- 
> 2.27.0
