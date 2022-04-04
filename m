Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6CCC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Apr 2022 22:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiDDWhA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Apr 2022 18:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235927AbiDDWen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 18:34:43 -0400
Received: from mail1.bemta33.messagelabs.com (mail1.bemta33.messagelabs.com [67.219.247.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE65541B9;
        Mon,  4 Apr 2022 14:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com;
        s=Selector; t=1649109158; i=@motorola.com;
        bh=FC1k8RXkwsdD29iqlfP9VRrjSDl1IA59BmUkMvuR3So=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=DmiZ9Z/qOz36dBP3mupQj/+M+0S4TTv5JA2vt7F4+cpsl+xyG0/LPSKueiUZeuEs3
         7tmgbqlN6XOSuQbX7geToECPjK4rYINOa0oPGpeMvEZCfHEXp3rY6z6iPhQBGicXV8
         0GV9XUUWwJK2Q1gQ4LhWWEWmg7UNW15A7Inaztd/Cg/yrRWnB+Yl680gv965YGOexk
         8WUpjY6bypKkQ3yvSc68gox9MJK2vJYzkyKBgFpfKlPueCdxDCiOON6oOqZwBKuO0+
         GW11kIZNg3kWmOxmwifx5Yqv0EyD7ZC9fJ0xXm9WeKx0Y3WdsmBew/gN13HPayeTSE
         hhm6e4JR4CiZA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleJIrShJLcpLzFFi42LJePFEQndphne
  SweFuLYtjbU/YLeZsjrZ4cqCd0aJ58Xo2i/ebprBadE5cwm6xsG0Ji8XlXXPYLBYta2W2eDj7
  KqPF2zvTWRy4PWZ3zGT12LxCy2PTqk42j/1z17B7LO6bzOqxacotVo/Pm+Q8Dm1/wxbAEcWam
  ZeUX5HAmrGr/QZrwSWhiiN397A3MN7n72Lk4hASmMIkcfZ5JxOEs5BJ4vStNcxdjJwcLAIqEu
  sfLGEEsdkE1CQWvF4FFhcBiv+708IGYjML/GeS6P7oAmILC4RKzJw8CayeV0BZYs+Rw+wgtpB
  AkMTbs72sEHFBiZMzn7BA9GpJ3Pj3EmgxB5AtLbH8HwdImBNo1dMdN9knMPLOQtIxC0nHLISO
  BYzMqxitk4oy0zNKchMzc3QNDQx0DQ1NdM1MdQ0tDfUSq3QT9UqLdVMTi0t0jfQSy4v1UouL9
  Yorc5NzUvTyUks2MQLjI6XIcf8Oxp2rfuodYpTkYFIS5T3j6p0kxJeUn1KZkVicEV9UmpNafI
  hRhoNDSYI3JBUoJ1iUmp5akZaZA4xVmLQEB4+SCK+4I1Cat7ggMbc4Mx0idYpRl+PSoSt7mYV
  Y8vLzUqXEebvSgYoEQIoySvPgRsDSxiVGWSlhXkYGBgYhnoLUotzMElT5V4ziHIxKwrxbQKbw
  ZOaVwG16BXQEE9AR7854ghxRkoiQkmpgUivyznzVsljaIyt+U6aTwi27D4dWf818fqClf8nFZ
  7smr7nsHlClG+H2Y+H+3Ec7rCZ9mCfO/P1anryxw564+tmHUy9f4rq57rkcw+Vb3LsnZB36b/
  6EpWTKUntWyXL38MkLmmf+aWedG6g5Td/FxFSt8Pa3ZEeO13+W8QldfvSB8fzjGzmvXT5533B
  evcdYIbrUVlOVu+HVl4/bGgQn/z2i+qM9UFmUbUMnS3K8Svl/MQ77YBPjy8tOfdJPWNz29Jnp
  envl88Kffj1y+Wf+9fne3B9hdvOPVSjbq8ufE5P8tkFiAgtT8TmF82rmyT9MDVIPl5StacxZ2
  L3shIkyd2+7UfVMvngfg8/dXziPKLEUZyQaajEXFScCAGWVNMWWAwAA
X-Env-Sender: w36195@motorola.com
X-Msg-Ref: server-5.tower-715.messagelabs.com!1649109157!2020!1
X-Originating-IP: [104.232.228.24]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30282 invoked from network); 4 Apr 2022 21:52:37 -0000
Received: from unknown (HELO va32lpfpp04.lenovo.com) (104.232.228.24)
  by server-5.tower-715.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 4 Apr 2022 21:52:37 -0000
Received: from ilclmmrp02.lenovo.com (ilclmmrp02.mot.com [100.65.83.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by va32lpfpp04.lenovo.com (Postfix) with ESMTPS id 4KXPdd24JKzgMXh;
        Mon,  4 Apr 2022 21:52:37 +0000 (UTC)
Received: from p1g3 (unknown [10.45.5.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: w36195)
        by ilclmmrp02.lenovo.com (Postfix) with ESMTPSA id 4KXPdc6bglzbrlP;
        Mon,  4 Apr 2022 21:52:36 +0000 (UTC)
Date:   Mon, 4 Apr 2022 16:52:35 -0500
From:   Dan Vacura <w36195@motorola.com>
To:     John Keeping <john@metanate.com>
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
Message-ID: <YktoowtOyRcCBLOb@p1g3>
References: <20220401160447.5919-1-w36195@motorola.com>
 <YkgyZ6BrSX/7pDry@donbot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkgyZ6BrSX/7pDry@donbot>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2022 at 12:24:23PM +0100, John Keeping wrote:
> On Fri, Apr 01, 2022 at 11:04:45AM -0500, Dan Vacura wrote:
> > Add a configfs entry, "function_name", to change the iInterface field
> > for VideoControl. This name is used on host devices for user selection,
> > useful when multiple cameras are present. The default will remain "UVC
> > Camera".
> 
> > diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
> > index 71bb5e477dba..50e6e7a58b41 100644
> > --- a/drivers/usb/gadget/function/f_uvc.c
> > +++ b/drivers/usb/gadget/function/f_uvc.c
> > @@ -44,7 +44,7 @@ MODULE_PARM_DESC(trace, "Trace level bitmask");
> >  #define UVC_STRING_STREAMING_IDX		1
> >  
> >  static struct usb_string uvc_en_us_strings[] = {
> > -	[UVC_STRING_CONTROL_IDX].s = "UVC Camera",
> > +	/* [UVC_STRING_CONTROL_IDX].s = DYNAMIC, */
> >  	[UVC_STRING_STREAMING_IDX].s = "Video Streaming",
> >  	{  }
> >  };
> > @@ -676,6 +676,7 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
> >  	uvc_hs_streaming_ep.bEndpointAddress = uvc->video.ep->address;
> >  	uvc_ss_streaming_ep.bEndpointAddress = uvc->video.ep->address;
> >  
> > +	uvc_en_us_strings[UVC_STRING_CONTROL_IDX].s = opts->function_name;
> >  	us = usb_gstrings_attach(cdev, uvc_function_strings,
> >  				 ARRAY_SIZE(uvc_en_us_strings));
> >  	if (IS_ERR(us)) {
> > @@ -866,6 +867,7 @@ static struct usb_function_instance *uvc_alloc_inst(void)
> >  
> >  	opts->streaming_interval = 1;
> >  	opts->streaming_maxpacket = 1024;
> > +	snprintf(opts->function_name, sizeof(opts->function_name), "UVC Camera");
> 
> This only allows a single language to be specified.  I know that's what
> the existing string uses, but for other strings which can be set by
> userspace multiple languages are supported.
> 
> Should we be making USB_CONFIG_STRINGS_LANG more generic so that it can
> be used by functions as well as the core configfs code?

Agree that adding support for more than one language would be ideal.
Looking through the gadget functions, most seem to be hardcoded to en-us
locale and don't provide a way to change the exposed names. Recently
this was just accepted, which I modeled my change after:
https://lore.kernel.org/all/20220122112446.1415547-2-t123yh.xyz@gmail.com/
so at least making USB_CONFIG_STRINGS_LANG more generic would benefit
the uac and uvc gadgets.

