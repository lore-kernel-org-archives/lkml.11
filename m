Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B473DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Apr 2022 13:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344007AbiDONT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Apr 2022 09:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiDONTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 09:19:55 -0400
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C48FA94D8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 06:17:26 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 5FFBC15F939;
        Fri, 15 Apr 2022 22:17:25 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 23FDHMNc063300
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 15 Apr 2022 22:17:23 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 23FDHMIm130305
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 15 Apr 2022 22:17:22 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 23FDHL8s130304;
        Fri, 15 Apr 2022 22:17:21 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Chung-Chiang Cheng <cccheng@synology.com>
Cc:     linux-kernel@vger.kernel.org, kernel@cccheng.net,
        shepjeng@gmail.com
Subject: Re: [PATCH v3 3/3] fat: report creation time in statx
References: <20220415094518.380543-1-cccheng@synology.com>
        <20220415094518.380543-3-cccheng@synology.com>
Date:   Fri, 15 Apr 2022 22:17:21 +0900
In-Reply-To: <20220415094518.380543-3-cccheng@synology.com> (Chung-Chiang
        Cheng's message of "Fri, 15 Apr 2022 17:45:18 +0800")
Message-ID: <87h76utrj2.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chung-Chiang Cheng <cccheng@synology.com> writes:

> @@ -568,10 +568,14 @@ int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
>  
>  	fat_time_fat2unix(sbi, &inode->i_mtime, de->time, de->date, 0);
>  	inode->i_ctime = inode->i_mtime;
> -	if (sbi->options.isvfat)
> +	if (sbi->options.isvfat) {
>  		fat_time_fat2unix(sbi, &inode->i_atime, 0, de->adate, 0);
> -	else
> +		fat_time_fat2unix(sbi, &MSDOS_I(inode)->i_crtime, de->ctime,
> +				  de->cdate, de->ctime_cs);
> +	} else {
>  		fat_truncate_atime(sbi, &inode->i_mtime, &inode->i_atime);
> +		fat_truncate_crtime(sbi, &inode->i_mtime, &MSDOS_I(inode)->i_crtime);
> +	}

Probably, nothing worth to update i_crtime here, right?

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
