Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2C3ECAAD2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Sep 2022 23:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbiIAXWC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Sep 2022 19:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbiIAXV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 19:21:59 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9899F19B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 16:21:58 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id t184so927213yba.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 16:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=TioOqS04vLMS9dH6wDVg3ppqoyZpw4Z0vjZr4LO/zFY=;
        b=k1eQ5hiUMMNou7qBsVIMH8lkkFwkk+vgtWYh7f5ywTcVo9hlj63v9Ohlnl7I4aVQn2
         GKNc7kz9DNkTzlzJbs7rNIACNJQpgSFtXp8ekBVwDboxc58Q20On8g/7Ml1oAOUn3Ce3
         IJSbUJRUZjtXcBEog461xSrYM2HF3AP0QXjTmMrynLxxaUM0Lx3J39/DOYaC4rORcZFC
         Ml9yPqd6Al8pgH5yjdE3x7J31KSa7Vqb3x9q5k1HdwNRFhURAjgmW5h3DEC9e1sDnxzz
         uX3CPfe0M1qBUQSu4yJNm4/ICa2gO5smYoiREDCRbhjpvjuH1N0756ewgER3fFa+YmzK
         VKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=TioOqS04vLMS9dH6wDVg3ppqoyZpw4Z0vjZr4LO/zFY=;
        b=20Z8T6y6iugLsT9ksimCM10c6AgC89LTxCUyiXV/a0P7ez0p11+Qw6P+LyaPQmW1nd
         KIFI1+o8JKN+k3iB3FD7PJBlX6edzXTC6r8+Y5z/Dhch9Nr9/S5A3fsV7qUbDXXyJtNu
         t8juKLIkQTlmaNPbyO6hCYrvV0kuzOXlJuGy4q+6sowv+grbDeQj7Efgfd7zVMRE4sFc
         i7dePGBYlAPHh+TAoKi9WJrNfOjtXXxelrWhBhGquFKKAYstuMfZhhmCmWYZlfItadtE
         w58Q4+poDr+RCf2R49SDRzB8jjUWtVe8R68n/KVQk35AX8Ack0J6JNNY+aIhQDKCa/k+
         zGow==
X-Gm-Message-State: ACgBeo0AGDXAamAD9AoRwqeqRQdCkyDKBrK/yBa/yXhf8TaRL3SrOTjK
        kfw2xHEVvuR2FfCGKgZXLPTU9u53V/sAzA2/vNjktg==
X-Google-Smtp-Source: AA6agR6y3U6pHOb5dcv1vqPpmeMeTXf4aKWp13NuMCnIdt+fRCs4NW7hjbDbEqzFwTS6U1UfXZMpdc29w/Hx7SeWCQk=
X-Received: by 2002:a05:6902:1366:b0:691:4335:455b with SMTP id
 bt6-20020a056902136600b006914335455bmr20426685ybb.282.1662074518009; Thu, 01
 Sep 2022 16:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com> <20220901173516.702122-5-surenb@google.com>
 <20220901202409.e2fqegqghlijkzey@moria.home.lan> <20220901205144.66ilifzaxr5p4xi3@revolver>
In-Reply-To: <20220901205144.66ilifzaxr5p4xi3@revolver>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 1 Sep 2022 16:21:47 -0700
Message-ID: <CAJuCfpEJLNDOj6bANM+cX61c12Xw7O0XbhN9rqzkqYEa8PBBuA@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND 04/28] mm: move mmap_lock assert function definitions
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "michel@lespinasse.org" <michel@lespinasse.org>,
        "jglisse@google.com" <jglisse@google.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "willy@infradead.org" <willy@infradead.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ldufour@linux.ibm.com" <ldufour@linux.ibm.com>,
        "laurent.dufour@fr.ibm.com" <laurent.dufour@fr.ibm.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "david@redhat.com" <david@redhat.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "hughd@google.com" <hughd@google.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "rientjes@google.com" <rientjes@google.com>,
        "axelrasmussen@google.com" <axelrasmussen@google.com>,
        "joelaf@google.com" <joelaf@google.com>,
        "minchan@google.com" <minchan@google.com>,
        "kernel-team@android.com" <kernel-team@android.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 1, 2022 at 1:51 PM Liam Howlett <liam.howlett@oracle.com> wrote:
>
> * Kent Overstreet <kent.overstreet@linux.dev> [220901 16:24]:
> > On Thu, Sep 01, 2022 at 10:34:52AM -0700, Suren Baghdasaryan wrote:
> > > Move mmap_lock assert function definitions up so that they can be used
> > > by other mmap_lock routines.
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > >  include/linux/mmap_lock.h | 24 ++++++++++++------------
> > >  1 file changed, 12 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> > > index 96e113e23d04..e49ba91bb1f0 100644
> > > --- a/include/linux/mmap_lock.h
> > > +++ b/include/linux/mmap_lock.h
> > > @@ -60,6 +60,18 @@ static inline void __mmap_lock_trace_released(struct mm_struct *mm, bool write)
> > >
> > >  #endif /* CONFIG_TRACING */
> > >
> > > +static inline void mmap_assert_locked(struct mm_struct *mm)
> > > +{
> > > +   lockdep_assert_held(&mm->mmap_lock);
> > > +   VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
> >
> > These look redundant to me - maybe there's a reason the VM developers want both,
> > but I would drop the VM_BUG_ON() and just keep the lockdep_assert_held(), since
> > that's the standard way to write that assertion.
>
> I think this is because the VM_BUG_ON_MM() will give you a lot more
> information and BUG_ON().
>
> lockdep_assert_held() does not return a value and is a WARN_ON().
>
> So they are partially redundant.

Yeah and I do not intend to change the existing functionality in this
patchset. If needed we can post a separate patch removing the
redundancy but from my experience debugging this code, VM_BUG_ON_MM
reports were very useful.

>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
