Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A104C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jun 2022 22:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbiFXWlq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jun 2022 18:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiFXWlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 18:41:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB6E88957
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 15:41:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA9A9B82CC3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 22:41:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA611C34114;
        Fri, 24 Jun 2022 22:41:38 +0000 (UTC)
Date:   Fri, 24 Jun 2022 18:41:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] printk/console: Enable console kthreads only when there
 is no boot console left
Message-ID: <20220624184136.4aab12fb@rorschach.local.home>
In-Reply-To: <875ykvaqzm.fsf@jogness.linutronix.de>
References: <20220619204949.50d9154d@thinkpad>
        <87r13kwawb.fsf@jogness.linutronix.de>
        <20220620112936.48fcb2a4@thinkpad>
        <YrBdjVwBOVgLfHyb@alley>
        <CAHk-=wgdquXVVE37CZooVK4X+YdSa7XoGtjr71CEYh8UsdKUow@mail.gmail.com>
        <YrCDNqsPrY+Hs9ju@alley>
        <YrCO04oNncE1xF5K@alley>
        <875ykvaqzm.fsf@jogness.linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2022 00:57:09 +0206
John Ogness <john.ogness@linutronix.de> wrote:

> Since early printing does not use the kernel driver model, I do not see
> a clear solution at this point. But since using early printing is not a
> typical use, I am OK with this patch.

Does this patch still work if you add the "keep" flag to the
earlyprintk kernel parameter?

-- Steve
