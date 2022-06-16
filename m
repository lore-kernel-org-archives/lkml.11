Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A03BC43334
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jun 2022 19:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbiFPTSn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jun 2022 15:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiFPTSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 15:18:42 -0400
Received: from smtp.smtpout.orange.fr (smtp10.smtpout.orange.fr [80.12.242.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3FB18B3C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 12:18:41 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 1v0oojzSC0JIm1v0oo8cPG; Thu, 16 Jun 2022 21:18:39 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 16 Jun 2022 21:18:39 +0200
X-ME-IP: 90.11.190.129
Message-ID: <0ce75f78-4a67-efce-938f-634dc981fbd6@wanadoo.fr>
Date:   Thu, 16 Jun 2022 21:18:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] gnss: Remove usage of the deprecated ida_simple_xxx API
Content-Language: en-US
To:     Bo Liu <liubo03@inspur.com>, johan@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20220616044733.3605-1-liubo03@inspur.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220616044733.3605-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 16/06/2022 à 06:47, Bo Liu a écrit :
> Use ida_alloc_xxx()/ida_free() instead of
> ida_simple_get()/ida_simple_remove().
> The latter is deprecated and more verbose.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Hi,

even if a more detailed description about the reason of the added -1 
would be welcomed:

Reviewed-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

> ---
>   drivers/gnss/core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gnss/core.c b/drivers/gnss/core.c
> index e6f94501cb28..1e82b7967570 100644
> --- a/drivers/gnss/core.c
> +++ b/drivers/gnss/core.c
> @@ -217,7 +217,7 @@ static void gnss_device_release(struct device *dev)
>   
>   	kfree(gdev->write_buf);
>   	kfifo_free(&gdev->read_fifo);
> -	ida_simple_remove(&gnss_minors, gdev->id);
> +	ida_free(&gnss_minors, gdev->id);
>   	kfree(gdev);
>   }
>   
> @@ -232,7 +232,7 @@ struct gnss_device *gnss_allocate_device(struct device *parent)
>   	if (!gdev)
>   		return NULL;
>   
> -	id = ida_simple_get(&gnss_minors, 0, GNSS_MINORS, GFP_KERNEL);
> +	id = ida_alloc_max(&gnss_minors, GNSS_MINORS - 1, GFP_KERNEL);
>   	if (id < 0) {
>   		kfree(gdev);
>   		return NULL;

