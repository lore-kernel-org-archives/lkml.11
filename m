Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDD7C4321E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Apr 2022 14:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351646AbiDZOgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Apr 2022 10:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242070AbiDZOgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:36:03 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B1A3B7C4F;
        Tue, 26 Apr 2022 07:32:55 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1njMFK-0004FF-04; Tue, 26 Apr 2022 16:32:54 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 840B8C01C7; Tue, 26 Apr 2022 16:32:16 +0200 (CEST)
Date:   Tue, 26 Apr 2022 16:32:16 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH] MIPS: SGI-IP30: Free some unused memory
Message-ID: <20220426143216.GE18291@alpha.franken.de>
References: <f9475119cf8d7dc51f9f993ab6a4de40a2735ca1.1650720466.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9475119cf8d7dc51f9f993ab6a4de40a2735ca1.1650720466.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 03:27:58PM +0200, Christophe JAILLET wrote:
> platform_device_add_data() duplicates the memory it is passed. So we can
> free some memory to save a few bytes that would remain unused otherwise.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  arch/mips/sgi-ip30/ip30-xtalk.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/mips/sgi-ip30/ip30-xtalk.c b/arch/mips/sgi-ip30/ip30-xtalk.c
> index 8a2894645529..8129524421cb 100644
> --- a/arch/mips/sgi-ip30/ip30-xtalk.c
> +++ b/arch/mips/sgi-ip30/ip30-xtalk.c
> @@ -63,6 +63,8 @@ static void bridge_platform_create(int widget, int masterwid)
>  	}
>  	platform_device_add_resources(pdev, &w1_res, 1);
>  	platform_device_add_data(pdev, wd, sizeof(*wd));
> +	/* platform_device_add_data() duplicates the data */
> +	kfree(wd);
>  	platform_device_add(pdev);
>  
>  	bd = kzalloc(sizeof(*bd), GFP_KERNEL);
> @@ -92,6 +94,8 @@ static void bridge_platform_create(int widget, int masterwid)
>  	bd->io_offset	= IP30_SWIN_BASE(widget);
>  
>  	platform_device_add_data(pdev, bd, sizeof(*bd));
> +	/* platform_device_add_data() duplicates the data */
> +	kfree(bd);
>  	platform_device_add(pdev);
>  	pr_info("xtalk:%x bridge widget\n", widget);
>  	return;
> -- 
> 2.32.0

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
