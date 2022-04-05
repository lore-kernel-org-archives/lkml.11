Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F30C4167E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 20:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385644AbiDEUFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 16:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573311AbiDESwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 14:52:45 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE82B1AA5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 11:50:46 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d15so6307740pll.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 11:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bII+JPpo5IH9mgrwvjzQUo8tjQFZBMZQwRPuej7AAhI=;
        b=JhnKFhyHjciKLHFUxXi/UkE6P1dEsxlHONapSmJt19/k29RmjgUAVYbH3BesEwxHrM
         nuNIoh8Ght/verLVCcyudWRbTuK5FB5gudUG6wfh5V1VAuQWy9TBV6zzGwym1GiydR03
         vnd3aH+JrjMQfwQrsbFC9hq8xLKanduVOA/IqxyyGsIa5ifLQOmP1D8O/cYStr7eSdbC
         YVTaw4fYG41B2EiuL56o5RPNJ7vL2GVgZKtRNqqIw+9SAl7p/3ivqlUyj/V5mSoe0bUG
         hEZiL1xXFGX9YMwU5eHmsKruNMmxDqBv4xNEYyIZlXU9AWWlJscq27gS+fVn5TWRnDI1
         gfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bII+JPpo5IH9mgrwvjzQUo8tjQFZBMZQwRPuej7AAhI=;
        b=asGu+j0LKvihU5h/S3ZgQdaIasIyt4NnZn1izv6XkaRmZfsCVuohKdlvGfvKS4OHBk
         7Les+fMOO0NhLZWs9PGoTcEisMBp/FC1lG5N0uhUOfLGeCfBcySutCY9WcYNQhyALMz5
         FVXWUyDDdZ2Ca/f75oH+fxdKp0YqINtkFcKMuM0A/ZajEnUkX3q+CWjJ/9EHi04YPYLs
         WOE7umaOe2/jDgUpe8WxA0NnLPKfdZ8o9NixWpJ9DDpS2oMnddF3BCSSfC/u5I8z1TNb
         F53OguHeeyrWPYn/8tilhWPMXQMctEoPVve7ooZxU9HnRzZJSZmwHP6YE8zTRIhmk2WQ
         3dZg==
X-Gm-Message-State: AOAM5320o7r78Sl7mml9Szrcy5+gZjJUCEbe/OlKxuyK4OpSICKKMSB5
        r3RdfDD34NZJKNvrvaoqovjXRYJfQ+5H9I0+UGD2Qg==
X-Google-Smtp-Source: ABdhPJzAdZ+bLj6sxMy6NCkl3KdGndxeFm7oJtsBN+yYBEgdhfx+bLXHx0hNFl6alDAGRZ4eV0ogNMdiDO3mkNfNJ6k=
X-Received: by 2002:a17:902:8b88:b0:156:2b14:cb6e with SMTP id
 ay8-20020a1709028b8800b001562b14cb6emr4908764plb.14.1649184645775; Tue, 05
 Apr 2022 11:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220404234154.1251388-1-yosryahmed@google.com> <YkyOJqTeGRUjtuX1@google.com>
In-Reply-To: <YkyOJqTeGRUjtuX1@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 5 Apr 2022 11:50:09 -0700
Message-ID: <CAJD7tkYqSMk5UO5A46sR1cOviDeww0=JsR6QRMO9ZRF_7NLXBA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] KVM: mm: count KVM page table pages in pagetable stats
To:     Sean Christopherson <seanjc@google.com>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, mizhang@google.com,
        David Matlack <dmatlack@google.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-mips@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Johannes Weiner  +Michal Hocko  +Roman Gushchin

On Tue, Apr 5, 2022 at 11:45 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Mon, Apr 04, 2022, Yosry Ahmed wrote:
> > We keep track of several kernel memory stats (total kernel memory, page
> > tables, stack, vmalloc, etc) on multiple levels (global, per-node,
> > per-memcg, etc). These stats give insights to users to how much memory
> > is used by the kernel and for what purposes.
> >
> > Currently, memory used by kvm for its page tables is not accounted in
> > the pagetable stats. This patch series accounts the memory pages used by
> > KVM for page tables in those stats.
>
> It's still not obvious to me that piggybacking NR_PAGETABLE is desirable, probably
> because I am quite clueless as to how these stats are used on the backend.  E.g.
> why not have a NR_SECONDARY_PAGETABLE entry to track pages used for secondary MMU
> page tables?

We can add NR_SECONDARY_PAGETABLE or even NR_KVM_PAGETABLE, but I am
not sure whether this separation is desired on the MM side. Let's see
what MM folks think about this.
