Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BC0C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Feb 2022 15:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242488AbiBQP3I (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Feb 2022 10:29:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242461AbiBQP3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:29:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2612AB508;
        Thu, 17 Feb 2022 07:28:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DD3561E9F;
        Thu, 17 Feb 2022 15:28:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ABFFC340E8;
        Thu, 17 Feb 2022 15:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645111731;
        bh=ru4JYpuY+BIPB6TA0dGc9lns/k0eZgQxIgm7/e+BfO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U8Xn12Sz0aqZ0kUd9SIDuRVaNIFErQA7sEq0vQ93pD1F9eGNfLhDxZyq+YKJ8AEAJ
         56zIF669Xc4GtDNb0wnI9Kq5/LvUGUP6qaYzCvD7mAA4BBOx6NdHNW0CB5GetivmQJ
         ChmoP8uBazLnjAm2cSULKoV+JPxOcbE4I5wlLnPA=
Date:   Thu, 17 Feb 2022 16:28:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jing Leng <3090101217@zju.edu.cn>
Cc:     balbi@kernel.org, ruslan.bilovol@gmail.com,
        pavel.hofman@ivitera.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jing Leng <jleng@ambarella.com>
Subject: Re: [PATCH] usb: gadget: f_uac1: add set requests support
Message-ID: <Yg5psAzBNrVvOpGc@kroah.com>
References: <20220216094301.2448-1-3090101217@zju.edu.cn>
 <YgzTsLV/nSKp7FWP@kroah.com>
 <770c0d3f.ab34b.17f0557e359.Coremail.3090101217@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <770c0d3f.ab34b.17f0557e359.Coremail.3090101217@zju.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 09:42:00AM +0800, Jing Leng wrote:
> Hi Greg KH,
> 
> > So is this a bug in the Host side to not do stuff like this?  Why not
> > fix it there instead?
> > 
> > Where is the requirement that this command must be handled by the
> > device?
> > 
> 
> First we need to clarify two issues.
> 
> 1. Does the Ubuntu go beyond the UAC1 specification?
> No. 
> On page 66 of the UAC1 specification (
> https://www.usb.org/sites/default/files/audio10.pdf):
> The bRequest can be SET_CUR, SET_MIN, SET_MAX, SET_RES or SET_MEM.
> In most cases, only the CUR and MEM attribute will be supported for
> the Set request. However, this specification does not prevent a
> designer from making other attributes programmable.
> Supplement: Windows 10 only sends SET_CUR request.
> 
> 2. Does the old version kernel have the problem on the Ubuntu?
> NO. (e.g. linux-5.10)
> The problem is introduced by the following modification:
>     commit 0356e6283c7177391d144612f4b12986ed5c4f6e
>     Author: Ruslan Bilovol <ruslan.bilovol@gmail.com>
>     Date:   Mon Jul 12 14:55:29 2021 +0200
> 
>         usb: gadget: f_uac1: add volume and mute support

Then please add this commit id as a "Fixes:" tag in the changelog area.

thanks,

greg k-h
