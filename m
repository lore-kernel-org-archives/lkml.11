Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA5EC35276
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 22:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387670AbiBHW2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386423AbiBHU3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 15:29:46 -0500
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0EFC0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 12:29:45 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id j14so552176lja.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 12:29:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=atITRJU41fTqhaKxq/8QmwHxREfuvI3xR+qm2eVMnVQ=;
        b=0bUOwReI0gSml+ChpQdxxTSWHRdQ7qc283IRrAk3ea4im0CKEu735qtQT1VqwdpqsJ
         fP95H/4G0UmsfxxG8SI1ZMmVOKaX8MqNzz48CP+qdiR8Q/EzoC25HuHgYFhn2H78bCHk
         UTtAFfJGGEjugjO02gM62/CxEi2QjiisKQrxwOvwA9QzaHcTr+xNubaBuUx/kHH6xe1e
         709BjOvV82qgtnrXg1XEWOVjpAeoNjapOvEK/fIJ41x/LHqSROXTspmk24qApeWR7AbW
         MipeRUDI1vrZJ6kV+KaEaabzDEahYro5w30FuOnY8e+ujMFVWMKmnsQVtieixTB53OS4
         i3mA==
X-Gm-Message-State: AOAM533M1cdo5HywNdfLsuoul43cfqyLWdvFoT9bSWOZuQkSOliiN9Rb
        Y5JL5/lDBn1A0l5CJ+WoRfl6oQ1OEH0Zm1BsYvw=
X-Google-Smtp-Source: ABdhPJw8tE/avmlvMaM7ky0xK80KvTDExwZg5JqDe5vk5pEjZ+1CjWB5CQ168CO0yoAgdS/6yZg+tfOczu5dXOWSlTk=
X-Received: by 2002:a2e:7219:: with SMTP id n25mr3651814ljc.204.1644352183755;
 Tue, 08 Feb 2022 12:29:43 -0800 (PST)
MIME-Version: 1.0
References: <20220208184208.79303-1-namhyung@kernel.org> <20220208184208.79303-4-namhyung@kernel.org>
 <20220208143641.7850bbc6@gandalf.local.home>
In-Reply-To: <20220208143641.7850bbc6@gandalf.local.home>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 8 Feb 2022 12:29:32 -0800
Message-ID: <CAM9d7cgdauVW+HdpQS_FNG4e3SRR1JP74N1Z-SX+hXZ-yDM5DQ@mail.gmail.com>
Subject: Re: [PATCH 03/12] timer: Protect lockdep functions with #ifdef
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Byungchul Park <byungchul.park@lge.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Tue, Feb 8, 2022 at 11:36 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue,  8 Feb 2022 10:41:59 -0800
> Namhyung Kim <namhyung@kernel.org> wrote:
>
> > With upcoming lock tracepoints config, it'd define some of lockdep
> > functions without enabling CONFIG_LOCKDEP actually.  The existing code
> > assumes those functions will be removed by the preprocessor but it's
> > not the case anymore.  Let's protect the code with #ifdef's explicitly.
>
> I wonder if it would be cleaner to have another macro name for these
> locations to keep out the ugly #ifdef in the code.
>
> lockdep_init_map_raw() ?

Yeah, I like that..  Then I also need to add the _raw variants
for acquire, release and so on.  Is that ok?

Thanks,
Namhyung
