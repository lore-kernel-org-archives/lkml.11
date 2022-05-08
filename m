Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F7CC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 May 2022 14:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbiEHOpM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 May 2022 10:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiEHOpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 10:45:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1604E0E9
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 07:41:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81FC1611BC
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 14:41:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9C7C385A4;
        Sun,  8 May 2022 14:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652020877;
        bh=t8HXZdI0ta/IUuWc1jQys+uGfSMD6nMCvKG+hO+WBPM=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=kJ46Gd53tCLywcEn4kCqDiiuLMTMC6Uoaq1aF9x+umUYyVUCxl5X7uG+g/IMEtJw+
         /VupFsaSTJI5s1SgnEkEl1eFERtDEeKWWitjL0+bsM6Gd2nmxTNrZ84RAtFhAc2iJS
         EmTxaA9fP40nE7NzB1vDtyZOkuwAThuI032kF3RtLT9ctTkXfdI58N/yZOh/C+FUi/
         CBXh2WdM7I4RXHBsWXhlaS3tIlx76w7+fAfshQK45xbBO2lf5zMKfom2W7kWvUbwuE
         JP5EQZbWSMLmgYrVeG/TeCdyTMp3VN8Zd8PVji01vxsDjg5yGWB0WkIEpKvysgRG+I
         2qn0dKGiBem7g==
Message-ID: <eb8f1316-11df-ab02-1834-542ca193c17c@kernel.org>
Date:   Sun, 8 May 2022 22:41:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [f2fs-dev] [PATCH 3/5] f2fs: keep wait_ms if EAGAIN happens
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220506232032.1264078-1-jaegeuk@kernel.org>
 <20220506232032.1264078-3-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220506232032.1264078-3-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/7 7:20, Jaegeuk Kim wrote:
> In f2fs_gc thread, let's keep wait_ms when sec_freed was zero.

sec_freed won't increase for background GC due to below statement:

		if (gc_type == FG_GC &&
				get_valid_blocks(sbi, segno, false) == 0)
			seg_freed++;

It may cause gc thread migrates lots of segments in each round?

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/gc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index aeffcc1d5c02..ec3f6f876e76 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -37,7 +37,8 @@ static int gc_thread_func(void *data)
>   	unsigned int wait_ms;
>   	struct f2fs_gc_control gc_control = {
>   		.victim_segno = NULL_SEGNO,
> -		.should_migrate_blocks = false };
> +		.should_migrate_blocks = false,
> +		.err_gc_skipped = false };
>   
>   	wait_ms = gc_th->min_sleep_time;
>   
> @@ -146,7 +147,6 @@ static int gc_thread_func(void *data)
>   
>   		gc_control.init_gc_type = sync_mode ? FG_GC : BG_GC;
>   		gc_control.no_bg_gc = foreground;
> -		gc_control.err_gc_skipped = sync_mode;
>   
>   		/* if return value is not zero, no victim was selected */
>   		if (f2fs_gc(sbi, &gc_control))
