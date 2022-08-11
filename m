Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E390C25B0C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Aug 2022 08:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbiHKIv3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Aug 2022 04:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbiHKIv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 04:51:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CE2915E7;
        Thu, 11 Aug 2022 01:51:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7ACC36157E;
        Thu, 11 Aug 2022 08:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0A4C433C1;
        Thu, 11 Aug 2022 08:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660207885;
        bh=uQkZF6eElSFOuf/W02ThY5e86BESvP+3QMOE/cj00+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R5GIz0wdAiUHw6uYUIeEsCM/ZJgYQ++ov7QdTV62iaFt6Po/2LdDtcmD9MqHK3dW7
         tCCLuqebbyRhJ7ePJm/e7eZGJwq0gRPCqhElqahSIC0OvXVksqofnBrmNOwkCshRau
         kCW7Qg6+HtHzvcVTMnU7DvVoUbCBEEVm5IfJthwQ=
Date:   Thu, 11 Aug 2022 10:51:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhou jie <zhoujie@nfschina.com>
Cc:     johan@kernel.org, kernel@nfschina.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] usb/serial:Repair function return value
Message-ID: <YvTDCpjrqxxK46Us@kroah.com>
References: <YvS8AK9apa7tnYOz@kroah.com>
 <20220811084237.6651-1-zhoujie@nfschina.com>
 <20220811084237.6651-2-zhoujie@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811084237.6651-2-zhoujie@nfschina.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 04:42:37PM +0800, Zhou jie wrote:
> Repair function return value,The previous return value did not work.
> 
> v2:
>   Modifying function return value type does not work.

Please put this below the --- line as the documentation asks for.

> 
> Signed-off-by: Zhou jie <zhoujie@nfschina.com>
> ---
>  drivers/usb/serial/mos7720.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
> index 1e12b5f30dcc..215b1c87fa07 100644
> --- a/drivers/usb/serial/mos7720.c
> +++ b/drivers/usb/serial/mos7720.c
> @@ -243,9 +243,8 @@ static inline int mos7715_change_mode(struct mos7715_parport *mos_parport,
>  				      enum mos7715_pp_modes mode)
>  {
>  	mos_parport->shadowECR = mode;
> -	write_mos_reg(mos_parport->serial, dummy, MOS7720_ECR,
> +	return write_mos_reg(mos_parport->serial, dummy, MOS7720_ECR,
>  		      mos_parport->shadowECR);
> -	return 0;

Are you sure that this change does what you think it does?

Hint, what does write_mos_reg() return if all goes well?

Also the indentation of the second line is now incorrect.

This is going to take more work to get correct, please take your time
and think about it and test your changes before resending.

thanks,

greg k-h
