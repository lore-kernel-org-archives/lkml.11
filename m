Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BDFC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 11:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350079AbiBNLHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 06:07:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350356AbiBNLHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:07:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD9E3D481;
        Mon, 14 Feb 2022 02:37:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43F38B80D8E;
        Mon, 14 Feb 2022 10:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D56EC340E9;
        Mon, 14 Feb 2022 10:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644835019;
        bh=j3IzS5aFUIef788Ea81CK91huIk0KlHPxkOZBNdtt2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YuB5XVFmIXpxEQvGSIcbdMIVQ6ExH6BG34hz1SLfOeUXZKhlx1qXEqYUnLpgb4Pfl
         ozkPEsuUbhJMjN0mEnop4OgBoXT4su9F5bO+1UQvTiBh6LUexwfk6+2uEjbHqK93cM
         xQBc9iz1DATebjxTAu/7WdLxyV5Nl+VDXG0q7aYQ=
Date:   Mon, 14 Feb 2022 11:36:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     3090101217@zju.edu.cn
Cc:     balbi@kernel.org, ruslan.bilovol@gmail.com,
        pavel.hofman@ivitera.com, jbrunet@baylibre.com,
        jackp@codeaurora.org, colin.king@intel.com, pawell@cadence.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jing Leng <jleng@ambarella.com>
Subject: Re: [PATCH] usb: gadget: f_uac2: fix superspeed transfer
Message-ID: <YgowyN4thlrJw6J9@kroah.com>
References: <20220214032606.17227-1-3090101217@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214032606.17227-1-3090101217@zju.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 11:26:06AM +0800, 3090101217@zju.edu.cn wrote:
> From: Jing Leng <jleng@ambarella.com>
> 
> ss_ep_int_desc endpoint doesn't have 'SuperSpeed Endpoint
> Companion Descriptor', so we should add it.

This is not a "fix" but rather a new feature.

Why does this endpoint need this descriptor?  We need a lot more
description here please.

> 
> Signed-off-by: Jing Leng <jleng@ambarella.com>
> ---
>  drivers/usb/gadget/function/f_uac2.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
> index 097a709549d6..a6fc492f9148 100644
> --- a/drivers/usb/gadget/function/f_uac2.c
> +++ b/drivers/usb/gadget/function/f_uac2.c
> @@ -282,6 +282,14 @@ static struct usb_endpoint_descriptor ss_ep_int_desc = {
>  	.bInterval = 4,
>  };
>  
> +static struct usb_ss_ep_comp_descriptor ss_ep_int_desc_comp = {
> +	.bLength = sizeof(ss_ep_int_desc_comp),
> +	.bDescriptorType = USB_DT_SS_ENDPOINT_COMP,
> +	.bMaxBurst = 0,
> +	.bmAttributes = 0,

0 is the default value if it is not defined.

thanks,

greg k-h
