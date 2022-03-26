Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBFEC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Mar 2022 04:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiCZEtO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Mar 2022 00:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiCZEtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 00:49:10 -0400
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E592F14DFF4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 21:47:33 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 4F58115F93A;
        Sat, 26 Mar 2022 13:47:33 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 22Q4lWra054842
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 26 Mar 2022 13:47:33 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 22Q4lW5s209086
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 26 Mar 2022 13:47:32 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 22Q4lVqF209085;
        Sat, 26 Mar 2022 13:47:31 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>, fengyubo <fengyubo3@huawei.com>
Subject: Re: [PATCH -next] fatfs: remove redundant judgment
References: <1648265418-76563-1-git-send-email-fengyubo3@huawei.com>
Date:   Sat, 26 Mar 2022 13:47:31 +0900
In-Reply-To: <1648265418-76563-1-git-send-email-fengyubo3@huawei.com>
        (fengyubo's message of "Sat, 26 Mar 2022 11:30:18 +0800")
Message-ID: <878rsxpbfg.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fengyubo <fengyubo3@huawei.com> writes:

> From: Yubo Feng <fengyubo3@huawei.com>
>
> iput() has already judged the incoming parameter, so there is no need to
> repeat outside.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yubo Feng <fengyubo3@huawei.com>

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Thanks.

> ---
>  fs/fat/inode.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/fs/fat/inode.c b/fs/fat/inode.c
> index a6f1c6d426d1..da8619148590 100644
> --- a/fs/fat/inode.c
> +++ b/fs/fat/inode.c
> @@ -1888,10 +1888,8 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
>  		fat_msg(sb, KERN_INFO, "Can't find a valid FAT filesystem");
>  
>  out_fail:
> -	if (fsinfo_inode)
> -		iput(fsinfo_inode);
> -	if (fat_inode)
> -		iput(fat_inode);
> +	iput(fsinfo_inode);
> +	iput(fat_inode);
>  	unload_nls(sbi->nls_io);
>  	unload_nls(sbi->nls_disk);
>  	fat_reset_iocharset(&sbi->options);

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
