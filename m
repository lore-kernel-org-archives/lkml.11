Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE824C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 May 2022 15:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237924AbiEWP0T (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 May 2022 11:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237876AbiEWP0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:26:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D089532FF;
        Mon, 23 May 2022 08:26:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF605B81014;
        Mon, 23 May 2022 15:26:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC89C385A9;
        Mon, 23 May 2022 15:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653319572;
        bh=Tn18BFV/rU6iBwpcbPUyBxptSd3tEtMVOtluoy49Yi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xSpPWAZsmg72NIc2h88A/wShFKIanQjFYWsbA6cspbAR46ED9hMchHbtVsuR/Bvib
         nZwp+S/JSnFUeONrEVJ5Dl2JVlIaDLq8XywanIcRMvGimAQvUl9Mc/El00hQRoWUQg
         laC0SUpyAVSveesmiS8xPBPS23AH0vh5etZh7tP4=
Date:   Mon, 23 May 2022 17:26:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Denis Efremov (Oracle)" <efremov@linux.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        dan.carpenter@oracle.com, straube.linux@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, stable <stable@vger.kernel.org>
Subject: Re: [PATCH v5.10] staging: rtl8723bs: prevent ->Ssid overflow in
 rtw_wx_set_scan()
Message-ID: <YounkTGwmcQns3vy@kroah.com>
References: <YoZk3YLEDYKGG5xe@kroah.com>
 <20220520035730.5533-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520035730.5533-1-efremov@linux.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 07:57:30AM +0400, Denis Efremov (Oracle) wrote:
> This code has a check to prevent read overflow but it needs another
> check to prevent writing beyond the end of the ->Ssid[] array.
> 
> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> Cc: stable <stable@vger.kernel.org>
> Signed-off-by: Denis Efremov (Oracle) <efremov@linux.com>
> ---
>  drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

And only 5.10 needs this?  What about all other kernel branches?

thanks,

greg k-h
