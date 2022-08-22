Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82C7C28D13
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Aug 2022 22:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbiHVWic (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Aug 2022 18:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238484AbiHVWiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 18:38:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C93C63BB
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 15:38:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D72EEB818FB
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 22:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7613C433D6;
        Mon, 22 Aug 2022 22:38:19 +0000 (UTC)
Date:   Mon, 22 Aug 2022 18:38:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [BUG v6.0-rc2] lockdep splat on ct_kernel_enter()
Message-ID: <20220822183836.6b80976f@gandalf.local.home>
In-Reply-To: <20220822182850.32f91017@gandalf.local.home>
References: <20220822164404.57952727@gandalf.local.home>
        <20220822182850.32f91017@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2022 18:28:50 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 22 Aug 2022 16:44:04 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Looks like lockdep and the trace_rcu_dyntick() code is getting out of sync
> > with respect to whether or not interrupts are enabled.  
> 
> This is caused by this commit:
> 
> 172114552701 ("rcu/context-tracking: Move RCU-dynticks internal functions
> to context_tracking")
> 
> The warning happens with the commit, and does not for the commit just
> before it is applied.
> 

Nevermind, I tested the wrong kernel (the grub reboot failed to boot to the
new kernel). But it did give me a different lockdep splat when I tested the
right kernel :-/

I'll investigate some more.

-- Steve
