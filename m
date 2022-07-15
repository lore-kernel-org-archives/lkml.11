Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65270C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jul 2022 15:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbiGOPC6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jul 2022 11:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbiGOPCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 11:02:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCB27B343
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 08:02:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E698CB82D07
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 15:02:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35024C34115;
        Fri, 15 Jul 2022 15:02:50 +0000 (UTC)
Date:   Fri, 15 Jul 2022 11:02:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Marco Elver <elver@google.com>, kasan-dev@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Johannes Berg <johannes.berg@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Make console tracepoint safe in NMI() context
Message-ID: <20220715110248.02b294b7@gandalf.local.home>
In-Reply-To: <20220715120152.17760-1-pmladek@suse.com>
References: <20220715120152.17760-1-pmladek@suse.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 14:01:52 +0200
Petr Mladek <pmladek@suse.com> wrote:

> +	/*
> +	 * trace_console_rcuidle() is not working in NMI. printk()
> +	 * is used more often in NMI than in rcuidle context.
> +	 * Choose the less evil solution here.
> +	 *
> +	 * raw_smp_processor_id() is reliable in rcuidle context.
> +	 */
> +	TP_CONDITION(!rcu_is_idle_cpu(raw_smp_processor_id())),
> +

As Marco mentioned in the other thread, would a check for
'rcu_is_watching()' be better?

-- Steve


>  	TP_STRUCT__entry(
>  		__dynamic_array(char, msg, len + 1)
>  	),
