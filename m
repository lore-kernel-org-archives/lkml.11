Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226D9C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jun 2022 14:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239802AbiFFOeO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jun 2022 10:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239732AbiFFOeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:34:12 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDC42D1FE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:34:10 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:34356)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nyDo0-00D2LX-5K; Mon, 06 Jun 2022 08:34:08 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:60040 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nyDny-007IX0-Uu; Mon, 06 Jun 2022 08:34:07 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Hao Wu <guoyuanchao1202@gmail.com>
Cc:     brauner@kernel.org, keescook@chromium.org, axboe@kernel.dk,
        peterz@infradead.org, elver@google.com, tglx@linutronix.de,
        legion@kernel.org, linux-kernel@vger.kernel.org
References: <20220223133540.24230-1-guoyuanchao1202@gmail.com>
Date:   Mon, 06 Jun 2022 09:33:17 -0500
In-Reply-To: <20220223133540.24230-1-guoyuanchao1202@gmail.com> (Hao Wu's
        message of "Wed, 23 Feb 2022 21:35:40 +0800")
Message-ID: <878rq96evm.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nyDny-007IX0-Uu;;;mid=<878rq96evm.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/tCTIH6sFgbMpYmO8+BYSCq+lVTT7M1/Q=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v1] signal.c: repeatedly set the TIF_SIGPENDING flag
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hao Wu <guoyuanchao1202@gmail.com> writes:

> The recalc_sigpending_and_wake() function calls recalc_sigpending_tsk() and signal_wake_up(),
> both of which set the TIF_SIGPENDING flag, so when recalc_sigpending_tsk() returns true,
> the TIF_SIGPENDING flag will be set twice.
>
> Maybe we can take away the set TIF_SIGPENDING logic from recalc_sigpending_tsk(),
> so that recalc_sigpending_tsk() just determines whether the TIF_SIGPENDING flag needs to be set,
> and the actual set TIF_SIGPENDING flag logic is executed outside.
>
> kernel/signal.c:175: recalc_sigpending_and_wake()
> kernel/signal.c:154: recalc_sigpending_tsk()

I just saw this.

I agree that it is unfortunate that recalc_sigpending_and_wake sets
TIF_SIGPENDING twice.

Looking at the code only force_sig_info_to_task calls
recalc_sigpending_and_wake.  I have some work underway that removes the
need to call recalc_sigpending in force_sig_info_to_task so I believe
that will resolve the matter.

Regardless of changes I have planned force_sig_info_to_task appears to
be the proper place to resolve this issue.  It looks like
complete_signal called from __send_signal_locked called from
send_signal_locked called from force_sig_info_to_task calls
signal_wake_up if that is needed at all.  So I believe the issue you are
seeing could be solved be simply replacing recalc_sigpending_and_wake
with recalc_sigpending_tsk.

Some more analysis might reveal and even nicer clean up.  If
sending the signal is always going to call signal_wake_up calling
recalc_sigpending_tsk might not even be necessary.

Good spotting of a rough spot in the code.  I don't think your proposed
change is the way we should go about fixing it.

Eric
>
> Signed-off-by: Hao Wu <guoyuanchao1202@gmail.com>
> ---
>  kernel/signal.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 9b04631acde8..6c5a00cd7e9a 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -157,7 +157,6 @@ static bool recalc_sigpending_tsk(struct task_struct *t)
>  	    PENDING(&t->pending, &t->blocked) ||
>  	    PENDING(&t->signal->shared_pending, &t->blocked) ||
>  	    cgroup_task_frozen(t)) {
> -		set_tsk_thread_flag(t, TIF_SIGPENDING);
>  		return true;
>  	}
> @@ -181,8 +180,11 @@ void recalc_sigpending_and_wake(struct task_struct *t)
>  void recalc_sigpending(void)
>  {
> -	if (!recalc_sigpending_tsk(current) && !freezing(current))
> +	if (recalc_sigpending_tsk(current)) {
> +		set_tsk_thread_flag(t, TIF_SIGPENDING);
> +	} else if (!freezing(current)) {
>  		clear_thread_flag(TIF_SIGPENDING);
> +	}
>  }
>  EXPORT_SYMBOL(recalc_sigpending);
> @@ -2325,7 +2327,9 @@ static void ptrace_stop(int exit_code, int why, int clear_code, kernel_siginfo_t
>  	 * So check for any that we should take before resuming user mode.
>  	 * This sets TIF_SIGPENDING, but never clears it.
>  	 */
> -	recalc_sigpending_tsk(current);
> +	if (recalc_sigpending_tsk(current)) {
> +		set_tsk_thread_flag(t, TIF_SIGPENDING);
> +	}
>  }
>  static void ptrace_do_notify(int signr, int exit_code, int why)
> 2.32.0
