Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28511C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jul 2022 01:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiGLBgV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jul 2022 21:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiGLBgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 21:36:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D542B1A5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 18:36:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D247C61653
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8663C3411C;
        Tue, 12 Jul 2022 01:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657589777;
        bh=abHCq8B2o5LmiSh6NVX2ViHoKDAMvedKljs2uYyePag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qaDgs4VDWLWaO2CeuIz4TzgPD6Da8R8RL1qnYqUcmYK3NFlvaiUgw7aD83/CeAebW
         ZhQUavLZzC4w8UC7VmZ/trapbEmsdEc0vQoOPLnKPWdOPSN6LJ9R5vsnUIViIoItED
         uv3lSDL8gEv7d9eAaz2wbZfToTVVkfc1svdtnr5DlQa2KdRf4omCDl4OMMAfkhsIm+
         QKBlbhGwxpLj/+b9hoMqVm4VdTXgwoqXWC8VHI8zh02WYOBTp7tsskeuxuJR50ISP4
         ZFE1A3eTxBhhD+q6gYa1zHM03J+tD7SS0Px2M3DUMs82iTdDPwOyIuSVw4hs7C6Amf
         M7A3i/8ZvkUig==
Date:   Mon, 11 Jul 2022 18:36:15 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Liu <chaoliu719@gmail.com>
Cc:     Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>,
        Wayne Zhang <zhangwen@coolpad.com>,
        Chao Liu <liuchao@coolpad.com>
Subject: Re: [PATCH v2] f2fs: allow compression of files without blocks
Message-ID: <YszQD8Pk3YTvPgpn@google.com>
References: <20220707090924.4183376-1-chaoliu719@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707090924.4183376-1-chaoliu719@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07, Chao Liu wrote:
> From: Chao Liu <liuchao@coolpad.com>
> 
> Files created by truncate(1) have a size but no blocks, so
> they can be allowed to enable compression.
> 
> Signed-off-by: Chao Liu <liuchao@coolpad.com>
> ---
> v2:
>  - update commit message: truncate -> truncate(1)
> 
>  fs/f2fs/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 0f29af7876a6..f7a82858486a 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1879,7 +1879,7 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>  		if (iflags & F2FS_COMPR_FL) {
>  			if (!f2fs_may_compress(inode))
>  				return -EINVAL;
> -			if (S_ISREG(inode->i_mode) && inode->i_size)
> +			if (S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))

What about inline_data case?

>  				return -EINVAL;
> 
>  			set_compress_context(inode);
> --
> 2.36.1
