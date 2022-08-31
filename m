Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E967ECAAD3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Aug 2022 07:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiHaHAc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Aug 2022 03:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiHaHA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:00:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEA828725
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 00:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 716E4617FB
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 07:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F861C433C1;
        Wed, 31 Aug 2022 07:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661929223;
        bh=78HKjytzKviYYQvx6tvSkKA3/i9KCigpSGo5avS0yyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GCfNJ6H+54XPvWJokd7vmkN9fcj0lA+nDI2zBXOM8JhVX8IqOFt4CW4ZgDVcgoDCw
         dfJ8mDsbSXYBRwLkmnbmyZTIjJR/gJEGjv2nWguU009ijKvypJPVs5yewQnXd7J21S
         TZqPueqDeSqmH/z7akURD8G/l7CTy9eWa8MnPC+s=
Date:   Wed, 31 Aug 2022 09:00:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     keescook@chromium.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lkdtm: Add checks after calling kmalloc and vmalloc
Message-ID: <Yw8HBKceRuLlZa0d@kroah.com>
References: <20220831065355.2125181-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831065355.2125181-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 02:53:55PM +0800, Jiasheng Jiang wrote:
> As the potential failure of the memory allocation,
> it should be better to check the return value after
> calling kmalloc and vmalloc and skip the execute_location
> if fails.
> 
> Fixes: cc33c537c12f ("lkdtm: add "EXEC_*" triggers")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/misc/lkdtm/perms.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
> index b93404d65650..9ba927d74973 100644
> --- a/drivers/misc/lkdtm/perms.c
> +++ b/drivers/misc/lkdtm/perms.c
> @@ -180,14 +180,16 @@ static void lkdtm_EXEC_STACK(void)
>  static void lkdtm_EXEC_KMALLOC(void)
>  {
>  	u32 *kmalloc_area = kmalloc(EXEC_SIZE, GFP_KERNEL);
> -	execute_location(kmalloc_area, CODE_WRITE);
> +	if (kmalloc_area)

How will this ever fail?  Have you seen that happen?

> +		execute_location(kmalloc_area, CODE_WRITE);
>  	kfree(kmalloc_area);
>  }
>  
>  static void lkdtm_EXEC_VMALLOC(void)
>  {
>  	u32 *vmalloc_area = vmalloc(EXEC_SIZE);
> -	execute_location(vmalloc_area, CODE_WRITE);
> +	if (vmalloc_area)

Same here, if the system really can not allocate 64 bytes, much worse
things will have happened already.

thanks,

greg k-h
