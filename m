Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C42C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 07:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242084AbiCWHMo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 03:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbiCWHMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 03:12:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B95A71EF8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 00:11:14 -0700 (PDT)
Date:   Wed, 23 Mar 2022 08:11:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648019472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5LwrxMc5JsGCwtbw0KQoqFH9oBa45tUyyC40su1WtOI=;
        b=GtTWeQdg1cUnppHuxIJtkjvqCKLhdnNf2ka6CJAfE//XEavXTihd7oNgRFgTatZOos1flf
        KaTm3b4KnkT3/Y92TU6VrWDCuW5noNcSxWmLT5lZ8xiDNPKR77HYrNeHG3NqguWVlfZjD3
        doOf97oRB7804/dm3oYunHZ5FialZ0mZ4dN5A7P33dMTTjMoAwOuzKQ6HbKZrQGInEvNdw
        Gtjp7icGVU600gpUUQOm84h/4+mXhGna+fthcnrxj3Cz61PzTqzA5mMVjXYKnuuAFKhdMP
        dPi+G5xKxdfiohUVrTI6OriUGqY/XPYL/oB9GqBKaCWYgCJ9ulMe9nIEPApUdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648019472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5LwrxMc5JsGCwtbw0KQoqFH9oBa45tUyyC40su1WtOI=;
        b=gEk6+8ZDi4A8LFara/ZJhUuQ4/8EEKaTLFAZlAyrLNg+i5vFyxZT9LW1O2BizVDI4vOfbS
        wF/+qYjZ8vU56TAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] locking changes for v5.18
Message-ID: <YjrIDlUePHQtIV4K@linutronix.de>
References: <YjhdcJB4FaLfsoyO@gmail.com>
 <CAHk-=wjS6ptr5=JqmmyEb_qTjDz_68+S=h1o1bL1fEyArVOymA@mail.gmail.com>
 <YjpLiKRUIB4TGJm0@zn.tnic>
 <CAHk-=wifoM9VOp-55OZCRcO9MnqQ109UTuCiXeZ-eyX_JcNVGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wifoM9VOp-55OZCRcO9MnqQ109UTuCiXeZ-eyX_JcNVGg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-22 15:58:47 [-0700], Linus Torvalds wrote:
> On Tue, Mar 22, 2022 at 3:20 PM Borislav Petkov <bp@alien8.de> wrote:
> >
> > Ah, you say build error because you have CONFIG_WERROR=y.
> 
> EVERYBODY should have CONFIG_WERROR=y on at least x86-64 and other
> serious architectures, unless you have some completely random
> experimental (and broken) compiler.

I haven't seen it in my builds but it was reported earlier with a patch
   https://lkml.kernel.org/r/20220215184322.440969-1-nathan@kernel.org

which is sitting in Andrew's. I'm not completely satisfied with this
__maybe_unused, let me try to get clang and maybe I can figure something
else out.

>              Linus

Sebastian
