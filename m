Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2370EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 06:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiBVGBo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 01:01:44 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiBVGBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 01:01:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233A08E18E;
        Mon, 21 Feb 2022 22:01:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFFA8B817F8;
        Tue, 22 Feb 2022 06:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FADC340E8;
        Tue, 22 Feb 2022 06:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645509670;
        bh=09W0kiFTYRx8O9n+/pH16GuSjI8QB2q8R+DFiAvdlUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=holBWmQq1wkOcBz7FJdWMzwWM54Fd7zV9wNUgEfX3JYUeM6Iedj9d9g80oz98b3L6
         VutkZj2xuv0LE1aV6w8+Ai1eCb1lDfOteUtZt7cfLVVXjGHBdX3gTwQV8hMeoiOnjm
         VnyQ6pk3ZvLBGh5YosKKLQD/6+Fjl0C37eKo+Qro=
Date:   Tue, 22 Feb 2022 07:01:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <thinhn@synopsys.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH v2] usb: dwc3: Don't switch OTG -> peripheral if extcon
 is present
Message-ID: <YhR8IvgiyStkDbyc@kroah.com>
References: <20220221192020.346622-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221192020.346622-1-andrew.smirnov@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 11:20:20AM -0800, Andrey Smirnov wrote:
> If the extcon device exists, get the mode from the extcon device. If
> the controller is DRD and the driver is unable to determine the mode,
> only then default the dr_mode to USB_DR_MODE_PERIPHERAL.
> 
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Thinh Nguyen <thinhn@synopsys.com>
> Cc: linux-usb@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
> 
> v1 of the patch:
> 
> https://lore.kernel.org/linux-usb/20220206014532.372109-1-andrew.smirnov@gmail.com/T/#u
> 
> previons discussion:
> 
> https://lore.kernel.org/linux-usb/20220131192102.4115473-1-andrew.smirnov@gmail.com/
> 

You forgot to say what changed in this version.

thanks,

greg k-h
