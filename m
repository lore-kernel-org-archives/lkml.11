Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDF5C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Jul 2022 19:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239860AbiGHTlS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Jul 2022 15:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238577AbiGHTlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:41:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0700514D14
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 12:41:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 960B0627B6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 19:41:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1EA4C341C0;
        Fri,  8 Jul 2022 19:41:12 +0000 (UTC)
Date:   Fri, 8 Jul 2022 15:41:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Schspa Shi <schspa@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched/rt: fix bad task migration for rt tasks
Message-ID: <20220708154111.36e662b2@gandalf.local.home>
In-Reply-To: <m28rp3pfhz.fsf@gmail.com>
References: <20220707165014.77127-1-schspa@gmail.com>
        <20220707135329.08cf74b0@gandalf.local.home>
        <m2h73snqja.fsf@gmail.com>
        <20220708140000.6aa75a50@gandalf.local.home>
        <m2ilo779f9.fsf@gmail.com>
        <20220708150614.2cda886d@gandalf.local.home>
        <m28rp3pfhz.fsf@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 09 Jul 2022 03:14:44 +0800
Schspa Shi <schspa@gmail.com> wrote:

> Steven Rostedt <rostedt@goodmis.org> writes:
> 
> > On Sat, 09 Jul 2022 02:19:42 +0800
> > Schspa Shi <schspa@gmail.com> wrote:
> >  
> >> Yes, it's what I did in the V1 patch.
> >> Link: https://lore.kernel.org/all/20220623182932.58589-1-schspa@gmail.com/
> >> 
> >> But I think it's not the best solution for this problem.
> >> In these scenarios, we still have a chance to make the task run faster
> >> by retrying to retry to push the currently running task on this CPU away.
> >> 
> >> There is more details on V2 patch's replay message.
> >> Link: https://lore.kernel.org/all/CAMA88TrZ-o4W81Yfw9Wcs3ghoxwpeAKtFejtMTt78GNB0tKaSA@mail.gmail.com/#t  
> >
> > The thing is, this situation can only happen if we release the rq lock in
> > find_lock_lowest_rq(), and we should not be checking for it in the other
> > cases.
> >  
> 
> If we haven't unlock the rq in find_lock_lowest_rq(), it will return
> NULL. It won't call this code added.
> 
> 	if (unlikely(is_migration_disabled(next_task))) {
> 		put_task_struct(next_task);
> 		goto retry;
> 	}

Because it doesn't need to. If it did not unlock the run queue, there's no
way that next_task could have run, because we hold the rq lock for
next_task. Which means that its "migrate_disable" state would not have
changed from the first time we checked.

> 
> 	deactivate_task(rq, next_task, 0);
> 	set_task_cpu(next_task, lowest_rq->cpu);
> 
> Beside, find_lock_lowest_rq() return NULL doesn't means rq is rleased,
> We need to add a _find_lock_lowest_rq to get the correct rq released
> flags?

It it returns NULL it either means that the rq lock was released or that it
did not find a rq to push to. Which means there's nothing more to do anyway.

> 
> > Perhaps add the check in find_lock_lowest_rq() and also in the !lowest_rq
> > case do:
> >
> > 		task = pick_next_pushable_task(rq);
> > 		if (task == next_task) {
> > +			/*
> > +			 * If next task has now disabled migrating, see if we
> > +			 * can push the current task.
> > +			 */
> > +			if (unlikely(is_migrate_disabled(task)))
> > +				goto retry;  
> 
> Ahh, It can be added, And do we need this to be a separate PATCH?

Sure.

The "fix" to the crash you see should be in the find_lock_lowest_rq() as I
suggested. And then you can add this as an optimization.

-- Steve

> 
> > 			/*
> > 			 * The task hasn't migrated, and is still the next
> > 			 * eligible task, but we failed to find a run-queue
> > 			 * to push it to.  Do not retry in this case, since
> > 			 * other CPUs will pull from us when ready.
> > 			 */
> > 			goto out;
> > 		}
> >
> > -- Steve  
> 

