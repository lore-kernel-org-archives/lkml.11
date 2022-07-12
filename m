Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C0DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jul 2022 00:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiGLAx0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jul 2022 20:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiGLAxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:53:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE57627CC9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:53:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DF76B81600
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE8DC34115;
        Tue, 12 Jul 2022 00:53:20 +0000 (UTC)
Date:   Mon, 11 Jul 2022 20:53:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Marco Elver <elver@google.com>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Johannes Berg <johannes.berg@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH -printk] printk, tracing: fix console tracepoint
Message-ID: <20220711205319.1aa0d875@gandalf.local.home>
In-Reply-To: <20220712002128.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
References: <20220503073844.4148944-1-elver@google.com>
        <20220711182918.338f000f@gandalf.local.home>
        <20220712002128.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2022 17:21:28 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On x86, both srcu_read_lock() and srcu_read_unlock() should be OK from
> NMI context, give or take their use of lockdep.  Which is why we have
> srcu_read_lock_notrace() and srcu_read_unlock_notrace(), which do not
> use lockdep.  Which __DO_TRACE() does in fact invoke.  Ah, but you have
> this: "WARN_ON_ONCE(rcuidle && in_nmi())".
> 
> Because all the world is not an x86.

But since NMIs are architecture specific, we could change that to:

	WARN_ON_ONCE(!srcu_nmi_safe && rcuidle && in_nmi());

and add a srcu_nmi_safe constant or macro that is 1 on architectures that
srcu is safe in NMI and 0 otherwise.

Or do we care if a tracepoint happens in those architectures where it is
not safe. We could then just do:

	if (!srcu_nmi_safe && rcuidle && in_nmi())
		return;

and just skip tracepoints that are marked rcu_idle and happen within NMI.

-- Steve
