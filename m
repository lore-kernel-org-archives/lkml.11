Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A0CC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Apr 2022 01:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbiDHBiy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Apr 2022 21:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbiDHBiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 21:38:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C8610FAE8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 18:36:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20D0AB829B5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 01:36:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873DCC385A0;
        Fri,  8 Apr 2022 01:36:46 +0000 (UTC)
Date:   Thu, 7 Apr 2022 21:36:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, jstultz@google.com,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [RFC][PATCH] timers: Add del_time_free() to be called before
 freeing timers
Message-ID: <20220407213644.767ae1c7@gandalf.local.home>
In-Reply-To: <63d4c8d8-89c6-33ed-8178-be9ea86e53b9@roeck-us.net>
References: <20220407161745.7d6754b3@gandalf.local.home>
        <20220407215802.GB186606@roeck-us.net>
        <20220407185144.5ac036b7@gandalf.local.home>
        <63d4c8d8-89c6-33ed-8178-be9ea86e53b9@roeck-us.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Apr 2022 17:58:09 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> >>> Add a del_timer_free() that not only does a del_timer_sync() but will mark  
> >>
> >> This limits the use case to situations where del_timer_sync() can actually
> >> be called. There is, however, code where this is not possible.
> >> Specifically, it doesn't work if the code triggered with the timer uses a
> >> lock, and del_timer() is also called under that same lock. An example for
> >> that is the code in sound/synth/emux/emux.c. How do you suggest to handle
> >> that situation ?  
> > 
> > Easy. Tell me how that situation is not a bug?
> >   
> 
> Sure, fixing the problem is of course the right thing to do. But replacing
> del_timer() with your suggested version of del_timer_free() doesn't work

I meant replacing the entire block with del_timer_free().

diff --git a/sound/synth/emux/emux.c b/sound/synth/emux/emux.c
index 5ed8e36d2e04..f631e090e074 100644
--- a/sound/synth/emux/emux.c
+++ b/sound/synth/emux/emux.c
@@ -131,10 +131,7 @@ int snd_emux_free(struct snd_emux *emu)
 	if (! emu)
 		return -EINVAL;
 
-	spin_lock_irqsave(&emu->voice_lock, flags);
-	if (emu->timer_active)
-		del_timer(&emu->tlist);
-	spin_unlock_irqrestore(&emu->voice_lock, flags);
+	del_timer_free(&emu->tlist);
 
 	snd_emux_proc_free(emu);
 	snd_emux_delete_virmidi(emu);

It doesn't hurt to delete it if it wasn't queued. I'm not sure what the
dance with spinlocks are all about.

The above may actually be enough. I don't see where the timer could be
enqueued again after that.

That code goes back to original git history, so it was probably trying to
do it's own del_timer_sync() albeit poorly.

> with this code because it would deadlock. Sure, that would not fix the
> underlying problem anyway, but that isn't the point I was trying to make:
> I think it would be beneficial to be able to replace del_timer() with a
> version that can not result in deadlocks but would still identify problems
> such as the one in the code in emux.c.
> 
> Can we have del_timer_free() and del_timer_sync_free() ? Or am I missing
> something and that doesn't really make sense ?

No, that doesn't make sense.

-- Steve
