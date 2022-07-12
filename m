Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE4FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jul 2022 14:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbiGLOyH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jul 2022 10:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbiGLOyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:54:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5683E248DA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:53:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7C0F61006
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 14:53:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0597C3411C;
        Tue, 12 Jul 2022 14:53:54 +0000 (UTC)
Date:   Tue, 12 Jul 2022 10:53:53 -0400
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
Message-ID: <20220712105353.08358450@gandalf.local.home>
In-Reply-To: <20220712134916.GT1790663@paulmck-ThinkPad-P17-Gen-1>
References: <20220503073844.4148944-1-elver@google.com>
        <20220711182918.338f000f@gandalf.local.home>
        <20220712002128.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
        <20220711205319.1aa0d875@gandalf.local.home>
        <20220712025701.GS1790663@paulmck-ThinkPad-P17-Gen-1>
        <20220712114954.GA3870114@paulmck-ThinkPad-P17-Gen-1>
        <20220712093940.45012e47@gandalf.local.home>
        <20220712134916.GT1790663@paulmck-ThinkPad-P17-Gen-1>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2022 06:49:16 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > I guess the question is, can we have printk() in such a place? Because this
> > tracepoint is attached to printk and where ever printk is done so is this
> > tracepoint.  
> 
> As I understand it, code in such a place should be labeled noinstr.
> Then the call to printk() would be complained about as an illegal
> noinstr-to-non-noinstr call.
> 
> But where exactly is that printk()?

Perhaps the fix is to remove the _rcuidle() from trace_console_rcuidle().
If printk() can never be called from noinstr (aka RCU not watching).

-- Steve
