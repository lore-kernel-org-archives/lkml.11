Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854D5C00144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jul 2022 10:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbiG2KVf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jul 2022 06:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235837AbiG2KVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 06:21:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814B7820DD
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 03:21:30 -0700 (PDT)
Date:   Fri, 29 Jul 2022 12:21:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659090088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mU0xv5GIVQEO071aHdUVMKejqCkW/YRvDhGbr8xHAu4=;
        b=LEFeMOgdcP4/lzafhGLvJCTbRBTWfd/lCoUQWes3rr5x8qTos5EbkXAKEvRvSdnvGRHJsJ
        8lGtyETxGPmd1eiIFYS8Ib7AhfdREAobYYpWubdQKsBCon0Ovu3GzTSyqVcw0P/MMDWT5k
        60EgGZw9bhl+v/TPTgGgJZJnA2dOeuGaTBTAb77VSjLE0NhUwvzOrfuL2AeFiysdtw1Iig
        HLaOpaRYBM0umMJbdi3p2Vei/KHvy10KegC5/OlalwJyw4uzwPXsZjdeE67Ar3FlDQqWsw
        oUxLrwBwFYSugtkMCMGx3owKU5qYbAYHkzBOlwJES+DMU7iwWIY9+NQtI6+eHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659090088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mU0xv5GIVQEO071aHdUVMKejqCkW/YRvDhGbr8xHAu4=;
        b=GaiQyhwgxVv1fv8i00zX9zKE5VC5XrHw4oiXDX8d9/5RbpJk73cL5wd/uiRzRe5GNG5whh
        as//sdT2sEiFENDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] random: Initialize vsprintf's pointer hash once the
 random core is ready.
Message-ID: <YuO0p8lMhVmQj/K2@linutronix.de>
References: <YuOf6qu453dOkR+S@linutronix.de>
 <YuOyeJu8PPAVnXiN@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YuOyeJu8PPAVnXiN@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-29 12:12:08 [+0200], Jason A. Donenfeld wrote:
> Hi Sebastian,
Hi Jason,

> Gumming up random.c with these sorts of things isn't alright. vsprintf
> isn't special in any regard here.
> 
> If you can't do this from ordinary context inside of vsprintf, just
> launch a workqueue to do it. This is already needed for changing
> vsprintf's static branch, so just move the get_random_bytes() call into
> there on RT (leaving it alone on non-RT, I guess).

So launching a worker to obtain the random data? That would mean that
the first %p print won't have nothing, right? I could do it as part of
an init-call but I don't know when the random pool is ready. And trying
it again every other second if the random core isn't ready looks kind of
wasteful.

> Jason

Sebastian
