Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C628BC19F2B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Aug 2022 23:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237176AbiHCXYX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Aug 2022 19:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiHCXYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 19:24:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C982A26E;
        Wed,  3 Aug 2022 16:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lwdtG5cbgHNE/CBHpeDuSqLFIV6AyUtItmc8ZeyGFlM=; b=Ya7xFTxbK6r+uGUC6Rjdu9GQ5B
        9wzhHRLSxTrELII3GwwAL95/Ko1EAIljH6Gwfywa/g23C9+fiWUlLhUnAWKbjAIyKIeZZAxmgQC9g
        zmsjaGkzWeZcWv5+kcwDj64zi3TQ5K9Z0oFLFZyXYKUNUQRl2u/UH1B3w5PfguOak3o+sE5ESLCga
        8HvRtvlP/qDJ3lSGLD30oNR9rgJxb2NWv8nhjq8e1GEditggldW0u4U9NBumQ1n3C2Sl6qx+PUpJG
        Ndx5rmM2JFpwgI6uDnFr4dw/CV6m7HKQ9AXhqfTbvTI+agrOgy1IsJ8raRGGd/XVEKL6EJQH+Ar63
        Jft4aoLA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oJNii-009jts-BQ; Wed, 03 Aug 2022 23:24:08 +0000
Date:   Thu, 4 Aug 2022 00:24:08 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] vfs.git pile 3 - dcache
Message-ID: <YusDmF39ykDmfSkF@casper.infradead.org>
References: <YurA3aSb4GRr4wlW@ZenIV>
 <CAHk-=wizUgMbZKnOjvyeZT5E+WZM0sV+zS5Qxt84wp=BsRk3eQ@mail.gmail.com>
 <YuruqoGHJONpdZcK@home.goodmis.org>
 <CAHk-=whJvgykcTnR+BMJNwd+me5wvg+CxjSBeiPYTR1B2g5NpQ@mail.gmail.com>
 <20220803185936.228dc690@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803185936.228dc690@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 06:59:36PM -0400, Steven Rostedt wrote:
> On Wed, 3 Aug 2022 15:09:23 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > Admittedly I think "preempt_enable_under_spinlock()" may be a bit
> > *too* cumbersome as a name. It does explain what is going on - and
> > both the implementation and the use end up being fairly clear (and the
> > non-RT case could have some debug version that actually tests that
> > preemption has already been disabled).
> 
> 	preempt_disable_inlock() ?

preempt_disable_locked()?
