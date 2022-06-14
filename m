Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9753C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jun 2022 04:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbiFNEi5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jun 2022 00:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiFNEix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 00:38:53 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCE02E9F1;
        Mon, 13 Jun 2022 21:38:52 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:33452)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o0yKD-009rqF-7K; Mon, 13 Jun 2022 22:38:45 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:40370 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o0yKC-008XSK-1u; Mon, 13 Jun 2022 22:38:44 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Seth Forshee <sforshee@digitalocean.com>,
        Petr Mladek <pmladek@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org
References: <20220614021116.1101331-1-sashal@kernel.org>
        <20220614021116.1101331-5-sashal@kernel.org>
Date:   Mon, 13 Jun 2022 23:38:37 -0500
In-Reply-To: <20220614021116.1101331-5-sashal@kernel.org> (Sasha Levin's
        message of "Mon, 13 Jun 2022 22:11:14 -0400")
Message-ID: <87edzrzwoi.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1o0yKC-008XSK-1u;;;mid=<87edzrzwoi.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19hJcz2jzzt3lJfRIeFyelpahjNOpDMtP0=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH MANUALSEL 5.18 5/6] entry/kvm: Exit to user mode when
 TIF_NOTIFY_SIGNAL is set
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Starting with v5.18 TIF_NOTIFY_SIGNAL and task_work_run are separated,
so backporting this to v5.18 looks safe.

For anyone considering backporting this any farther please be aware
that TIF_NOTIFY_SIGNAL and task_work were all mixed together and
to backport this also likely requires backporting my cleanups that
separated them.

Eric


Sasha Levin <sashal@kernel.org> writes:

> From: Seth Forshee <sforshee@digitalocean.com>
>
> [ Upstream commit 3e684903a8574ffc9475fdf13c4780a7adb506ad ]
>
> A livepatch transition may stall indefinitely when a kvm vCPU is heavily
> loaded. To the host, the vCPU task is a user thread which is spending a
> very long time in the ioctl(KVM_RUN) syscall. During livepatch
> transition, set_notify_signal() will be called on such tasks to
> interrupt the syscall so that the task can be transitioned. This
> interrupts guest execution, but when xfer_to_guest_mode_work() sees that
> TIF_NOTIFY_SIGNAL is set but not TIF_SIGPENDING it concludes that an
> exit to user mode is unnecessary, and guest execution is resumed without
> transitioning the task for the livepatch.
>
> This handling of TIF_NOTIFY_SIGNAL is incorrect, as set_notify_signal()
> is expected to break tasks out of interruptible kernel loops and cause
> them to return to userspace. Change xfer_to_guest_mode_work() to handle
> TIF_NOTIFY_SIGNAL the same as TIF_SIGPENDING, signaling to the vCPU run
> loop that an exit to userpsace is needed. Any pending task_work will be
> run when get_signal() is called from exit_to_user_mode_loop(), so there
> is no longer any need to run task work from xfer_to_guest_mode_work().
>
> Suggested-by: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Seth Forshee <sforshee@digitalocean.com>
> Message-Id: <20220504180840.2907296-1-sforshee@digitalocean.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  kernel/entry/kvm.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
> index 9d09f489b60e..2e0f75bcb7fd 100644
> --- a/kernel/entry/kvm.c
> +++ b/kernel/entry/kvm.c
> @@ -9,12 +9,6 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
>  		int ret;
>  
>  		if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL)) {
> -			clear_notify_signal();
> -			if (task_work_pending(current))
> -				task_work_run();
> -		}
> -
> -		if (ti_work & _TIF_SIGPENDING) {
>  			kvm_handle_signal_exit(vcpu);
>  			return -EINTR;
>  		}
