Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFA2C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Apr 2022 09:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344364AbiDAJMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Apr 2022 05:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344353AbiDAJMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 05:12:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CB91C405F;
        Fri,  1 Apr 2022 02:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22C3760EFE;
        Fri,  1 Apr 2022 09:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29923C2BBE4;
        Fri,  1 Apr 2022 09:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648804222;
        bh=sZUdxyJpwlCAHGNffYBZjBlpZuN2X4FgRJngFC/Lcps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XVZZO7m+37QiNX9O50oI0w+iC2LF66qs7q8hwxwJ3+hipTUQOQ7ENSeuxTcWkgaFH
         5Rplt9cVyxLJHDdu3p1hlUa0KrN7gBSu4P7gLqYGDX1RRP358uot8o9e/b0v36EQ6D
         uaGGVEPQMQZZBAoCNdyPZDlNbmCp/NgfhB0FR40o=
Date:   Fri, 1 Apr 2022 11:10:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cgel.zte@gmail.com
Cc:     weiyongjun1@huawei.com, colin.king@intel.com, lv.ruyi@zte.com.cn,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] usb: ftdi-elan: Fix undefined behaviour
Message-ID: <YkbBe823hCSNzZ8X@kroah.com>
References: <20220401075747.2407536-1-lv.ruyi@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401075747.2407536-1-lv.ruyi@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 07:57:47AM +0000, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> The use of zero-sized array causes undefined behaviour when it is not
> the last member in a structure. As it happens to be in this case.

What do you mean by "undefined behavior" here?  How is this working now?

> Also, the current code makes use of a language extension to the C90
> standard, but the preferred mechanism to declare variable-length
> types such as this one is a flexible array member, introduced in
> C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };

gcc and clang both support [0] for a very long time so this isn't an
issue.

> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last. Which is beneficial
> to cultivate a high-quality code.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> ---
>  drivers/usb/misc/ftdi-elan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/misc/ftdi-elan.c b/drivers/usb/misc/ftdi-elan.c
> index 6c38c62d29b2..e818d2ed6831 100644
> --- a/drivers/usb/misc/ftdi-elan.c
> +++ b/drivers/usb/misc/ftdi-elan.c
> @@ -171,7 +171,6 @@ struct usb_ftdi {
>  	struct delayed_work command_work;
>  	struct delayed_work respond_work;
>  	struct u132_platform_data platform_data;
> -	struct resource resources[0];
>  	struct platform_device platform_dev;
>  	unsigned char *bulk_in_buffer;
>  	size_t bulk_in_size;
> @@ -185,6 +184,7 @@ struct usb_ftdi {
>  	int expected;
>  	int received;
>  	int ed_found;
> +	struct resource resources[];

How did you test and verify that this change is correct?

thanks,

greg k-h
