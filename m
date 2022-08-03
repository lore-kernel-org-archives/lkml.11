Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926F0C19F28
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Aug 2022 17:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238418AbiHCRmK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Aug 2022 13:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236310AbiHCRmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:42:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2181A51428
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 10:42:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABBC660ED7
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 17:42:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073FEC433D6;
        Wed,  3 Aug 2022 17:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659548527;
        bh=bayv/6/GT5yNhAKgq0B8YxNfUM3w0OUY9Wn4pEC3F3Y=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Eja8LD2N/t24ui/P8RYMGcZzUK87OmVF7F0mvLoud44UWGAts7nsAsu1dyzjtiIqK
         +TY2FfIcLNXzIuyu7lVwy+CZkm/61sFHxtWvGiBpM1jqI0K1ifxj4W9xN0qILB7qj4
         RYTZo9rjXpgJZPyteJkXV8Ymvr+l4elepIxn5eEuoIIi3x9cuO3vlgmMhBWlFdk5+e
         gUlWnk/TxTCqUZ9+JM6lbovjEtzx0+1YCxfvz5Kg0zG450Ozr0sQAXnG9SXbdVuINC
         J20QgBhf2iNGbfyKINXZ9BS+BnpNy/NXlWymaSmqNFuwdDrzlY7XRE82HI2NDZKQw0
         kAwRBduw69NEQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 954575C092A; Wed,  3 Aug 2022 10:42:06 -0700 (PDT)
Date:   Wed, 3 Aug 2022 10:42:06 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Liu Song <liusong@linux.alibaba.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/debug: avoid executing show_state and causing rcu
 stall warning
Message-ID: <20220803174206.GH2125313@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <1659489525-82994-1-git-send-email-liusong@linux.alibaba.com>
 <20220803084235.5d56d1e4@gandalf.local.home>
 <20220803140653.GD2125313@paulmck-ThinkPad-P17-Gen-1>
 <YuqtDA4NY/8Z22aK@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuqtDA4NY/8Z22aK@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 07:14:52PM +0200, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@kernel.org> wrote:
> 
> > There is an rcu_sysrq_start() and rcu_sysrq_end() to suppress this.  
> > These are invoked by __handle_sysrq().  The value of 
> > rcu_cpu_stall_suppress should be non-zero during the sysrq execution, and 
> > this should prevent RCU CPU stall warnings from being printed.
> > 
> > That said, the code currently does not support overlapping calls to the 
> > various functions that suppress RCU CPU stall warnings.  Except that the 
> > only other use in current mainline is rcu_panic(), which never 
> > unsuppresses.
> > 
> > So could you please check the value of rcu_cpu_stall_suppress? Just in 
> > case some other form of suppression was added somewhere that I missed?
> 
> So instead of supressing the (justified!) RCU stall messages, I'd much 
> rather we apply only the minimal locking necessary for this debug printout.
> 
> That should also solve the stall warnings as a side effect.

I am certainly with you in spirit!  If I recall correctly, the issue
that led to the current state was that there was no way to walk the
task list locklessly except under an RCU read-side critical section.
Yes, you can use get_task_struct(), but that only prevents that task
structure from being freed, not from being removed from the list.

Here is hoping that there is a better way to nail down a task while
RCU-pausing a task-list traversal.  Thoughts?

							Thanx, Paul
