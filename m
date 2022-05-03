Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931AEC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 May 2022 23:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244182AbiECXUM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 May 2022 19:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244162AbiECXUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 19:20:08 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698AE1D0F2
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 16:16:32 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nm1kp-0004W4-AH; Wed, 04 May 2022 01:16:27 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greentime Hu <greentime.hu@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH] riscv: Fix irq_work when SMP is disabled
Date:   Wed, 04 May 2022 01:16:26 +0200
Message-ID: <11970543.O9o76ZdvQC@phil>
In-Reply-To: <20220430030025.58405-1-samuel@sholland.org>
References: <20220430030025.58405-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 30. April 2022, 05:00:23 CEST schrieb Samuel Holland:
> irq_work is triggered via an IPI, but the IPI infrastructure is not
> included in uniprocessor kernels. As a result, irq_work never runs.
> Fall back to the tick-based irq_work implementation on uniprocessor
> configurations.
> 
> Fixes: 298447928bb1 ("riscv: Support irq_work via self IPIs")
> Signed-off-by: Samuel Holland <samuel@sholland.org>

That uniprocessor part seems a tiny bit neglected - as I saw previously
with alternatives not getting applied as well, so

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Though somehow I find the arm32 style a tad nicer by defining
an is_smp() function [0] that holds the necessary checks.

But I guess that is a style preference.


Heiko


[0] https://elixir.bootlin.com/linux/latest/source/arch/arm/include/asm/smp_plat.h#L18
> ---
> This was found while bringing up cpufreq on D1. Switching cpufreq
> governors was hanging on irq_work_sync().
> 
>  arch/riscv/include/asm/irq_work.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/irq_work.h b/arch/riscv/include/asm/irq_work.h
> index d6c277992f76..b53891964ae0 100644
> --- a/arch/riscv/include/asm/irq_work.h
> +++ b/arch/riscv/include/asm/irq_work.h
> @@ -4,7 +4,7 @@
>  
>  static inline bool arch_irq_work_has_interrupt(void)
>  {
> -	return true;
> +	return IS_ENABLED(CONFIG_SMP);
>  }
>  extern void arch_irq_work_raise(void);
>  #endif /* _ASM_RISCV_IRQ_WORK_H */
> 




