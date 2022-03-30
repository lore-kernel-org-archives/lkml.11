Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A49C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 00:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241433AbiC3AWZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Mar 2022 20:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235006AbiC3AWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 20:22:24 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F9D14B87C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 17:20:40 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id v4so19054641pjh.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 17:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4YqnuRfg2MHKNaL7P8O8O9EyyaSzDXcdnGupk1MjP6Q=;
        b=FwBNuG0B2TUtJ7MsB9irvutbDXGMqfxx4ZVng27Iu1ZaBc9HMbFPOPY+2a9BcFGcqr
         q/I6kj6SnLjFU5gXSHzSmcuUQPmVGZVmebcqp0EteR7JV5Bdmh0qmsQuE9pldf5/0aw8
         d12+58TApk71ah/NZEctlSTaWz8ngGNL//7HTmS7FE3dv3yr0bGYGVYIuoX7JV6icmKf
         oedwcKH23HbvMhZ0Ehz1kc/SJDrXOLe11c2hUg4Qe9kKwMiMOI6KwbRwmlUGFCJvFtRd
         2VAmckMfgDbVjYzNe8Kg+c6/frjBlkeU3Y3uYvGfojmAS1xMiyMbIRCJfWEO4ItOGYhD
         bjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4YqnuRfg2MHKNaL7P8O8O9EyyaSzDXcdnGupk1MjP6Q=;
        b=lAQKyGVdkptT81hxwALrGzQvb1Bdow0y2XHMBAFGWVGzGN140FDEp09wZF6SxFESxz
         l8+nS6H7SjsoA2mcEmBnka15WeBpJN7ct58CjSWJ45VEKe1S3e4YXcgCjjUlzV0MeacB
         u9VXDF4N4u0+5OVaGMg0CxzejoCRrTmCdLSEe3FvAQxUItkO3idlNGiMnFdnyaYDUANL
         QQoijUuMxae9jh7QA7j3ixdPZ3+Q69bQ3s6AyuFEc5J9g2ASohPMgK71KFW5kUW3IVZF
         YiaOAQGHaP7n8OaJruCldR66Pg9XjPtOPYqpu82IxGjZ0Pg3g5JAgDKk0H84y66/YeRZ
         QBKw==
X-Gm-Message-State: AOAM531wVcdTnXHWz7GJwyZxBXE5k1M0J0gJvsJmyVOIW3ly07xptSQN
        FjwN2ng5EU0bTGHRohn/UhkQug==
X-Google-Smtp-Source: ABdhPJzKGF5NfLOT5f+svn56e+f7y8K9XwDPlhKkbMLmKNTt8SD9AQDoihMvJukzmSEU5jTPkJiRTQ==
X-Received: by 2002:a17:90a:bc1:b0:1c6:cace:32de with SMTP id x1-20020a17090a0bc100b001c6cace32demr1858248pjd.62.1648599639475;
        Tue, 29 Mar 2022 17:20:39 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id m17-20020a17090a859100b001bc20ddcc67sm3876619pjn.34.2022.03.29.17.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 17:20:38 -0700 (PDT)
Date:   Wed, 30 Mar 2022 00:20:35 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 8/8] KVM: x86: SVM: remove vgif_enabled()
Message-ID: <YkOiU2TtxE32xhCu@google.com>
References: <20220322172449.235575-1-mlevitsk@redhat.com>
 <20220322172449.235575-9-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322172449.235575-9-mlevitsk@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022, Maxim Levitsky wrote:
> KVM always uses vgif when allowed, thus there is
> no need to query current vmcb for it

It'd be helpful to explicitly call out that KVM always takes V_GIF_ENABLE_MASK
from vmcs01, otherwise this looks like it does unintentend things when KVM is
runing vmcb02.

> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  arch/x86/kvm/svm/svm.c | 12 ++++++------
>  arch/x86/kvm/svm/svm.h | 12 ++++--------
>  2 files changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index acf04cf4ed2a..70fc5897f5f2 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -172,7 +172,7 @@ static int vls = true;
>  module_param(vls, int, 0444);
>  
>  /* enable/disable Virtual GIF */
> -static int vgif = true;
> +int vgif = true;
>  module_param(vgif, int, 0444);

...

> @@ -453,14 +454,9 @@ static inline bool svm_is_intercept(struct vcpu_svm *svm, int bit)
>  	return vmcb_is_intercept(&svm->vmcb->control, bit);
>  }
>  
> -static inline bool vgif_enabled(struct vcpu_svm *svm)
> -{
> -	return !!(svm->vmcb->control.int_ctl & V_GIF_ENABLE_MASK);
