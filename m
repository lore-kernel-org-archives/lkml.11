Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA5EC433FE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 20:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbiCYUYT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 16:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbiCYUYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 16:24:17 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263DD66CB9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 13:22:42 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id b130so5877329pga.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 13:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cSxVhb71z+Ee83vpaUYArlMABtaVLB8rzZSlwyaMw5Y=;
        b=KOZWScWPx5LRthiYDgPnYHcm3/Fe4PAO4T9J+5Ol7Lm1rlbLvP/B0+KyVQD0rTaF4p
         wv1DwFSBGhrVba45FhNgBzQR9lUWbJdjYBQFxGsFehV0gt2yQaxXxse/HodR5w2iwy3A
         HXijCz6A3szsLmM4fRii8V1p21M+LerdSCjeJ6TLY6BTSHwXIF/eM81Hm54tc57e+vc7
         RYZquCLfJGxGsk2HVd54V83PUA0kNwSwY8lXY4Yri9PDAMlQAjHnFHHh+sKoNVrjLLvm
         bWUBTDaW95QQFMlT8iHYvpphTo4tRtUP2EFSiLdeeEiIJdX0sROyhBDyPYgj7qbhA+nP
         Zu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cSxVhb71z+Ee83vpaUYArlMABtaVLB8rzZSlwyaMw5Y=;
        b=lmYM13ExuLRg+2RNQaSdmFADszIThteNXiRKLjoyYiTOhCIJ+bzBHi44VH7/Be1rO/
         +JxlmgTypoeBraLp80HJoB7a9JL0KUAG1kBkXXC7We+Ymd9XiLb1ylRXfkyWUy0z3r06
         ywmDuUOELLS12LSb7TPLOSIm4Zt5pRM1dY93NrNBfstixUKQTNz79wbnqo4M5V/crLUv
         UVH0LoA8fpW0mBH85VueA2FfDK9J7sJcKxBfYw2Mv0GPVjqgU5fU+DKv8+cVLIdRNDfC
         zYkwLyUQu4LBCcEV0C0LLBjumEcGB55Drz9D6WqqxnG1wGk7Q8EqXeG1b6vBqKwP2ANa
         2wUQ==
X-Gm-Message-State: AOAM532lojIIFZp82jSIIdwHF7R1Sg1ZvnmsNb/UWBCXiQNtztCNYxET
        WHm3Z3wJ57beTgIltFwOfZbrLw==
X-Google-Smtp-Source: ABdhPJzsYhW4Lj1IXnf4NIGQcY6MlWE3y8J/vp4aaF0mlpwG6vx59jXFeTzBbZah9AjymJqdXjJkyg==
X-Received: by 2002:a63:4859:0:b0:381:ede3:9af0 with SMTP id x25-20020a634859000000b00381ede39af0mr1013244pgk.87.1648239761482;
        Fri, 25 Mar 2022 13:22:41 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id gb5-20020a17090b060500b001c6d46f7e75sm13815829pjb.30.2022.03.25.13.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 13:22:40 -0700 (PDT)
Date:   Fri, 25 Mar 2022 20:22:37 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [FYI PATCH] Revert "KVM: x86/mmu: Zap only TDP MMU leafs in
 kvm_zap_gfn_range()"
Message-ID: <Yj4kjRSuBDfupRqW@google.com>
References: <20220318164833.2745138-1-pbonzini@redhat.com>
 <d6367754-7782-7c29-e756-ac02dbd4520b@redhat.com>
 <Yj0FYSC2sT4k/ELl@google.com>
 <78e3f054-829e-b00d-6c65-9ae622f301df@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78e3f054-829e-b00d-6c65-9ae622f301df@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022, Paolo Bonzini wrote:
> On 3/25/22 00:57, Sean Christopherson wrote:
> > Can I have 1-2 weeks to try and root cause and fix the underlying issue before
> > sending reverts to Linus?  I really don't want to paper over a TLB flushing bug
> > or an off-by-one bug, and I really, really don't want to end up with another
> > scenario where KVM zaps everything just because.
> 
> Well, too late...  I didn't want to send a pull request that was broken,

Ah, I didn't see that it was in the initial pull request, thought it was only in
kvm/next.  I'll send a full patch.

> Mingwei provided a convincing reason for the breakage.

No, the side effects are completely benign, and arguably desirable.  The issue is
that KVM loses a pending TLB flush if there are multiple roots.
