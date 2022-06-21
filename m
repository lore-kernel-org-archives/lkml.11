Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE0DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jun 2022 13:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbiFUNzl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jun 2022 09:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiFUNzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 09:55:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CFF19C21
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 06:55:36 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9172521B85;
        Tue, 21 Jun 2022 13:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655819735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jvGgI6qCVd6nlUI3/RoXRoqsqujRz6BUFTJMj0MjmhI=;
        b=r4Wu8QcEySvMWz98zXQz+qyxxZmzO+/xkN6D9pFl+3V1b6D9PqbKu5tnaNmyfG9V0HrjDF
        4MGKVXGMeW7eufqan2/OCvazAZSqaWs8NSrmYzhi6BP2R+tV7fFCciOkhcSAiF9K3FOSQm
        g3JaGToFgTfeoJN8iA9kqsRiBz78N88=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F1C572C141;
        Tue, 21 Jun 2022 13:55:33 +0000 (UTC)
Date:   Tue, 21 Jun 2022 15:55:33 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Daniel Palmer <daniel@0x0f.com>,
        John Ogness <john.ogness@linutronix.de>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] printk/console: Enable console kthreads only when
 there is no boot console left
Message-ID: <20220621135533.GF7891@pathway.suse.cz>
References: <20220621090900.GB7891@pathway.suse.cz>
 <CAFr9PXkKCf-JRcv+bk17HcC8-4kRG=J9bnNtp_nsMqzg4f=epw@mail.gmail.com>
 <CAHk-=wg9dB5Fc7skWTEOHNohgf=p3oLdL4H_FW-7GyunnQ5Edg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg9dB5Fc7skWTEOHNohgf=p3oLdL4H_FW-7GyunnQ5Edg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-06-21 07:45:09, Linus Torvalds wrote:
> On Tue, Jun 21, 2022 at 6:42 AM Daniel Palmer <daniel@0x0f.com> wrote:
> >
> > The lockups on boot seem to be gone on my boards with this patch.
> 
> Good.
> 
> Petr, was this all the reports sorted out? Sounds like we can keep the
> kernel thread model.

Yes, it seems that we fixed all the reports when boot failed or
the console was messed or silent.

There is one more issue, see
https://lore.kernel.org/r/YqyANveL50uxupfQ@zx2c4.com
It is about synchronization between messages printed by
userspace and kernel consoles.

The synchronization was never guaranteed. I think that it is
not an argument to remove the kthreads. They are really
needed, especially for huge systems, noisy debugging,
or RT where softlockups really hurts.

My opinion is that we might easily support 3 printk
modes, switched on the command line:

1. Use printk console kthreads when the system is normally
   running. It makes printk() predictable and safe. We do
   our best to switch to the direct mode when the kthreads
   are not reliable, for example, panic, suspend, reboot.

   IMHO, it should be default, especially for production
   systems.


2. Use an atomic console in fully synchronous mode. It is
   inspired by a patch from Peter Zijlstra. It calls
   the (serial) console directly from printk() and
   uses CPU-reentrant lock to serialize the messages
   between CPUs.

   AFAIK, Peter and some others use this approach to
   debug some nasty bugs in the scheduler, NMI,
   early boot when even the legacy code using
   console_lock() is not reliable enough.

   John Ogness is working on the atomic serial console.
   It would allow to integrate this mode a clean
   way.

   It is not usable for production because printk()
   might slow down the entire system.


3. Use the legacy code that tries to call consoles from
   printk() via console_trylock(). We need this code
   anyway for the early boot, suspend, reboot, panic.

   It would be used for debugging nasty bugs like
   the 2nd mode for system without serial console.
   It will be pretty hard to create lockless
   variant for more complicate consoles.


I am not happy that we need more modes. But I think that
they all have a good justification.


Best Regards,
Petr
