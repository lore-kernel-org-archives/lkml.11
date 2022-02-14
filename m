Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762D8C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 18:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357337AbiBNSAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 13:00:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357325AbiBNSAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 13:00:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3762160DBF;
        Mon, 14 Feb 2022 10:00:30 -0800 (PST)
Date:   Mon, 14 Feb 2022 19:00:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644861628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ak1sKXz8pqU5OXOTa42NjAvCBxTswiY6RDJ/LZK1LYo=;
        b=IkWRLBdSRZj83mEOuD+098n0EuZsx/eavbjdr7gD7itzpWuyFy+ZXINbIFdLB6qJIgfvy8
        p+/vLnXLLJtUSPYETWvWAhUDYRONrPwqwZiW0cWImcagv5IFo0JV1EXKB9VhPpuctsMWij
        iwvRW4evO/jVY0Btm+rEsVsUOmPoFJ6ZAnrJBYn6t91baAJ+ujS+74kW5PN3PteLzuF0LJ
        CgFcgnT5lHoRcq1oyKEwtmagIraZs6xrKZA+OEM/wXTGM0KuuDYp1y0cIXWaY3GJWCwCSX
        xq+Y456QSgcwye2zxWHe2A8k0s3/NB+gSaOt4XQuMUdlQ8BWF+N/wfZ+n35EGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644861628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ak1sKXz8pqU5OXOTa42NjAvCBxTswiY6RDJ/LZK1LYo=;
        b=YOlChkc5IdQ9d+u21n+PvI+cZ9v++88raxyykO07BA6aOs1XV7nkn6VHvDSCMtGKeq3HU6
        rUvmFqmchHoa4GAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 3/8] kernel/fork, IA64: Provide a
 alloc_thread_stack_node() for IA64.
Message-ID: <YgqYun8tmIJQZmuN@linutronix.de>
References: <20220125152652.1963111-1-bigeasy@linutronix.de>
 <20220125152652.1963111-4-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220125152652.1963111-4-bigeasy@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-25 16:26:47 [+0100], To linux-kernel@vger.kernel.org wrote:
> diff --git a/kernel/fork.c b/kernel/fork.c
> index c47dcba5d66d2..a0d58ae6fac76 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -330,6 +330,22 @@ void thread_stack_cache_init(void)
=E2=80=A6
> =20
> +static void free_thread_stack(struct task_struct *tsk, bool cache_only)

This cache_only parameter shouldn't be here=E2=80=A6

> +{
> +	arch_free_thread_stack(tsk);
> +}
> +
>  #endif /* !CONFIG_ARCH_THREAD_STACK_ALLOCATOR */
> =20
>  /* SLAB cache for signal_struct structures (tsk->signal) */

Sebastian
