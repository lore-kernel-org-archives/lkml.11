Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DF5C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jul 2022 07:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240149AbiGTHq6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jul 2022 03:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240212AbiGTHqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 03:46:37 -0400
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4DE3F301
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 00:46:33 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id E4PdoAiFbnm5hE4PdoE8PB; Wed, 20 Jul 2022 09:46:31 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 20 Jul 2022 09:46:31 +0200
X-ME-IP: 90.11.190.129
Message-ID: <604f2d3f-659c-3312-d69f-c133aec275ca@wanadoo.fr>
Date:   Wed, 20 Jul 2022 09:46:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] usb: trancevibrator: simplify tv_probe
Content-Language: en-US
To:     dzm91@hust.edu.cn
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mudongliangabcd@gmail.com
References: <20220720072346.33511-1-dzm91@hust.edu.cn>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220720072346.33511-1-dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 20/07/2022 à 09:23, Dongliang Mu a écrit :
> From: Dongliang Mu <mudongliangabcd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> The function tv_probe does not need to invoke kfree when the
> allocation fails. So let's simplify the code of tv_probe.
> Another change is to remove a redundant space.
> 
> Signed-off-by: Dongliang Mu <mudongliangabcd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>   drivers/usb/misc/trancevibrator.c | 13 +++----------
>   1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/misc/trancevibrator.c b/drivers/usb/misc/trancevibrator.c
> index 26baba3ab7d7..30d4d774d448 100644
> --- a/drivers/usb/misc/trancevibrator.c
> +++ b/drivers/usb/misc/trancevibrator.c
> @@ -84,29 +84,22 @@ static int tv_probe(struct usb_interface *interface,
>   {
>   	struct usb_device *udev = interface_to_usbdev(interface);
>   	struct trancevibrator *dev;
> -	int retval;
>   
>   	dev = kzalloc(sizeof(struct trancevibrator), GFP_KERNEL);
> -	if (!dev) {
> -		retval = -ENOMEM;
> -		goto error;
> -	}
> +	if (!dev)
> +		return -ENOMEM;
>   
>   	dev->udev = usb_get_dev(udev);
>   	usb_set_intfdata(interface, dev);
>   
>   	return 0;

Hi,

looks like:

error:
	kfree(dev);
	return retval;

at the end of the function can be removed as-well.

Just my 2c.

CJ
