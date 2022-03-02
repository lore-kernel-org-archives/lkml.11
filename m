Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E474C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 09:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbiCBJsg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 04:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240648AbiCBJsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:48:31 -0500
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9449F6478
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 01:47:44 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id AF1D6200011;
        Wed,  2 Mar 2022 09:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646214460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O3o33HiAlAkKWePglOBZ60JYtBt9Yzo2sRdnF+CUZ9A=;
        b=CaPt6T8MIMXQLv7E0/HYOOBFtZ2rmiP4jd+Dnp/e6rBwnLRTJX783XWCGRjscENBIdpj16
        D8hWDAZwQYi5W3XAJGqOf8DNjx5o8O47IhroWFle+3O2/Piq5U/PL22C4nruc1y8Co7Xmc
        S50Xn/ni1PsiK8ll6WO/nkO4VH16MrJNxvpTetv8+Mg4OJx+M+hUyb4dssX7xftS+/TLue
        hvT4pURbDsNTI3LDCFO8wrpHaejBLp/ZFGhrJF9m4HTmpllBGquXma9jcnyqjoszj7eBYd
        h49LnNOQrz9cSizdXrlx9XBnZHt6qwC/isOTSzQSdiSH/9cbwUMH1yTtp1UMyA==
Date:   Wed, 2 Mar 2022 10:47:39 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     codrin.ciubotariu@microchip.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        claudiu.beznea@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: atmel-ssc: Handle error for clk_prepare
Message-ID: <Yh89O1sofdmcN/BR@piout.net>
References: <20220302084902.96651-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302084902.96651-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2022 16:49:02+0800, Jiasheng Jiang wrote:
> As the potential failure of the clk_prepare(),
> it should be better to check it and return error if fails.
> 

This will never ever fail, this doesn't fix anything

> Fixes: eb1f2930609b ("Driver for the Atmel on-chip SSC on AT32AP and AT91")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/misc/atmel-ssc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
> index d6cd5537126c..e0207e837e35 100644
> --- a/drivers/misc/atmel-ssc.c
> +++ b/drivers/misc/atmel-ssc.c
> @@ -25,7 +25,7 @@ static LIST_HEAD(ssc_list);
>  
>  struct ssc_device *ssc_request(unsigned int ssc_num)
>  {
> -	int ssc_valid = 0;
> +	int ssc_valid = 0, ret;
>  	struct ssc_device *ssc;
>  
>  	mutex_lock(&user_lock);
> @@ -57,7 +57,9 @@ struct ssc_device *ssc_request(unsigned int ssc_num)
>  	ssc->user++;
>  	mutex_unlock(&user_lock);
>  
> -	clk_prepare(ssc->clk);
> +	ret = clk_prepare(ssc->clk);
> +	if (ret)
> +		return ret;
>  
>  	return ssc;
>  }
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
