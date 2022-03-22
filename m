Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFB2C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 00:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbiCVAXT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 20:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbiCVAXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 20:23:16 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08C5B53FA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 17:20:30 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bt26so27208017lfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 17:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pricXOa/ATSDhwTUxrPjUclF7KODhUvRqabLNNb/HQs=;
        b=EzBq+h96Nb7iGIL2cJkD3bSq/6zdXFWa1MJkT/5P2WOGfvFzn88nEAQzUt7RinBxHr
         d5axvifURcfN49zJEDyMYjEip3NyGkPT2Opo0AacGZDu/+vwE8ev8t3ysuqoXVqecmHK
         bgYKATX0k2ZD+3d4IKsi11tIGhVRavakB0W9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pricXOa/ATSDhwTUxrPjUclF7KODhUvRqabLNNb/HQs=;
        b=2Qs838A313BcOarGXyqTyJTfmvkuQlGbaexQf20KPgYzZ1OF4R9qMrsDLtPsI5epgM
         1nDyOynNB+D2ILNjcGiJfuVzssaJlFjz+vx313JoGZaZQqUwZejSPDhe3QeFAkvhVB3Q
         7AYMmWHHJnlwVEktenPjKfo5N+m+t226dF+PumYtOST08b1Ka5/J1hWhSDtnKh/LiLIN
         0byfMcBtn6iWxktmAT5fRDhHu3R4cQbbVCdl63TPsDtSFCe97bSJivw5OYnpwGzUXPEv
         U6SCJ1rOBuNTNuunL3rQG2AFbh0fo/IXX7fky4udbqoAUQxsZX85KmEx2mJdPy+RBt2Q
         KPTw==
X-Gm-Message-State: AOAM530gKpdKaCuW1Uk20RZ5XFfRaE+nZf91LUn5nhTrChIrgcOHp/tQ
        d1e51I9aDzbRUNYH+eovQ6e8vV4xywqiHNyG2OE=
X-Google-Smtp-Source: ABdhPJxDF013M+4xYrEeY+u7gYoGrw+ztVJM1r5gl7j5fG3g8HEUdKwSNTEUlRhgWE3BqQpFZjutJA==
X-Received: by 2002:a05:6512:3046:b0:44a:247:2cf with SMTP id b6-20020a056512304600b0044a024702cfmr14038214lfb.161.1647908332576;
        Mon, 21 Mar 2022 17:18:52 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id l18-20020a194952000000b00445bf2c3b83sm1968516lfj.58.2022.03.21.17.18.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 17:18:50 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 17so22056650lji.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 17:18:49 -0700 (PDT)
X-Received: by 2002:a05:651c:1509:b0:249:6cd6:96d8 with SMTP id
 e9-20020a05651c150900b002496cd696d8mr13138285ljf.358.1647908329343; Mon, 21
 Mar 2022 17:18:49 -0700 (PDT)
MIME-Version: 1.0
References: <YjhZUezhnamHAl0H@gmail.com> <Yjh58h8cpcPERVZA@qian>
In-Reply-To: <Yjh58h8cpcPERVZA@qian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Mar 2022 17:18:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=whrqeX-8yHEdSCGFUyyC2sj=OLyeFR9civUiswR=A+PwA@mail.gmail.com>
Message-ID: <CAHk-=whrqeX-8yHEdSCGFUyyC2sj=OLyeFR9civUiswR=A+PwA@mail.gmail.com>
Subject: Re: [GIT PULL] scheduler updates for v5.18
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Huang, Ying" <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 6:13 AM Qian Cai <quic_qiancai@quicinc.com> wrote:
>
> On Mon, Mar 21, 2022 at 11:54:09AM +0100, Ingo Molnar wrote:
> > Huang Ying (3):
> >       sched/numa-balancing: Move some document to make it consistent with the code
> >       sched/numa: Fix NUMA topology for systems with CPU-less nodes
> >       sched/numa: Avoid migrating task to CPU-less node
>
> Linus, I don't think you want to merge this as-is. This will introduce a
> kernel crash on arm64 NUMA as mentioned in this thread,

Ok, dropped from my queue. Thanks,

                 Linus
