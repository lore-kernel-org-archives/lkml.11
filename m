Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6932AECAAD3
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Sep 2022 06:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbiIDGVG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Sep 2022 02:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbiIDGVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 02:21:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8C632EF6
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 23:21:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3E8BB80D0D
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 06:20:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99D6C433C1;
        Sun,  4 Sep 2022 06:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662272458;
        bh=AUNJxKjdpBWg6fMDQFF0bVqggoWCYu/JuIcn4fiRQ60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wo0z3G9bwRMsmoM5Z6MUT6mtZ3TFYgX1H26++Y+OcS5nm2k5sMRb4m3D7TBo1y8sB
         9XhllBtG05bt2F+zkckiW4FRjc+wAQi+uVbU1VRGCxaY7II8IZWZfmlDH6W8GidR22
         /B2EPQkMctBWx8w/fx7NYohqnVmjZwCkJxiaOfpY=
Date:   Sun, 4 Sep 2022 08:20:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Li Zhong <floridsleeves@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org
Subject: Re: [PATCH v2] drivers/base/auxiliary: check return value of
 strrchr()
Message-ID: <YxRDx7DEIXEDGXRj@kroah.com>
References: <20220904005156.2281982-1-floridsleeves@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220904005156.2281982-1-floridsleeves@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2022 at 05:51:56PM -0700, Li Zhong wrote:
> The return value of strrchr() could be NULL, which will cause invalid
> offset in (int)(p - name). So we check it here.
> 
> Signed-off-by: Li Zhong <floridsleeves@gmail.com>
> ---
>  drivers/base/auxiliary.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
> index 8c5e65930617..2ec0306bfba3 100644
> --- a/drivers/base/auxiliary.c
> +++ b/drivers/base/auxiliary.c
> @@ -191,6 +191,8 @@ static int auxiliary_uevent(struct device *dev, struct kobj_uevent_env *env)
>  
>  	name = dev_name(dev);
>  	p = strrchr(name, '.');
> +	if (!p)
> +		return -EINVAL;

How can that ever happen?  For what device will that be triggered?

And again, please follow Documentation/process/researcher-guidelines.rst
