Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF1AC43334
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jul 2022 08:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbiGVIDl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jul 2022 04:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiGVIDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:03:38 -0400
X-Greylist: delayed 137 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Jul 2022 01:03:36 PDT
Received: from hetzy.fluff.org (test-v6.fluff.org [IPv6:2a01:4f8:222:2004::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5CE9B54D
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 01:03:36 -0700 (PDT)
Received: from ben by hetzy.fluff.org with local (Exim 4.89)
        (envelope-from <ben@fluff.org>)
        id 1oEndF-0004Zo-Lx; Fri, 22 Jul 2022 09:03:33 +0100
Date:   Fri, 22 Jul 2022 09:03:33 +0100
From:   Ben Dooks <ben@fluff.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Ben Dooks <ben-linux@fluff.org>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH] irqchip/mmp: fix missing extern init code
Message-ID: <20220722080333.4ic4n3bmsxs6kyyq@hetzy.fluff.org>
References: <20220721215147.468971-1-ben-linux@fluff.org>
 <87sfmty4ou.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sfmty4ou.wl-maz@kernel.org>
X-Disclaimer: These are my views alone.
X-URL:  http://www.fluff.org/
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ben@fluff.org
X-SA-Exim-Scanned: No (on hetzy.fluff.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 08:41:53AM +0100, Marc Zyngier wrote:
> On Thu, 21 Jul 2022 22:51:47 +0100,
> Ben Dooks <ben-linux@fluff.org> wrote:
> > 
> > The functions icu_init_irq and mmp2_init_icu are exported
> > from this code, so declare them in the header file to avoid
> > the following sparse warnings:

> $ git grep -E "icu_init_irq|mmp2_init_icu"
> arch/arm/mach-mmp/mmp2.c:       mmp2_init_icu();
> arch/arm/mach-mmp/mmp2.h:extern void __init mmp2_init_icu(void);
> arch/arm/mach-mmp/pxa168.c:     icu_init_irq();
> arch/arm/mach-mmp/pxa168.h:extern void __init icu_init_irq(void);
> arch/arm/mach-mmp/pxa910.c:     icu_init_irq();
> arch/arm/mach-mmp/pxa910.h:extern void __init icu_init_irq(void);
> drivers/irqchip/irq-mmp.c:void __init icu_init_irq(void)
> drivers/irqchip/irq-mmp.c:void __init mmp2_init_icu(void)
> 
> If you are going to fix this, please fix it sensibly.

Ok, didn't realise these where not being built my the v7_multi defconfig.
Should this all go into one patch or do the arch/arm bits need to go via
some arm tree?

-- 
Ben Dooks, ben@fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.

