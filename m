Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21117C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Apr 2022 00:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236772AbiDIAvj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Apr 2022 20:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiDIAve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 20:51:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0873152F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 17:49:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DC07621C7
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 00:49:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1539C385A5;
        Sat,  9 Apr 2022 00:49:26 +0000 (UTC)
Date:   Fri, 8 Apr 2022 20:49:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, jstultz@google.com,
        Stephen Boyd <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC][PATCH] timers: Add del_time_free() to be called before
 freeing timers
Message-ID: <20220408204925.16361b44@rorschach.local.home>
In-Reply-To: <CAHk-=wg3icnjr+6aU-Wyw+kBoSRBM28P4o4iTgimOWDuuUiStQ@mail.gmail.com>
References: <20220407161745.7d6754b3@gandalf.local.home>
        <87pmlrkgi3.ffs@tglx>
        <CAHk-=whbsLXy85XpKRQmBXr=GqWbMoi+wVjFY_V22=BOE=dHog@mail.gmail.com>
        <87v8vjiaih.ffs@tglx>
        <20220408202230.0ea5388f@rorschach.local.home>
        <CAHk-=wg3icnjr+6aU-Wyw+kBoSRBM28P4o4iTgimOWDuuUiStQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Apr 2022 14:30:21 -1000
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Apr 8, 2022 at 2:22 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > We could always use the LSB bit of the function as a "shutdown" flag, where:  
> 
> While we do that for data pointers, doing it for function pointers is dodgy.
> 
> Not all architectures necessarily align code pointers. In fact, I
> think that "-Os" on x86 makes all code alignment go away, and so
> function pointers have no alignment at all.

Hmm, well, I'm not sure it would work for all architectures, but what
about the MSB?  Setting it to zero on "shutdown"?

-- Steve
