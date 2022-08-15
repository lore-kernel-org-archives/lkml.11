Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36C0C19F2C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Aug 2022 06:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiHPGFD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Aug 2022 02:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiHPGE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 02:04:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D4615177C
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 16:37:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A805EB8124B
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 23:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2D3C433C1;
        Mon, 15 Aug 2022 23:37:22 +0000 (UTC)
Message-ID: <4ae72d0b-b197-f9d8-5cbe-ce7cfaf3affc@linux-m68k.org>
Date:   Tue, 16 Aug 2022 09:37:19 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] m68k: Complete variable type
Content-Language: en-US
To:     Xin Gao <gaoxin@cdjrlc.com>, geert@linux-m68k.org
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <20220815194806.3487-1-gaoxin@cdjrlc.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <20220815194806.3487-1-gaoxin@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16/8/22 05:48, Xin Gao wrote:
> Complete the variable type of line 109.
> 
> Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
> ---
>   arch/m68k/coldfire/m520x.c | 2 +-
>   arch/m68k/q40/q40ints.c    | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/m68k/coldfire/m520x.c b/arch/m68k/coldfire/m520x.c
> index d2f96b40aee1..dca89214bbc6 100644
> --- a/arch/m68k/coldfire/m520x.c
> +++ b/arch/m68k/coldfire/m520x.c
> @@ -106,7 +106,7 @@ static struct clk * const disable_clks[] __initconst = {
>   
>   static void __init m520x_clk_init(void)
>   {
> -	unsigned i;
> +	unsigned int i;
>   
>   	/* make sure these clocks are enabled */
>   	for (i = 0; i < ARRAY_SIZE(enable_clks); ++i)
> diff --git a/arch/m68k/q40/q40ints.c b/arch/m68k/q40/q40ints.c
> index 100c05544c6a..fdac8a0cb75f 100644
> --- a/arch/m68k/q40/q40ints.c
> +++ b/arch/m68k/q40/q40ints.c
> @@ -169,7 +169,7 @@ void q40_sched_init (void)
>    *
>   */
>   
> -struct IRQ_TABLE{ unsigned int mask; int irq ;};
> +struct IRQ_TABLE{ unsigned int mask; int irq };
>   #if 0
>   static struct IRQ_TABLE iirqs[]={
>     {Q40_IRQ_FRAME_MASK,Q40_IRQ_FRAME},

This last change doesn't match the commit message.
It should be a separate patch.

Regards
Greg
