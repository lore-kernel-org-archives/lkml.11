Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270E0C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 20:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiBIUPd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Feb 2022 15:15:33 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiBIUP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:15:29 -0500
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E21E02F56E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 12:15:32 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id f18so6318880lfj.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 12:15:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ENiQCyZgLi+Xzy2BZDhc0T4bCUDZ73wqPy+Y51XTFgY=;
        b=Kc6Vyrh1VRtumG7dfqq+ArcnJE1o4T7ZL17R78eWMTVl5JYinaTNaYoo2g4vOZfCCH
         hzMgXFEo5Zgjdq8lXMuzqal++CsCcOmioDbFNLkwKdWzw1uFD7LVaU00ZZEshemiJTw6
         R17L9VxahQ8hKu2uSjmw8AMvys4riDw6rMvV9u/ddsAXOGuosl+LWHPMrv+Zuaz3/W4g
         tzjNaelF/rQ+HrdVdkFXXcolzvlGqre99EZAWAPn+RRPFbxQ+pJUvFEmupOE62HCzCJM
         Q2hhAIuWBV0KVDslFVUzja0VSRHH37RKjXmv9jBqnWcwgiUM/FLm0L7j+hAYP4Lxo8ql
         JnlA==
X-Gm-Message-State: AOAM533yX1yNf7r1bLQpQ4mgZIYjiBJupHn9RelcVMA37UFy4DsMfxwS
        QcvuMDSiAxt0lVa4vomHE050rHTfen4YcZ4+1C4=
X-Google-Smtp-Source: ABdhPJwrP/ZMqK2e/v/nCesgsV4sXOzosLtK/wLTiajZH/ukAqKl3WEoJ9X+Km7/lWslc3oP8EyDpek3HPleG+abhX8=
X-Received: by 2002:a05:6512:3996:: with SMTP id j22mr2037103lfu.99.1644437730586;
 Wed, 09 Feb 2022 12:15:30 -0800 (PST)
MIME-Version: 1.0
References: <20220208184208.79303-1-namhyung@kernel.org> <20220208184208.79303-12-namhyung@kernel.org>
 <20220209084041.GJ23216@worktop.programming.kicks-ass.net>
In-Reply-To: <20220209084041.GJ23216@worktop.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 9 Feb 2022 12:15:19 -0800
Message-ID: <CAM9d7cgg9dUP0hqYfrDmXT7q2T9GiJt9uthKB7wEWNnKkMPisA@mail.gmail.com>
Subject: Re: [PATCH 11/12] locking/mutex: Revive fast functions for CONFIG_LOCK_TRACEPOINTS
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Wed, Feb 9, 2022 at 12:41 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Feb 08, 2022 at 10:42:07AM -0800, Namhyung Kim wrote:
> > I'm not entirely sure why it removed the fast versions when lockdep is
> > on.  It seems easy to add the required annotation when the fast
> > version is succeeded as far as the tracpoints are concerned.
>
> IIRC it was something like, lockdep depends on MUTEX_DEBUG and that in
> turn relied on not having the fast path enabled. MUTEX_DEBUG used to
> always take the wait_lock to ensure the debug state is consistent with
> the lock state.

I see.  Thanks for the explanation!

Namhyung
