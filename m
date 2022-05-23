Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3A0C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 May 2022 09:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbiEWJoI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 May 2022 05:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbiEWJny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:43:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC229313A0;
        Mon, 23 May 2022 02:43:20 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7A80A21A0C;
        Mon, 23 May 2022 09:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653298999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3BKZ8QhniRBwgmI0twD/d6abArIatMrZ0L88M4PIxAY=;
        b=pYnOFOL4fLyk2ZVqao3ZZgJg88HHtAU5Qv0Y/xThaz6asCxFZxHy88Akh/JHtPd3i5DsD2
        moB+iZm1ETqtKub8tv8JLxSAZorXFOC3SCealsTLwBChUNu6DIt5vDrLGJG4vy4KCldkSz
        NQ7bL5+4xzZiGgfj/dOsRbgzqgZKCv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653298999;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3BKZ8QhniRBwgmI0twD/d6abArIatMrZ0L88M4PIxAY=;
        b=sYeUBH8Vq+NuReDcF+mK1TrSYs0jEqyG8X7UR4zhkDhWHyDOXTNOtwWKnMdeFbXj0vgRcs
        HzIQikTi1Cr78NAA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 58B142C141;
        Mon, 23 May 2022 09:43:19 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1094AA0632; Mon, 23 May 2022 11:43:18 +0200 (CEST)
Date:   Mon, 23 May 2022 11:43:18 +0200
From:   Jan Kara <jack@suse.cz>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Jan Kara <jack@suse.cz>, kernel@openvz.org,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] fanotify: fix incorrect fmode_t casts
Message-ID: <20220523094318.kyuuvbdl5mjuddgu@quack3.lan>
References: <9adfd6ac-1b89-791e-796b-49ada3293985@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9adfd6ac-1b89-791e-796b-49ada3293985@openvz.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 22-05-22 15:08:02, Vasily Averin wrote:
> Fixes sparce warnings:
> fs/notify/fanotify/fanotify_user.c:267:63: sparse:
>  warning: restricted fmode_t degrades to integer
> fs/notify/fanotify/fanotify_user.c:1351:28: sparse:
>  warning: restricted fmode_t degrades to integer
> 
> FMODE_NONTIFY have bitwise fmode_t type and requires __force attribute
> for any casts.
> 
> Signed-off-by: Vasily Averin <vvs@openvz.org>
> Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>

Thanks. I've merged the patch to my tree.

								Honza

> ---
> v3: split, according to Christoph Hellwig recommendation
> ---
>  fs/notify/fanotify/fanotify_user.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index a792e21c5309..16d8fc84713a 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -264,7 +264,7 @@ static int create_fd(struct fsnotify_group *group, struct path *path,
>  	 * originally opened O_WRONLY.
>  	 */
>  	new_file = dentry_open(path,
> -			       group->fanotify_data.f_flags | FMODE_NONOTIFY,
> +			       group->fanotify_data.f_flags | __FMODE_NONOTIFY,
>  			       current_cred());
>  	if (IS_ERR(new_file)) {
>  		/*
> @@ -1348,7 +1348,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>  	    (!(fid_mode & FAN_REPORT_NAME) || !(fid_mode & FAN_REPORT_FID)))
>  		return -EINVAL;
>  
> -	f_flags = O_RDWR | FMODE_NONOTIFY;
> +	f_flags = O_RDWR | __FMODE_NONOTIFY;
>  	if (flags & FAN_CLOEXEC)
>  		f_flags |= O_CLOEXEC;
>  	if (flags & FAN_NONBLOCK)
> -- 
> 2.36.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
