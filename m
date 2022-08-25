Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68980ECAAA0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Aug 2022 20:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243742AbiHYUfQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Aug 2022 16:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbiHYUfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 16:35:13 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEE87E326
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 13:35:12 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id x5so16189925qtv.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 13:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=W38//0BN+Mpi0ment/DsNSBH0AG+YpTWl5XPod3ELr0=;
        b=dGjDuNJ77b0qiF7A7XJwWcfiPoVvBgARtQyqNLS8IOmEjPKNCo+Y6HtxCvKY+Ybt9d
         NQX5ik4AKTRY2tR63EXfYAvOIY/tq+aG7/TE2kPhRsXRw9fYhpy9/0bUSsQ/5mjMU8dU
         Gb43y1FYS9WQXZeJSFo9pt1A9Rf2Ho/fK3R61GbJ9sB2+hIaAY8GIig01Rfh6+sEGLIE
         SD747ay13SeKdEJgvPwoRilBilWpdK4MRdDikVgu8HtSBq78DDXkUsrg1JyGujpPZYpI
         FheTBoQejDtki6MVt3z6RV3X0pn5U1SQ3BWgyDLLmkirlx0AYA7czdk5nKNnhh3NOsKz
         A6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=W38//0BN+Mpi0ment/DsNSBH0AG+YpTWl5XPod3ELr0=;
        b=uJYsyb7fU4sbpzpmU8bmTWBaPKdw6x5lZJhfLRg2JVEYPiIc9QTvsI3O2ZH1s/Glnw
         JymYP0mxDBjc1w56LzGqnGAFEZSWcd14lUZe8qI/6/1+EWZn8o1RaAWjL4z7LFkHk2yI
         3V//TH9+YqKTDyjOlGrZPq/MxX9m3Rw/DqM79RFYgpPDFUdaSLstjHWdR5O+IEjAhWIH
         oERK5Je1dA4q2nA1kA6suED0QkYVDMJAOl6s2KmzNnLqJXn5rEg5L2L320W7E6ycO3RR
         gvvTy41cQTB5YUCf8fo0pcCIhl0a9mFZE+3hesMfIca4JsIaZsYVtSU7scF4XmM5tSR0
         A6Iw==
X-Gm-Message-State: ACgBeo3qzIL7fS6L8B6Ttai0hMZu95g3fetyx9vlooQU0LMtRcLs4DiF
        3ZGJywhZfqTxR4hAFnbJpIxeTso5zjR8V2V5tpZdmQ==
X-Google-Smtp-Source: AA6agR4Hs5T238NpECmNZXKSZ/N2q9+IQQdN3rjH+KX3J52d9R1NUUbxYt4bJMUf6oj+LM14J6BhhZHuswOZygRYZJg=
X-Received: by 2002:ac8:7f04:0:b0:343:36d:9a1f with SMTP id
 f4-20020ac87f04000000b00343036d9a1fmr5195675qtk.566.1661459711891; Thu, 25
 Aug 2022 13:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220824030031.1013441-1-haoluo@google.com> <20220824030031.1013441-2-haoluo@google.com>
 <CAEf4BzYfA5uzSVsRXJXKnUQFSD1Wmk29VPge-iEO+Los3e2VOg@mail.gmail.com>
In-Reply-To: <CAEf4BzYfA5uzSVsRXJXKnUQFSD1Wmk29VPge-iEO+Los3e2VOg@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 25 Aug 2022 13:35:01 -0700
Message-ID: <CA+khW7hHA2gjv_UhbyhU8HkFwemt4pARVw+e1SHHOteO60PF1g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 1/5] bpf: Introduce cgroup iter
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        cgroups@vger.kernel.org, netdev@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        KP Singh <kpsingh@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, Michal Koutny <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 1:18 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Aug 23, 2022 at 8:01 PM Hao Luo <haoluo@google.com> wrote:
> >
[...]
> >  typedef int (*bpf_iter_attach_target_t)(struct bpf_prog *prog,
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 934a2a8beb87..1c4e1c583880 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -87,10 +87,29 @@ struct bpf_cgroup_storage_key {
> >         __u32   attach_type;            /* program attach type (enum bpf_attach_type) */
> >  };
> >
> > +enum bpf_cgroup_iter_order {
> > +       BPF_ITER_ORDER_UNSPEC = 0,
> > +       BPF_ITER_SELF_ONLY,             /* process only a single object. */
> > +       BPF_ITER_DESCENDANTS_PRE,       /* walk descendants in pre-order. */
> > +       BPF_ITER_DESCENDANTS_POST,      /* walk descendants in post-order. */
> > +       BPF_ITER_ANCESTORS_UP,          /* walk ancestors upward. */
> > +};
>
> just skimming through this, I noticed that we have "enum
> bpf_cgroup_iter_order" (good, I like) but BPF_ITER_xxx with no CGROUP
> part in it (not good, don't like :). All the enumerator names have
> global visibility, so it would probably be best for them to be
> CGROUP-specific and roughly match the enum name itself:
> BPF_CGROUP_ITER_SELF_ONLY, etc?
>

Ack. I will send a patch to fix this right now.
