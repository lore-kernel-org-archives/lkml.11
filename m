Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF1CC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 20:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbiBYUdL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 15:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiBYUdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:33:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2073BA7B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 12:32:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BA366194B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 20:32:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF56C340E7;
        Fri, 25 Feb 2022 20:32:33 +0000 (UTC)
Date:   Fri, 25 Feb 2022 15:32:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH v2] tracefs: Set the group ownership in apply_options()
 not parse_options()
Message-ID: <20220225153232.26e0b335@gandalf.local.home>
In-Reply-To: <20220225152123.6c19adec@gandalf.local.home>
References: <20220225152123.6c19adec@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Feb 2022 15:21:23 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Al Viro brought it to my attention that the dentries may not be filled
> when the parse_options() is called, causing the call to set_gid() to
> possibly crash. It should only be called if parse_options() succeeds
> totally anyway.
> 
> He suggested the logical place to do the update is in apply_options().
> 
> Link: https://lore.kernel.org/all/20220225165219.737025658@goodmis.org/
> 
> Cc: stable@vger.kernel.org
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> Fixes: 48b27b6b5191 ("tracefs: Set all files to the same group ownership as the mount option")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  fs/tracefs/inode.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index bafc02bf8220..3638d330ff5a 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -264,7 +264,6 @@ static int tracefs_parse_options(char *data, struct tracefs_mount_opts *opts)
>  			if (!gid_valid(gid))
>  				return -EINVAL;
>  			opts->gid = gid;
> -			set_gid(tracefs_mount->mnt_root, gid);
>  			break;
>  		case Opt_mode:
>  			if (match_octal(&args[0], &option))
> @@ -293,6 +292,9 @@ static int tracefs_apply_options(struct super_block *sb)
>  	inode->i_uid = opts->uid;
>  	inode->i_gid = opts->gid;
>  
> +	if (tracefs_mount && tracefs_mount->mnt_root)
> +		set_gid(tracefs_mount->mnt_root, opts->gid);

Bah, I forgot the '-a' in 'git commit -a --amend'

Ignore this :-/

-- Steve

> +
>  	return 0;
>  }
>  

