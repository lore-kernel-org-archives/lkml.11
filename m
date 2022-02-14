Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE651C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 12:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352546AbiBNMKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 07:10:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352513AbiBNMKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:10:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802DF488A6;
        Mon, 14 Feb 2022 04:10:07 -0800 (PST)
Date:   Mon, 14 Feb 2022 13:10:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644840606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mt7wJpAsAIRJkJiUtfz6iDEvlyZS12IUFiy0vGsBbbM=;
        b=PgCa+r5f00RLSepFqM6kFuHawUvdhzJXuXMpCFmBQaMyX3kn6C9/j2nJ9IgoP6Cqs6jHkw
        hUAOuJKpcm9cgTO1CAPD3w9dWvJ+GXkIpqmiMsCj8HeS9Gyn7XfWj6Z/LfCtykiE97nbX5
        szK8EHh3xtnI+GHmlY8QMdd4cljvGfCMz1FDtPOyfIrNjYy7epbLI/kyyFQ9VBAl35m8Li
        eaTG3xR7oXcLowV7n9dPISVgJAcwhznrpTUdHbMIQIBoX0tDjOeyTDogRdLDxNNom53kWy
        PO44n4/DJt9zqj18dZGTCixSz4xFWHlaJvUJs6ERkKMnEUVgmzpeJSkyweg3EQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644840606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mt7wJpAsAIRJkJiUtfz6iDEvlyZS12IUFiy0vGsBbbM=;
        b=ztnl36zs+oA0Brb4MTzPXkb1IQXqcaoib7rr+IzN1L6X/j4tFmJGVWl43/LviLMtPslpx/
        spJW8mOwy/VHLEBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 7/8] kernel/fork: Only cache the VMAP stack in
 finish_task_switch().
Message-ID: <YgpGnFlTS+2Ugfw4@linutronix.de>
References: <20220125152652.1963111-1-bigeasy@linutronix.de>
 <20220125152652.1963111-8-bigeasy@linutronix.de>
 <00f9c7a6-2d1d-f871-e9bc-00e2217f40f9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00f9c7a6-2d1d-f871-e9bc-00e2217f40f9@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-11 15:55:01 [-0800], Andy Lutomirski wrote:
> > Set the lowest bit of task_struct::stack if the stack was released via
> > put_task_stack_sched() and needs a final free in
> > delayed_put_task_struct(). If the bit is missing then a reference is
> > held and put_task_stack() will release it.
> 
> I don't understand what this bit is for or why the logic needs to be this
> complicated.  Can you set ->stack to NULL if and only if you freed it early?

What do I do if put_task_stack() is invoked from finish_task_switch()
and I can't free but have to do something?

> > +static void free_thread_stack(struct task_struct *tsk, bool cache_only)
> 
> This is messy.  Please clean it up for real:
> 
> static bool try_release_thread_stack_to_cache(struct vm_struct *vm)
> {
>   for (...) try to put it in this slot;
> }
> 
> And the callers can do things like:
> 
> if (try_release_thread_stack_to_cache(...))
>   return;
> 
> /* need to free for real */
> free it or delayed-free it.

I think I could use the first few bytes of the stack as a RCU-head. Let
me try that.

> --Andy

Sebastian
