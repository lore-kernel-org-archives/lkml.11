Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8E8C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 May 2022 09:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245295AbiEaJeW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 May 2022 05:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245265AbiEaJeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 05:34:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639833B005
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 02:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SosMEuQLJHa6yl3EWnL8tq525aHQk8nZEUVLjVgkZk4=; b=lVTGJD7uqZ0iJW0C4sgpzQY15G
        eJDpMDXrgdEt1IotKyOMLCvIKmVToA5OFbb9ADLxXJEBIge2udhyJrqSSSnVDdWKr+C4V1TNzXIAD
        y2UAxrnqyud99kVgxE77305MIVPpq+qrPJdncl+MzDTzT6vyXOHlucSh9KMkizcnwnLhT5qxSPVks
        AtzedNOX8VgD9BPViqY01Y61hACsCeOUVEd2/kxjZ0crYLO1ap1S61rXsaW7/4aI7RhD+Wl+c0H48
        h1Ndr+LAllvmTxtn0KYB4w768eTdc7WcvBxH5VnOnqL3X2Nn/cH0rdi/tB0Xhz2K7dHgd4HFKejvW
        Ef9KvfTA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvyGH-003LT1-Jg; Tue, 31 May 2022 09:34:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6D9333002AE;
        Tue, 31 May 2022 11:33:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3D21220775F47; Tue, 31 May 2022 11:33:59 +0200 (CEST)
Date:   Tue, 31 May 2022 11:33:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc:     frederic@kernel.org, paulmck@kernel.org, rjw@rjwysocki.net,
        x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@kernel.org
Subject: Re: [RFC][PATCH 4/9] idle: Fix rcu_idle_*() usage
Message-ID: <YpXhB4yjdNKOe6Np@hirez.programming.kicks-ass.net>
References: <20220519212750.656413111@infradead.org>
 <20220519213421.808983977@infradead.org>
 <YotX4ywdUPJt0lNW@BLR-5CG11610CF.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YotX4ywdUPJt0lNW@BLR-5CG11610CF.amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 03:16:11PM +0530, Gautham R. Shenoy wrote:
> On Thu, May 19, 2022 at 11:27:54PM +0200, Peter Zijlstra wrote:
> > The whole disable-RCU, enable-IRQS dance is very intricate since
> > changing IRQ state is traced, which depends on RCU.
> > 
> > Add two helpers for the cpuidle case that mirror the entry code.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> 
> [...]
> >  
> > --- a/drivers/cpuidle/cpuidle.c
> > +++ b/drivers/cpuidle/cpuidle.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/mutex.h>
> >  #include <linux/sched.h>
> >  #include <linux/sched/clock.h>
> > +#include <linux/sched/idle.h>
> >  #include <linux/notifier.h>
> >  #include <linux/pm_qos.h>
> >  #include <linux/cpu.h>
> > @@ -150,12 +151,12 @@ static void enter_s2idle_proper(struct c
> >  	 */
> >  	stop_critical_timings();
> >  	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
> > -		rcu_idle_enter();
> > +		cpuidle_rcu_enter();
> >  	target_state->enter_s2idle(dev, drv, index);
> >  	if (WARN_ON_ONCE(!irqs_disabled()))
> > -		local_irq_disable();
> > +		raw_local_irq_disable();
> >  	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
> > -		rcu_idle_exit();
> > +		cpuidle_rcu_enter();
> 
> Shouldn't this be cpuidle_rcu_exit() ?

Yes, very much so... soon I should buy a new supply of brown paper bags
:-)
