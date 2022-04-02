Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A5DC433FE
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Apr 2022 11:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240708AbiDBL00 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Apr 2022 07:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237246AbiDBL0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 07:26:24 -0400
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006001A488C;
        Sat,  2 Apr 2022 04:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=piEcQKp69tsqp6f1AmqC7AayDxYUhW60pSCM0aWFEeo=; b=eIzu7
        jixZN9WJBpZDw+WDPLuM9EnqlUhsdn2C2Jn/oMsVAfB5TpDbocqkJK2ctQ6QJCJA37lfB2Emg8UhD
        r/n8OHlrEaqyKHkCVTVz0lAVZ+gLmVhikrF0oA+g2jJl4e1KUO7dRqhlRVSNqYRtYDAwU1GRjOxQg
        pkoXvvf4McrSfcfenv4FfR/cbPQXhXsuRxpT5zF0mqqbfVo0MExPcZE65nFhW/mI/JUE3trHP/KSR
        rue09fXK4Vgr1RxZKXo5HbwUYEID3sxJhhQVhbKQqei5uGjdr31m5gc8PCj/hksyAedXJAIA9vHh3
        RSSu3l/Ezw++UBYulMEiZNCXapZfQ==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1nabrn-0007hO-Qf; Sat, 02 Apr 2022 12:24:27 +0100
Date:   Sat, 2 Apr 2022 12:24:23 +0100
From:   John Keeping <john@metanate.com>
To:     Dan Vacura <w36195@motorola.com>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Carlos Bilbao <bilbao@vt.edu>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: uvc: allow changing interface name via
 configfs
Message-ID: <YkgyZ6BrSX/7pDry@donbot>
References: <20220401160447.5919-1-w36195@motorola.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401160447.5919-1-w36195@motorola.com>
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 11:04:45AM -0500, Dan Vacura wrote:
> Add a configfs entry, "function_name", to change the iInterface field
> for VideoControl. This name is used on host devices for user selection,
> useful when multiple cameras are present. The default will remain "UVC
> Camera".

> diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
> index 71bb5e477dba..50e6e7a58b41 100644
> --- a/drivers/usb/gadget/function/f_uvc.c
> +++ b/drivers/usb/gadget/function/f_uvc.c
> @@ -44,7 +44,7 @@ MODULE_PARM_DESC(trace, "Trace level bitmask");
>  #define UVC_STRING_STREAMING_IDX		1
>  
>  static struct usb_string uvc_en_us_strings[] = {
> -	[UVC_STRING_CONTROL_IDX].s = "UVC Camera",
> +	/* [UVC_STRING_CONTROL_IDX].s = DYNAMIC, */
>  	[UVC_STRING_STREAMING_IDX].s = "Video Streaming",
>  	{  }
>  };
> @@ -676,6 +676,7 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
>  	uvc_hs_streaming_ep.bEndpointAddress = uvc->video.ep->address;
>  	uvc_ss_streaming_ep.bEndpointAddress = uvc->video.ep->address;
>  
> +	uvc_en_us_strings[UVC_STRING_CONTROL_IDX].s = opts->function_name;
>  	us = usb_gstrings_attach(cdev, uvc_function_strings,
>  				 ARRAY_SIZE(uvc_en_us_strings));
>  	if (IS_ERR(us)) {
> @@ -866,6 +867,7 @@ static struct usb_function_instance *uvc_alloc_inst(void)
>  
>  	opts->streaming_interval = 1;
>  	opts->streaming_maxpacket = 1024;
> +	snprintf(opts->function_name, sizeof(opts->function_name), "UVC Camera");

This only allows a single language to be specified.  I know that's what
the existing string uses, but for other strings which can be set by
userspace multiple languages are supported.

Should we be making USB_CONFIG_STRINGS_LANG more generic so that it can
be used by functions as well as the core configfs code?
