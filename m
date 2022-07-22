Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B89C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jul 2022 02:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbiGVCke (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jul 2022 22:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiGVCkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 22:40:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256E3167D4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 19:40:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC677B8270F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:40:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2A4C3411E;
        Fri, 22 Jul 2022 02:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658457628;
        bh=Wn1u6B/xfUl/2b0bhdy5Fr/2eJgUIwE/bEPRZRruJoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LZFfLUsy9qZqbHKi6XrAE/EpBL1lnqcs51szMvueTGmi7tclnWxjJvs+n6hWye6uu
         jjtGXxNz6n5tyC/JUDb6RF1AtlDDS6YL+7jleQpRCX8T9/hm8Kk28n1uvK405+ePQx
         aIjBeuBVV6SDM6Lq9vthMPguwOcbnseZGdEXDrMqrLruKigtXz8VlChJVxV2ZLLLLw
         TdfSsf7dGk1rM953YmrWAIF7BQ8jJL9SnmNu8Mc7cc7LTm4TIGGPz8FnFGsY0E9kO5
         eTY4z4NjnchHAxoDfEZfKTUhomu6ZjrO7ATplCYMMI7p21/umhy4qv3Ud6Go0JVkm+
         LfacgfYjZn7KA==
Date:   Thu, 21 Jul 2022 19:40:26 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     qixiaoyu1 <qxy65535@gmail.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, qixiaoyu1 <qixiaoyu1@xiaomi.com>
Subject: Re: [PATCH] f2fs: don't bother wait_ms by foreground gc
Message-ID: <YtoOGu/wyqKBJd1v@google.com>
References: <20220718032840.9653-1-qixiaoyu1@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718032840.9653-1-qixiaoyu1@xiaomi.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/18, qixiaoyu1 wrote:
> f2fs_gc returns -EINVAL via f2fs_balance_fs when there is enough free
> secs after write checkpoint, but with gc_merge enabled, it will cause
> the sleep time of gc thread to be set to no_gc_sleep_time even if there
> are many dirty segments can be selected.
> 
> Signed-off-by: qixiaoyu1 <qixiaoyu1@xiaomi.com>
> ---
>  fs/f2fs/gc.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index d5fb426e0747..cb8ca992d986 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -150,8 +150,12 @@ static int gc_thread_func(void *data)
>  		gc_control.nr_free_secs = foreground ? 1 : 0;
>  
>  		/* if return value is not zero, no victim was selected */
> -		if (f2fs_gc(sbi, &gc_control))
> -			wait_ms = gc_th->no_gc_sleep_time;
> +		if (f2fs_gc(sbi, &gc_control)) {
> +			/* don't bother wait_ms by foreground gc */
> +			if (!foreground) {
> +				wait_ms = gc_th->no_gc_sleep_time;
> +			}

I applied without {} to match the coding style.

Thanks,

> +		}
>  
>  		if (foreground)
>  			wake_up_all(&gc_th->fggc_wq);
> -- 
> 2.36.1
