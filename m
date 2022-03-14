Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AAFC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 14:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240364AbiCNOqb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 10:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiCNOq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 10:46:27 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E388336161
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 07:45:16 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id e186so31198969ybc.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 07:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eHOFQ6OeVmD5xAvxpdkiIICSQ9CsKQewCdMWT4MvmNM=;
        b=kJ2uFEbx/7+tJLn5CVdvf9BPKnzVRSwuYgvF7viFcSPIUz7HUSA1mNd1ZM1h2sHaIM
         PRb5ABgceN5cePC4kA4HLqxKxF07gHa1kwZcrH/kiFPVMlCvXQE0pJ7porGFuohzhEAC
         KMa9cCAOMaJRNI4Tt+KhUuBnIjCjHBe7i3Y8GCzwaSmx2oenNP7ygHFRwM0M7WPmQvVf
         788+H8YLDF+McFmOhGYp8rHyhQG2PWJxOzHOHO2Vv6/EgLEB1s6MxIPog7GL6mpVW8eT
         oOFvfCC8tv6RUGXESVkTiyCA8yiVF7wg691tbs2LBPCEmzU5YnLqbXCkPz1oq6rv+hF9
         7Erg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eHOFQ6OeVmD5xAvxpdkiIICSQ9CsKQewCdMWT4MvmNM=;
        b=gHZWPLWDFaAIV3oejMqjRkFOraoNIFuu9EJHFI4jqt8ZsH+N4FTpz2LBjcX9VS1RtD
         YRZqeDEpALITR4aJydkgPm9h+hw8fKoN+KgX6uVxirWJ3ClMBd87qVgTcyqoIKg9tznG
         XpoVD0a3wtkI8dJfy1j6mBOsvis1aTbG+qqm7KL6pGQ1IKg0sStlAUb+2eTtgX94K7bS
         jhvBYR0c2hAX1wwiSxZTRU1oGUzJrndw3sdqc4nwGuckrkeAWMo3M0OQaY6oHkGGIbvp
         2RC9MlffKxPk7j9db8AZ9fDJ05rlM4mVTERmVVcBpaqYGLqWeA7JM4/2ApM3zvnBbMse
         zVqQ==
X-Gm-Message-State: AOAM530NCF43H//fOzWDwtRAKo2PyxhvaJjl7Xz8ZGA3VyuGHFhh7bS0
        Xi4KcefE235J7qPAjc1FkWZPqntxGQIFhtdRHW6Hwg==
X-Google-Smtp-Source: ABdhPJymjMuY2O/Ot9G/D3+o0FONpz7ABu4KFyvOcryH1Xdx2fEN383eY9Hdw++IOrTPgNoOwBMa7cVOlHHRcrcwAT0=
X-Received: by 2002:a25:d50c:0:b0:627:660c:1874 with SMTP id
 r12-20020a25d50c000000b00627660c1874mr17976243ybe.625.1647269115342; Mon, 14
 Mar 2022 07:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220314133738.269522-1-frederic@kernel.org> <20220314133738.269522-3-frederic@kernel.org>
In-Reply-To: <20220314133738.269522-3-frederic@kernel.org>
From:   Marco Elver <elver@google.com>
Date:   Mon, 14 Mar 2022 15:44:39 +0100
Message-ID: <CANpmjNPqY65ZYLFukgp779pHbiRH05yns+G7Z36QdWwrQp1WOQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] preempt/dynamic: Introduce preempt mode accessors
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2022 at 14:37, Frederic Weisbecker <frederic@kernel.org> wrote:
>
> From: Valentin Schneider <valentin.schneider@arm.com>
>
> CONFIG_PREEMPT{_NONE, _VOLUNTARY} designate either:
> o The build-time preemption model when !PREEMPT_DYNAMIC
> o The default boot-time preemption model when PREEMPT_DYNAMIC
>
> IOW, using those on PREEMPT_DYNAMIC kernels is meaningless - the actual
> model could have been set to something else by the "preempt=foo" cmdline
> parameter.
>
> Introduce a set of helpers to determine the actual preemption mode used by
> the live kernel.
>
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> ---
>  include/linux/sched.h | 16 ++++++++++++++++
>  kernel/sched/core.c   | 11 +++++++++++
>  2 files changed, 27 insertions(+)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 508b91d57470..d348e886e4d0 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2096,6 +2096,22 @@ static inline void cond_resched_rcu(void)
>  #endif
>  }
>
> +#ifdef CONFIG_PREEMPT_DYNAMIC
> +
> +extern bool preempt_mode_none(void);
> +extern bool preempt_mode_voluntary(void);
> +extern bool preempt_mode_full(void);
> +
> +#else
> +
> +#define preempt_mode_none() IS_ENABLED(CONFIG_PREEMPT_NONE)
> +#define preempt_mode_voluntary() IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY)
> +#define preempt_mode_full() IS_ENABLED(CONFIG_PREEMPT)
> +

Shame this was somehow forgotten.
There was a v3 of this patch that fixed a bunch of things (e.g. making
these proper functions so all builds error if accidentally used in
#if).

https://lore.kernel.org/lkml/20211112185203.280040-3-valentin.schneider@arm.com/

Is it also possible to take all the rest of that series (all 4
patches) from Valentin?

Thanks,
-- Marco
