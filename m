Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E8CC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Mar 2022 13:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350505AbiCXNk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Mar 2022 09:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238788AbiCXNkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 09:40:25 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9799043AD3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:38:53 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4B1302222E;
        Thu, 24 Mar 2022 14:38:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1648129131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q59i4/nf/UYOS4a6PO+Gtm8NBuHSVYjxTsJF4kgBZXU=;
        b=Ph2ByEYOCoIlOLlZFI2XbmvYjaNWotm0EbiPne9WntVvWUJp0Htt9pGzILZ/DbGngJ8jDZ
        w7A708l88quKzaoogokqou+fiLH9f9aK8ipo16gTLLvQLpHiJ5Ih3ksLkaBhkysNi5PfZ2
        RqHnkuep9+BZRcDqhY4wMLeUc0Tjq/w=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 24 Mar 2022 14:38:51 +0100
From:   Michael Walle <michael@walle.cc>
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Cc:     alexandre.belloni@bootlin.com, linux@armlinux.org.uk,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com,
        Manohar.Puri@microchip.com
Subject: Re: [PATCH v2] ARM: at91: debug: add lan966 support
In-Reply-To: <20220324131031.32430-1-kavyasree.kotagiri@microchip.com>
References: <20220324131031.32430-1-kavyasree.kotagiri@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <14e896d59fa48e51a777324d5813d17a@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kavyasree,

Am 2022-03-24 14:10, schrieb Kavyasree Kotagiri:
> Add support for low-level debugging on FLEXCOM3 USART of
> LAN966 SoC.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
> v1 -> v2:
> - Corrected flexcom3 base address - 0xe0064200.

Unfortunately, you didn't respond to my previous remarks. Not
everyone has the debug console on FLEXCOM3. Therefore, I suggested
to use DEBUG_AT91_LAN966_FLEXCOM (please note the missing '3' at
the end) and add a table with all the offsets to the help text.

I'm fine with having the flexcom3 base address by default. But
that should also be noted in the help text.

-michael

>  arch/arm/Kconfig.debug | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 0c9497d549e3..04501ddc7ab4 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -210,6 +210,14 @@ choice
>  		  Say Y here if you want kernel low-level debugging support
>  		  on the FLEXCOM3 port of SAMA7G5.
> 
> +        config DEBUG_AT91_LAN966_FLEXCOM3
> +                bool "Kernel low-level debugging on LAN966 FLEXCOM3 
> USART"
> +                select DEBUG_AT91_UART
> +                depends on SOC_LAN966
> +                help
> +                  Say Y here if you want kernel low-level debugging 
> support
> +                  on the FLEXCOM3 port of LAN966.
> +
>  	config DEBUG_BCM2835
>  		bool "Kernel low-level debugging on BCM2835 PL011 UART"
>  		depends on ARCH_BCM2835 && ARCH_MULTI_V6
> @@ -1685,6 +1693,7 @@ config DEBUG_UART_PHYS
>  	default 0xd4017000 if DEBUG_MMP_UART2
>  	default 0xd4018000 if DEBUG_MMP_UART3
>  	default 0xe0000000 if DEBUG_SPEAR13XX
> +	default 0xe0064200 if DEBUG_AT91_LAN966_FLEXCOM3
>  	default 0xe1824200 if DEBUG_AT91_SAMA7G5_FLEXCOM3
>  	default 0xe4007000 if DEBUG_HIP04_UART
>  	default 0xe6c40000 if DEBUG_RMOBILE_SCIFA0
> @@ -1805,6 +1814,7 @@ config DEBUG_UART_VIRT
>  	default 0xfb10c000 if DEBUG_REALVIEW_PB1176_PORT
>  	default 0xfcfe8600 if DEBUG_BCM63XX_UART
>  	default 0xfd000000 if DEBUG_SPEAR3XX || DEBUG_SPEAR13XX
> +	default 0xfd064200 if DEBUG_AT91_LAN966_FLEXCOM3
>  	default 0xfd531000 if DEBUG_STIH41X_SBC_ASC1
>  	default 0xfd883000 if DEBUG_ALPINE_UART0
>  	default 0xfdd32000 if DEBUG_STIH41X_ASC2
