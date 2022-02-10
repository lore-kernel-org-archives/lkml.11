Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2F1C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Feb 2022 02:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiBJCho (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Feb 2022 21:37:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiBJChm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 21:37:42 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D12B10E2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 18:37:41 -0800 (PST)
Date:   Thu, 10 Feb 2022 10:37:14 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1644460659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f52O7WU1jwjZjNL8pYiw1viyPBOlQoX/LtWrz0nwoZU=;
        b=t1IVKDGvHGmQCcYPWGCk9v+IX1EUYsLful9GLVsg57O/OrX44rmgLM0/Sz3lt8c+sBH9vZ
        Ox1Ez1l1gHVncc4IX3DGcrgHllFaWWgaoHzOsH8qKoQcCHxh44tA/ukH72TaLFxNktDC48
        oHy1Vl0FyCvcIzyYJYYJ5Vo6vUxEh+0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usbip: vudc: Make use of the helper macro LIST_HEAD()
Message-ID: <20220210023714.GA7791@chq-T47>
References: <20220209032813.38703-1-cai.huoqing@linux.dev>
 <8c8bcf5b-bbda-55e0-6a61-35bfafbafb78@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c8bcf5b-bbda-55e0-6a61-35bfafbafb78@linuxfoundation.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09 2月 22 09:00:37, Shuah Khan wrote:
> On 2/8/22 8:28 PM, Cai Huoqing wrote:
> > Replace "struct list_head head = LIST_HEAD_INIT(head)" with
> > "LIST_HEAD(head)" to simplify the code.
> > 
> > Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
> > ---
> >   drivers/usb/usbip/vudc_main.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/usbip/vudc_main.c b/drivers/usb/usbip/vudc_main.c
> > index 678faa82598c..d43252b77efd 100644
> > --- a/drivers/usb/usbip/vudc_main.c
> > +++ b/drivers/usb/usbip/vudc_main.c
> > @@ -26,7 +26,7 @@ static struct platform_driver vudc_driver = {
> >   	},
> >   };
> > -static struct list_head vudc_devices = LIST_HEAD_INIT(vudc_devices);
> > +static LIST_HEAD(vudc_devices);
> >   static int __init init(void)
> >   {
> > 
> 
> Explain why this change simplifies the code and also add a comment
> above LIST_HEAD
LIST_HEAD() help to clean up the code "struct list_head vudc_devices =
". we only to care the variable 'vudc_devices',
> 
> LIST_HEAD_INIT clearly states what it does, as a result it is easier
> to understand the code.
LIST_HEAD() is defined for 17 years, lots of drivers use it
directly. It's not about code readability.

Thanks,
Cai
> 
> thanks,
> -- Shuah
