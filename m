Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF063CCA480
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jul 2022 17:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbiGTRS1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jul 2022 13:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235324AbiGTRSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:18:25 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F483AB3B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:18:24 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id p6-20020a17090a680600b001f2267a1c84so1014033pjj.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0A7Vop3JLb1LjbZM57vszyAHhwMfMivUkOyzRnB3v4k=;
        b=OMPem98GHTwpACFqIppAYiEcB9A98T6HaqNgfFg6loCE9C2If5iTTOylYF/LdCO3j7
         wWRWVsrG1G9zL67r49dHTzEKiDpOBggC4Vq8U6GsaMa3hTOMEhXKfPUWNt9lDzmzq3dX
         se2X1rKBZXrPcAaIRqNAdVGJS/1HEeYwDpKF0DVY7JfZHQSbNoTBy8oKCNXslNZjfFaQ
         r7fsrHGZWmkTKOzZh1i6CSgPkrRfd1uGss9EYUoGOwndxI3YdGWbHocM3ZUNgPrraVCK
         hT2hHCcpX7iD91UczKNWjeIirCaWA8nw0HPpkuy2fm0xJ4K00zGe/VnRSgoWzaRJDYa3
         eKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0A7Vop3JLb1LjbZM57vszyAHhwMfMivUkOyzRnB3v4k=;
        b=nLBw5ABUsAQddJcRnsZD98NelK6AORyQaL4rsR5pUJl4H1SIYPbEFOafauunfpCCBA
         x1r3q1s9sL5WyqqilH9ctrwRiJTl+bZuyVhIxs3WT3E5LqY+bdcdbhvxwBY0zbGPupB4
         rA74BjpoeMF9USV/qBNuGBUcoFzQjcD30+zDZk5Jm6LaGh+wClVGMSGOjqVbw0BVklNn
         jbPjSHJqOoYH4LOwwgO7caqjGUAS0AZmgGUCHnBLeoLdQbBiZQxvo1Vm4UBRDeE5naCk
         ZUjjTPF+k/MNZn8h0DXIB7e61WsPULkngX7gNHr6LPaqq5OcQxommOCQGQd3Zit2qDPP
         dH+Q==
X-Gm-Message-State: AJIora8aGHA9cm53+whJaqIxstt/1/f0jMBwYN8IzwNtlpaQNU8a2nm1
        uNnfP9B4akqSTc4EjHDe+fNC3Q==
X-Google-Smtp-Source: AGRyM1u1q5jWE+4EwAQPjgXW1AyAFcCYEgcXf7FKYYKoaVc96AaLu+frjyDkY4pgRjfZJtH4E03J1g==
X-Received: by 2002:a17:902:e945:b0:16a:1c41:f66 with SMTP id b5-20020a170902e94500b0016a1c410f66mr39507484pll.129.1658337503742;
        Wed, 20 Jul 2022 10:18:23 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id f15-20020aa7968f000000b00528c22fbb45sm14095091pfk.141.2022.07.20.10.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 10:18:23 -0700 (PDT)
Date:   Wed, 20 Jul 2022 17:18:19 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Gao <chao.gao@intel.com>
Cc:     Kechen Lu <kechenl@nvidia.com>, kvm@vger.kernel.org,
        pbonzini@redhat.com, vkuznets@redhat.com, somduttar@nvidia.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 4/7] KVM: x86: Let userspace re-enable previously
 disabled exits
Message-ID: <Ytg428sleo7uMRQt@google.com>
References: <20220615011622.136646-1-kechenl@nvidia.com>
 <20220615011622.136646-5-kechenl@nvidia.com>
 <20220615025114.GB7808@gao-cwp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615025114.GB7808@gao-cwp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022, Chao Gao wrote:
> On Tue, Jun 14, 2022 at 06:16:19PM -0700, Kechen Lu wrote:
> > 7.14 KVM_CAP_S390_HPAGE_1M
> >diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> >index f31ebbb1b94f..7cc8ac550bc7 100644
> >--- a/arch/x86/kvm/x86.c
> >+++ b/arch/x86/kvm/x86.c
> >@@ -4201,11 +4201,10 @@ static inline bool kvm_can_mwait_in_guest(void)
> > 
> > static u64 kvm_get_allowed_disable_exits(void)
> > {
> >-	u64 r = KVM_X86_DISABLE_EXITS_HLT | KVM_X86_DISABLE_EXITS_PAUSE |
> >-		KVM_X86_DISABLE_EXITS_CSTATE;
> >+	u64 r = KVM_X86_DISABLE_VALID_EXITS;
> > 
> >-	if(kvm_can_mwait_in_guest())
> >-		r |= KVM_X86_DISABLE_EXITS_MWAIT;
> >+	if (!kvm_can_mwait_in_guest())
> >+		r &= ~KVM_X86_DISABLE_EXITS_MWAIT;
> 
> This hunk looks like a fix to patch 3; it can be squashed into that patch.

It's not a fix, just an inversion of the logic to make it easier to maintain
going forward.  I intentionally made the change in patch 4 so that adding the
kvm_get_allowed_disable_exits() is a more "pure" movement of code from the "check"
path to a common helper.

I agree it's kinda odd, but I still think splitting the changes is desirable.
