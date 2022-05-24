Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE3EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 24 May 2022 20:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241424AbiEXUYp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 16:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237701AbiEXUYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 16:24:43 -0400
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3215C654
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 13:24:41 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.191.102])
        by smtp.orange.fr with ESMTPA
        id tb4xnPisO4Ltqtb4xnh97t; Tue, 24 May 2022 22:24:36 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 24 May 2022 22:24:36 +0200
X-ME-IP: 90.11.191.102
Message-ID: <27777e38-5967-6c87-210a-626461ec125c@wanadoo.fr>
Date:   Tue, 24 May 2022 22:24:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V2] platforms/83xx: Use of_device_get_match_data()
Content-Language: en-GB
To:     cgel.zte@gmail.com, oss@buserror.net
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220225010737.2038781-1-chi.minghao@zte.com.cn>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220225010737.2038781-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 25/02/2022 à 02:07, cgel.zte@gmail.com a écrit :
> From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
> 
> Use of_device_get_match_data() to simplify the code.
> v1->v2:
> 	Add a judgment on the return value of the A function as NULL
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
> ---
>   arch/powerpc/platforms/83xx/suspend.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/83xx/suspend.c b/arch/powerpc/platforms/83xx/suspend.c
> index bb147d34d4a6..6d47a5b81485 100644
> --- a/arch/powerpc/platforms/83xx/suspend.c
> +++ b/arch/powerpc/platforms/83xx/suspend.c
> @@ -322,18 +322,15 @@ static const struct platform_suspend_ops mpc83xx_suspend_ops = {
>   static const struct of_device_id pmc_match[];

Hi,
I think that the line above can now be removed as well.

just my 2c.

CJ


>   static int pmc_probe(struct platform_device *ofdev)
>   {
> -	const struct of_device_id *match;
>   	struct device_node *np = ofdev->dev.of_node;
>   	struct resource res;
>   	const struct pmc_type *type;
>   	int ret = 0;
>   
> -	match = of_match_device(pmc_match, &ofdev->dev);
> -	if (!match)
> +	type = of_device_get_match_data(&ofdev->dev);
> +	if (!type)
>   		return -EINVAL;
>   
> -	type = match->data;
> -
>   	if (!of_device_is_available(np))
>   		return -ENODEV;
>   

