Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE26C4332F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Mar 2022 14:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237927AbiC2Oft (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Mar 2022 10:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238009AbiC2Oed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:34:33 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAE01C935
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 07:32:50 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id p21so7217622ioj.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 07:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qSTrUL6WlyOgAbYd80glH9hQCFNO5qIECH8QC7MsZz0=;
        b=BzP5Vs5piewGOcMGK+PbvKkzV47OGA/ob4vuN1NMspDx8Y39MtQLR3PC5d1JDBTYoB
         GaboRGeOd2ntywJe32ct9vlJTtMx9t3x0SXCZDIUElARJwvkRP17EtlgC26exdZVuSiR
         jk0U7rd0yJPJP+H8mPYNbV6HpQo6OhNp1+aDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qSTrUL6WlyOgAbYd80glH9hQCFNO5qIECH8QC7MsZz0=;
        b=wtim3NSF5DpMRFjs6LgYZTSHlcToVmQEPQ0RvtbDSCh3Yivr5GpQ7JPzhB5s2MnY2f
         dFTB/J7atiz0N0RkUvv/i52W9DwqNtUOKmy+NmBR1GfFdRNPwV79bW5H0rcOOdJFsoTs
         dMq3lttVfFUDuvujoXmttCTFvza2YRqXD10qAZ7RA6Xmo+x89QKJV5PC6GWUI3D/9oi2
         YP23nbH7cMvpXyTo4C88txe0XcJ6vQkdyhXhivR4FVLV0abli9tzD6GXqWSTd6mTD+41
         U24BD4VWWDtE2wziRrMnTrFWPcZWl5QZ0YK//Cvy9AXgLDX/L0tI4kzLecP4I0Ktad+c
         zYgQ==
X-Gm-Message-State: AOAM533aSNxnfdEmHspc6urdEXmH5EbyEmnFF+l5VU1rln+IExsqzc/6
        cazIaDWOwoICMBPlPtHb/3iFMw==
X-Google-Smtp-Source: ABdhPJz9sAJRWgIir4HFvWl6YO/q2eo3ky5z8M8Vi7tTknpv4sKuYPaYlOmwcyj0LGnEZvi4JXjehQ==
X-Received: by 2002:a02:604f:0:b0:30f:e6f1:3883 with SMTP id d15-20020a02604f000000b0030fe6f13883mr16742779jaf.266.1648564369340;
        Tue, 29 Mar 2022 07:32:49 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id n4-20020a92d9c4000000b002c886034defsm6932289ilq.62.2022.03.29.07.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 07:32:48 -0700 (PDT)
Subject: Re: [PATCH] usb: gadget: udc: add NULL pointer check
To:     cgel.zte@gmail.com, balbi@kernel.org
Cc:     gregkh@linuxfoundation.org, peter.chen@kernel.or,
        christophe.jaillet@wanadoo.fr, lv.ruyi@zte.com.cn,
        johan@kernel.org, jakobkoschel@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220329055407.2375626-1-lv.ruyi@zte.com.cn>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <adab4546-632b-ae73-f3bc-b7fd306eedca@linuxfoundation.org>
Date:   Tue, 29 Mar 2022 08:32:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220329055407.2375626-1-lv.ruyi@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/22 11:54 PM, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> kzalloc() is a memory allocation function which can return NULL when some
> internal memory errors happen. It is safer to check NULL pointer.
> 

Please add information on how this problem was found, including the
tool used and warn message.

> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> ---
>   drivers/usb/gadget/udc/mv_udc_core.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/mv_udc_core.c b/drivers/usb/gadget/udc/mv_udc_core.c
> index fdb17d86cd65..f52eb3f2420a 100644
> --- a/drivers/usb/gadget/udc/mv_udc_core.c
> +++ b/drivers/usb/gadget/udc/mv_udc_core.c
> @@ -2231,6 +2231,10 @@ static int mv_udc_probe(struct platform_device *pdev)
>   
>   	/* allocate a small amount of memory to get valid address */
>   	udc->status_req->req.buf = kzalloc(8, GFP_KERNEL);
> +	if (!udc->status_req->req.buf) {
> +		retval = -ENOMEM;
> +		goto err_destroy_dma;
> +	}

Looks good to me.

>   	udc->status_req->req.dma = DMA_ADDR_INVALID;
>   
>   	udc->resume_state = USB_STATE_NOTATTACHED;
> 

With that change to the commit log

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
