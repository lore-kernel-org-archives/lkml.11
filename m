Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397A9C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 15:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242396AbiCNPGv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 11:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236609AbiCNPGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 11:06:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443C73EBBE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 08:05:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8C18B80E27
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 15:05:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45671C340E9;
        Mon, 14 Mar 2022 15:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647270334;
        bh=vid+gcRgrdHBjbvxXWaS6eC74Yc5hgJyVhx5aF4/+Hw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EZWqg2xyUizyuaW4pkIuktGlFVzm+xlX7sfxZ7/jdiw9JTF/LSb+rQeXeO1QC5dHE
         lSFeZaOkuhVyOS3hB24Ny7Lx7J7jD0zknbAPm7SPTNHk6jSjZnSkNnOTN0lcD80V2a
         qkPTmEKHJggKjazz3FqCIVupMgAAtQRqsL2Qx4g8=
Date:   Mon, 14 Mar 2022 16:05:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gaston Gonzalez <gascoar@gmail.com>
Cc:     linux-staging@lists.linux.dev, nsaenz@kernel.org,
        stefan.wahren@i2se.com, ojaswin98@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: vchiq_arm: add prototype of function
 vchiq_platform_init()
Message-ID: <Yi9ZuTMXVSbOAgdO@kroah.com>
References: <cover.1646255044.git.gascoar@gmail.com>
 <b74ac90e869f71a98a04b834c4f3b5ab37bb38ea.1646255044.git.gascoar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b74ac90e869f71a98a04b834c4f3b5ab37bb38ea.1646255044.git.gascoar@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 06:36:38PM -0300, Gaston Gonzalez wrote:
> Fix "no previous prototype" W=1 warning by adding the prototype of the
> function vchiq_platform_init().
> 
> Note: vchiq_platform_init() is only called once in vchiq_probe(), so
> presumably should be static function. However, making the function
> static breaks the build.
> 
> Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
> ---
>  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
> index 2aa46b119a46..d72edaf7e5e9 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
> @@ -122,6 +122,8 @@ vchiq_instance_get_trace(struct vchiq_instance *instance);
>  extern void
>  vchiq_instance_set_trace(struct vchiq_instance *instance, int trace);
>  
> +int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state *state);
> +

It is a static function, so don't add a prototype here to say it is not
:(

thanks,

greg k-h
