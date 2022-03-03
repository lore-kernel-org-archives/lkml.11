Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED038C433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Mar 2022 00:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiCCANV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiCCANN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:13:13 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CE4CB937
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 16:12:30 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id p3-20020a17090a680300b001bbfb9d760eso6243321pjj.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 16:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Td4OZ3CGd5qbdkbgU7FY+nlkAv7YQKpmIhrzx/kUjzU=;
        b=K1LcK7iCnXuheBWswh9IK28RiGD6oNWwq9sVu+D7heKHTJ4ArDuYccdpbxGNoDQ43z
         rXucgFRTFwpkDDKm5q8FHQlbT0RXSWsJmBRhCeJJSoObX5ISY20k1epb5uXEBQZYsTJb
         52fvKPWsR193DmcZ5aAKb8BoscIkjXmPWuQXX/lOKH5RWZMS2BnAJGOEFQpske8qx+Cc
         dDHOja0t1ObCNHaLze4mbZjXZV1606kGCYyU7SZonkicuaWQhYa0vj0uuzdtryUta6HR
         WawmlaAyb2plPEIyi/9iw1mS4soHJ7Xj7itbwm1xuWD/cr8F8Bua5JC7QN0AF4OE/GVX
         ukUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Td4OZ3CGd5qbdkbgU7FY+nlkAv7YQKpmIhrzx/kUjzU=;
        b=Iy9b3iNHyDoVhMGenfJ9KYDkAkVXRKW3lSLyGGyPT0Y4YKsrgbvMWro47IKUPladmW
         Rg0gPPlBKpNIXyBaCvF9YVxrJRZ8WD8h3KPR9LS5rz49PU/nTA/SAdPtZp4oY365MRTy
         m0jOKgxXrr9NUZDHuXexbRK3iahFh119q9EbByKOWVc0CsyqEFmgOvs/sW4y2lOHpyb5
         TULBtfBPWUvdnke3ReVAfgrp74GjaiA7KhfxJ2KGCeFTQLLl9X0abjunvOhF4J5/MWXk
         tXc7xXvnlbCXLY9DBJK+iCB6VRWnZ+/gnxfNJ+gbSMFsqemoChSgJM8wHsMk1uL42eQq
         Y+XQ==
X-Gm-Message-State: AOAM530WEknaYt0G3F7mN+F0E9SG6ffBYHsSzaZn0b6PZOWPJrD4dCSd
        hU6JJLvS6q7+vi67eoBYU42TjQ==
X-Google-Smtp-Source: ABdhPJwR7M4jonsW7a9xPbncoCR2AjvLpdLl9OviFtzwYaKQ+z+yJXD3Am1fuqU3JpL/ica97nb7ig==
X-Received: by 2002:a17:90b:3d02:b0:1bc:85fa:e24 with SMTP id pt2-20020a17090b3d0200b001bc85fa0e24mr2354281pjb.239.1646266349430;
        Wed, 02 Mar 2022 16:12:29 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id y5-20020a056a00180500b004e1bea9c587sm323943pfa.67.2022.03.02.16.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 16:12:28 -0800 (PST)
Date:   Thu, 3 Mar 2022 00:12:25 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>
Subject: Re: [PATCH v3 04/28] KVM: x86/mmu: Formalize TDP MMU's (unintended?)
 deferred TLB flush logic
Message-ID: <YiAH6UfSDyHeMP+s@google.com>
References: <20220226001546.360188-1-seanjc@google.com>
 <20220226001546.360188-5-seanjc@google.com>
 <YiAE4ju0a3MWXr31@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiAE4ju0a3MWXr31@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022, Mingwei Zhang wrote:
> On Sat, Feb 26, 2022, Sean Christopherson wrote:
> > diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> > index 12866113fb4f..e35bd88d92fd 100644
> > --- a/arch/x86/kvm/mmu/tdp_mmu.c
> > +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> > @@ -93,7 +93,15 @@ void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root,
> >  	list_del_rcu(&root->link);
> >  	spin_unlock(&kvm->arch.tdp_mmu_pages_lock);
> >  
> > -	zap_gfn_range(kvm, root, 0, -1ull, false, false, shared);
> > +	/*
> > +	 * A TLB flush is not necessary as KVM performs a local TLB flush when
> > +	 * allocating a new root (see kvm_mmu_load()), and when migrating vCPU
> > +	 * to a different pCPU.  Note, the local TLB flush on reuse also
> > +	 * invalidates any paging-structure-cache entries, i.e. TLB entries for
> > +	 * intermediate paging structures, that may be zapped, as such entries
> > +	 * are associated with the ASID on both VMX and SVM.
> > +	 */
> > +	(void)zap_gfn_range(kvm, root, 0, -1ull, false, false, shared);
> 
> Understood that we could avoid the TLB flush here. Just curious why the
> "(void)" is needed here? Is it for compile time reason?

Nope, no functional purpose, though there might be some "advanced" warning or
static checkers that care.

The "(void)" is to communicate to human readers that the result is intentionally
ignored, e.g. to reduce the probability of someone "fixing" the code by acting on
the result of zap_gfn_range().  The comment should suffice, but it's nice to have
the code be self-documenting as much as possible.
