Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F4AC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Apr 2022 21:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353901AbiDOVxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Apr 2022 17:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiDOVuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 17:50:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A0362C92
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 14:48:21 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650059299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a9g9Py9KrIygzXA+D7nZBmZ+mNzn1Yv8mrhsxKLGix0=;
        b=a9unpxl4SkOIavCFJUr9CagNlQmEF0mpIjXS9vgvddEzlbs0TqMH2qnBnvJ74PzQBYyMCK
        x71TMzSrGfiGlRwnEinLLHoGSMIe8e3DDe477E0StNIcFYFO+eWRq7apLOn3NVceeGWsIv
        xgM4ftAL6S2d0w070vNtCmwDE3TLaI/e8me65SfkEZ8PjIVcZWnyZrYFfUhYrYxJso7tLM
        O19muZ1CCxn01S3s/OBDDcHE7R5SybX4aeUbXAbM6IilaRiYdHOFkPTrwmuFFFkZcSZXhQ
        Dym8gLrfe+jObr4dsOpRYk3FIl8UTKUYfTMqZsubk4qBrn/oZMefVO78vGSnEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650059299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a9g9Py9KrIygzXA+D7nZBmZ+mNzn1Yv8mrhsxKLGix0=;
        b=wpn1rSfGfELbdE1qTywpJe90viKOv5tjsU/vt0b1WZN8hD1qL7Y5/jFtI71fLSLG6DkD4y
        POJfc2F1G48n5TBQ==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [patch 2/3] timekeeping: Mark tk_clock_read() __always_inline
In-Reply-To: <YllgYuZ2jJvQbfZo@hirez.programming.kicks-ass.net>
References: <20220415091223.187169221@linutronix.de>
 <20220415091921.014937522@linutronix.de>
 <YllgYuZ2jJvQbfZo@hirez.programming.kicks-ass.net>
Date:   Fri, 15 Apr 2022 23:48:18 +0200
Message-ID: <87mtgm9fx9.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15 2022 at 14:09, Peter Zijlstra wrote:

> On Fri, Apr 15, 2022 at 11:19:36AM +0200, Thomas Gleixner wrote:
>> Compilers can uninline this which makes the notrace annotation of the NMI
>> safe accessors moot.
>
> inline already implies notrace.

Bah. Confused myself vs. noinstr. We have too many constraints...

> No objection to making it __always_inline, but this reason doesn't
> really work.

Let me come up with a more coherent argument.

Thanks,

        tglx
