Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FD5C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 May 2022 14:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345296AbiEaOqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 May 2022 10:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345293AbiEaOqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 10:46:37 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981E813DC8
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 07:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X6kKnKntQ48Tyr/dRBbbaOB1m+G6xIdAgc/SePpDZCE=; b=bF+nbmO2AghBOU4v5iM7m7giuM
        67Rrbjj1c8TlmEN6cMc8sNRy3RSTrMl0oYo6/DuFhCjql75uyiA8S3Y0BQsD2tKsUTQ6zrrAFe6Ap
        wMBU+ch126RCEkb5iec4X+WFqjMI0DH7yQr/z0FPNWcZAhTEt1TKONEInOQoizM7g4tmpKt6uaYkG
        6b51SY+Ph+y2IXdqO6Yy55mjpDJThlsymlFHOLDsrJ+Txgerj+b4qRaEzRb+VLefm/25akuGBGwjz
        gnL0t8W8khFcFErJZvO9gjgyX3y2lsNn194sf0uvaXjTZk3fv5sEQ7Hg0zIIAVILAAF+StWSG4sGN
        LB8mwAig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nw38T-003TgV-SB; Tue, 31 May 2022 14:46:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8E34D3006C5;
        Tue, 31 May 2022 16:46:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6BD9C2096428F; Tue, 31 May 2022 16:46:16 +0200 (CEST)
Date:   Tue, 31 May 2022 16:46:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ming Wang <wangming01@loongson.cn>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] sched: there is no need to call switch_mm_irqs_off
 when sched between two user thread.
Message-ID: <YpYqOC9Wx84oC2z5@hirez.programming.kicks-ass.net>
References: <1653998201-10230-1-git-send-email-wangming01@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1653998201-10230-1-git-send-email-wangming01@loongson.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 07:56:41PM +0800, Ming Wang wrote:
> When condition (prev->active_mm == next->mm && !prev->mm) is met,
> the situation is as follows:
> 
> user thread -> user thread
> 
> There is not need switch_mm when sched between two user thread.
> Because they share the mm_struct. This can provide better
> performance when testing UnixBench.
> 
> Signed-off-by: Ming Wang <wangming01@loongson.cn>
> ---
>  kernel/sched/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 696c649..9d7f6fb 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5099,7 +5099,8 @@ asmlinkage __visible void schedule_tail(struct task_struct *prev)
>  		 * case 'prev->active_mm == next->mm' through
>  		 * finish_task_switch()'s mmdrop().
>  		 */
> -		switch_mm_irqs_off(prev->active_mm, next->mm, next);
> +		if ((prev->active_mm != next->mm) || (!prev->mm))
> +			switch_mm_irqs_off(prev->active_mm, next->mm, next);

I think this needs to be inside switch_mm(). Architectures are free to
play silly games with what the current active mm is (and iirc x86
actually does this).
