Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DD5C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 May 2022 15:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346631AbiEJPmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 May 2022 11:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346052AbiEJPjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:39:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B8BA1FC2E1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652196905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KAUYAL6xtEy1vEbUJu56EBQK32UGZSvLvF0XFVQ8Fq4=;
        b=DoXrFovRS9kJlp57qar/7n7/NRrnGMg2/bzIj2StihSFoUQ02GPK9TbIROgZuoawFWcxmD
        sksl0+XNyanqn2S5teRsGv4ifWBBQNO0VNdel17iUfUkhihD5MqLcldZKLnRHDTu+Ll87c
        RNF6dyyrLuvKaAl2YgLlxDL3XeFZoeE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-0inn2KGNM_GDY5x2WVygpg-1; Tue, 10 May 2022 11:35:03 -0400
X-MC-Unique: 0inn2KGNM_GDY5x2WVygpg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B03B6811E75;
        Tue, 10 May 2022 15:34:59 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.98])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8B237403579A;
        Tue, 10 May 2022 15:34:54 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 10 May 2022 17:34:59 +0200 (CEST)
Date:   Tue, 10 May 2022 17:34:53 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org
Subject: Re: [PATCH v4 10/12] ptrace: Don't change __state
Message-ID: <20220510153452.GA23707@redhat.com>
References: <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
 <20220505182645.497868-10-ebiederm@xmission.com>
 <20220510142202.GB23277@redhat.com>
 <87ee11wh6b.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ee11wh6b.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10, Eric W. Biederman wrote:
>
> > But I still think that a lockless
> >
> > 	if (!(task->jobctl & JOBCTL_PTRACE_FROZEN))
> > 		return;
> >
> > check at the start of ptrace_unfreeze_traced() makes sense to avoid
> > lock_task_sighand() if possible.
> >
> > And ptrace_resume() can probably clear JOBCTL_PTRACE_FROZEN along with
> > JOBCTL_TRACED to make this optimization work better. The same for
> > ptrace_signal_wake_up().
>
> What do you have that suggests that taking siglock there is a problem?

Not necessarily a problem, but this optimization is free. If the tracee
was resumed, it can compete for siglock with debugger.

> What you propose will definitely work as an incremental change, and
> in an incremental change we can explain why doing the stupid simple
> thing is not good enough.

OK.

Oleg.

