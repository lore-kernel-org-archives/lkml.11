Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4ADC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 May 2022 17:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382796AbiEMROM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 May 2022 13:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382780AbiEMROI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 13:14:08 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFB835DEE
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:14:07 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id a11so8235544pff.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VM6L7CzHZq+DP15ACyDCNeBcnTiw96jhTORnn16Mcn8=;
        b=m7gQomUnSLOq+9pE4q9ffHGKLb3L3GE/tyqnZaMpqmJHNyG5wt5m5mpVnrt/R5fltk
         yK5RyYuw70QdsT3xpjionXDVduKVwIkENV/Mv5F0EHktzxJsXpmHkKAWfcOwy5gVtQvt
         Jb9aF197MUvc/8VfJWEKOA0A5W6r7Y5jyFAxdXtd+z7v8GihBIgqkMzUgDgmRLDEQBOl
         8CqLPCu3zlaWk59USw4+jqNDxNbSsUsyKPMu7PWzekJIARr0BRZnv82P4+e07sbtFdHd
         l7nGCtA297XhzYezBsDN16APQINq+JlpmHHYdQbrAp93SyhwC2tFFlzq6Ax51hV8P071
         YexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VM6L7CzHZq+DP15ACyDCNeBcnTiw96jhTORnn16Mcn8=;
        b=IoWVnzLFvAlqon0iJFAMyDxCR0GVnOqKs5yuo4K2vx4l5ZjaByUaStUR+ru8AHGWnk
         F6+KSdDVHq+BJce96rIiSn9gLGmfs8fD7CWQLpcBmuCFGEHacIni2JskqENDS0FoDVpw
         yBPFVFKgwKyKgJWvDSodW3qRxUa8j8khl/NvXc1ux4pJ8kUqjpI9w2+VWydCj8lnPoSy
         nGULYhT51FmWZuMhgiZcbESsn+VDN3401al/lvh3DclD24fP+GjuX+Mf2M+zTXfhnuKa
         E6aoAsx9pOKVPAE+ymP9NlNVph+1Od7YfzDuJw+L/IIu1rokYdbqmSZynXmDZx6tzJnV
         9S8g==
X-Gm-Message-State: AOAM532o0yHGPDVfKn2zs1r9vXymj6Grq1ATg+5VSf91AjgDayXrSqkr
        nMCjEAlibq1+ln2sN46ZvL1/Qzc0qQFACQBm83lUdQ==
X-Google-Smtp-Source: ABdhPJzzJRHomgqXTbd3lMoRoFV7vbrkO5L/UrOYsIgvGq7U/iV65DcmY+1YVfkRJDcWOE7WzBlet9mYxMGwLWQyyE4=
X-Received: by 2002:a63:1866:0:b0:3db:4b04:9f56 with SMTP id
 38-20020a631866000000b003db4b049f56mr4750300pgy.509.1652462046391; Fri, 13
 May 2022 10:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220429201131.3397875-1-yosryahmed@google.com>
 <20220429201131.3397875-2-yosryahmed@google.com> <87ilqoi77b.wl-maz@kernel.org>
 <CAJD7tkY7JF25XXUFq2mGroetMkfo-2zGOaQC94pjZE3D42+oaw@mail.gmail.com>
 <Yn2TGJ4vZ/fst+CY@cmpxchg.org> <Yn2YYl98Vhh/UL0w@google.com>
 <Yn5+OtZSSUZZgTQj@cmpxchg.org> <Yn6DeEGLyR4Q0cDp@google.com>
In-Reply-To: <Yn6DeEGLyR4Q0cDp@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 13 May 2022 10:13:54 -0700
Message-ID: <CALvZod6nERq4j=L0V+pc-rd5+QKi4yb_23tWV-1MF53xL5KE6Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] mm: add NR_SECONDARY_PAGETABLE to count secondary
 page table uses.
To:     Sean Christopherson <seanjc@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Marc Zyngier <maz@kernel.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Oliver Upton <oupton@google.com>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 9:12 AM Sean Christopherson <seanjc@google.com> wrote:
>
[...]
>
> It was mostly an honest question, I too am trying to understand what userspace
> wants to do with this information.  I was/am also trying to understand the benefits
> of doing the tracking through page_state and not a dedicated KVM stat.  E.g. KVM
> already has specific stats for the number of leaf pages mapped into a VM, why not
> do the same for non-leaf pages?

Let me answer why a more general stat is useful and the potential
userspace reaction:

For a memory type which is significant enough, it is useful to expose
it in the general interfaces, so that the general data/stat collection
infra can collect them instead of having workload dependent stat
collectors. In addition, not necessarily that stat has to have a
userspace reaction in an online fashion. We do collect stats for
offline analysis which greatly influence the priority order of
optimization workitems.

Next the question is do we really need a separate stat item
(secondary_pagetable instead of just plain pagetable) exposed in the
stable API? To me secondary_pagetable is general (not kvm specific)
enough and can be significant, so having a separate dedicated stat
should be ok. Though I am ok with lump it with pagetable stat for now
but we do want it to be accounted somewhere.
