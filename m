Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69F0C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Mar 2022 12:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346722AbiCHMXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Mar 2022 07:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiCHMXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 07:23:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB8E45519
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 04:22:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 975E5B81671
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 12:22:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516D9C340EB;
        Tue,  8 Mar 2022 12:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646742135;
        bh=tQ/Ta8ibjiF0mkPsCvPpKtPHRJDGVp5VJicu7manDj4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cJbMKcbYlSvM9sQJumYcSEhKRgdFgFTT80rZ+nUd/gwxqiSXuTkUHTN00iLedebpq
         I2q1u0Sw71CLj5UCemFgDNv4RbytVnKGNNYGkLZktBzN2GakoKuJ70EoEImNQFj9ft
         ByxwQLwv0U8lv/RS5JF2eI87RoNRUpKRjcoNPniDm3zmXkFZZQP9qS8AmD3a05zDoX
         bemrHof6ybDvS0Ki72V92funG1iflCwm4htRBnrbdXC1IyGGnWWi5Ltp7BKYmqfm+9
         EbPAyGdrhUTE+VKyc6gk5CbwfbQK9JHoW1KxDu7+cZv/FFpCdiwxoNjFKTsF5tuhDC
         QXfkG1jiF9xRg==
Message-ID: <87c332e3-00ea-0611-fd5d-96adcaa614dc@kernel.org>
Date:   Tue, 8 Mar 2022 14:22:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V1] extcon/usb: Remove disable irq operation in system
 sleep.
Content-Language: en-US
To:     Bruce Chen <brucechen251@gmail.com>, bruce.chen@unisoc.com,
        myungjoo.ham@samsung.com, cw00.choi@samsung.com,
        linux-kernel@vger.kernel.org
Cc:     orsonzhai@gmail.com, gengcixi@gmail.com, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com
References: <1646292963-20570-1-git-send-email-brucechen251@gmail.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <1646292963-20570-1-git-send-email-brucechen251@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/03/2022 09:36, Bruce Chen wrote:
> From: Bruce Chen <bruce.chen@unisoc.com>
> 
> If disable vbus/id irq, it will lead to wakeup system fail
> in unisoc platform. In unisoc platform, Irq enable and irq
> wakeup are the same interrupt line. So remove disable vbus/id
> irq operation is a way to solve the issue.
> 
> Signed-off-by: Bruce Chen <bruce.chen@unisoc.com>

Acked-by: Roger Quadros <rogerq@kernel.org>

> ---
>  drivers/extcon/extcon-usb-gpio.c | 15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-usb-gpio.c b/drivers/extcon/extcon-usb-gpio.c
> index f2b65d9..40d967a 100644
> --- a/drivers/extcon/extcon-usb-gpio.c
> +++ b/drivers/extcon/extcon-usb-gpio.c
> @@ -226,16 +226,6 @@ static int usb_extcon_suspend(struct device *dev)
>  		}
>  	}
>  
> -	/*
> -	 * We don't want to process any IRQs after this point
> -	 * as GPIOs used behind I2C subsystem might not be
> -	 * accessible until resume completes. So disable IRQ.
> -	 */
> -	if (info->id_gpiod)
> -		disable_irq(info->id_irq);
> -	if (info->vbus_gpiod)
> -		disable_irq(info->vbus_irq);
> -
>  	if (!device_may_wakeup(dev))
>  		pinctrl_pm_select_sleep_state(dev);
>  
> @@ -267,11 +257,6 @@ static int usb_extcon_resume(struct device *dev)
>  		}
>  	}
>  
> -	if (info->id_gpiod)
> -		enable_irq(info->id_irq);
> -	if (info->vbus_gpiod)
> -		enable_irq(info->vbus_irq);
> -
>  	queue_delayed_work(system_power_efficient_wq,
>  			   &info->wq_detcable, 0);
>  

--
cheers,
-roger
