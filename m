Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB775C00140
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Aug 2022 02:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbiHPCxE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 22:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbiHPCwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 22:52:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C9A566A44
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 16:21:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65C56106F;
        Mon, 15 Aug 2022 16:21:19 -0700 (PDT)
Received: from [10.57.15.201] (unknown [10.57.15.201])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 745DD3F70D;
        Mon, 15 Aug 2022 16:21:17 -0700 (PDT)
Message-ID: <ca6e9b7c-416d-dac4-7855-aa22fde3ef8c@arm.com>
Date:   Tue, 16 Aug 2022 00:21:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] ARM: Fix double word in comments
Content-Language: en-GB
To:     Xin Gao <gaoxin@cdjrlc.com>, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220815200051.4001-1-gaoxin@cdjrlc.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220815200051.4001-1-gaoxin@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-15 21:00, Xin Gao wrote:
> Delete repeated word "in" in comments.

It is not grammatically incorrect though. The second "in" is the 
preposition here, while the first is an adverb - "fill in" is a term in 
its own right, particularly in the context of information, whereas 
"fill" tends to suggest a more physical context. For instance, one might 
typically say "I filled the bottle" (with liquid), but "I filled in the 
application form" (with data).

Robin.

> Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
> ---
>   arch/arm/mach-pxa/palm27x.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-pxa/palm27x.c b/arch/arm/mach-pxa/palm27x.c
> index 1a8d25eecac3..116183859357 100644
> --- a/arch/arm/mach-pxa/palm27x.c
> +++ b/arch/arm/mach-pxa/palm27x.c
> @@ -160,7 +160,7 @@ void __init palm27x_lcd_init(int power, struct pxafb_mode_info *mode)
>   #if	defined(CONFIG_USB_PXA27X) || \
>   	defined(CONFIG_USB_PXA27X_MODULE)
>   
> -/* The actual GPIO offsets get filled in in the palm27x_udc_init() call */
> +/* The actual GPIO offsets get filled in the palm27x_udc_init() call */
>   static struct gpiod_lookup_table palm27x_udc_gpiod_table = {
>   	.dev_id = "gpio-vbus",
>   	.table = {
