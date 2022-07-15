Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102CBC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jul 2022 13:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbiGONwF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jul 2022 09:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbiGONwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 09:52:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDAA820DB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 06:52:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47839B82C6D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 13:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7C6C34115;
        Fri, 15 Jul 2022 13:51:58 +0000 (UTC)
Date:   Fri, 15 Jul 2022 09:51:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Marco Elver <elver@google.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        kasan-dev@googlegroups.com, Thomas Gleixner <tglx@linutronix.de>,
        Johannes Berg <johannes.berg@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Make console tracepoint safe in NMI() context
Message-ID: <20220715095156.12a3a0e3@gandalf.local.home>
In-Reply-To: <CANpmjNOHY1GC_Fab4T6J06vqW0vRf=4jQR0dG0MJoFOPpKzcUA@mail.gmail.com>
References: <20220715120152.17760-1-pmladek@suse.com>
        <CANpmjNOHY1GC_Fab4T6J06vqW0vRf=4jQR0dG0MJoFOPpKzcUA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 14:39:52 +0200
Marco Elver <elver@google.com> wrote:

> Couldn't this just use rcu_is_watching()?
> 
>   | * rcu_is_watching - see if RCU thinks that the current CPU is not idle

Maybe, but I was thinking that Petr had a way to hit the issue that we
worry about. But since the non _rcuide() call requires rcu watching,
prehaps that is better to use.

-- Steve
