Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BCCC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 02:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1850436AbiDFCwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 22:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1588284AbiDFAPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 20:15:11 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C09616F6E2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 15:40:06 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id b15so790415pfm.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 15:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mja/7Hv2yue+rVJAx6K5Hvn3mkY+RhBRGz47vlxkKUQ=;
        b=EkH6rRJ4ouJTgRc1oiSzVnRlg71jkUg3f2CN4kywiE9HLy2OfRI8r+5uutp20X2IXm
         rx/o6a1D4/Tos+AyAQJQ74thxLA67pi3cAVX+upPp0A73Opew9btQh9r0Zmicpl3Gbs8
         GWU5JPI/vhZQNO5F11tWgzsMFHqAl+FHQ6WpB5y81CDNCpsB1QNYxW+non1H0tiMUGpo
         Q8Cd8qVXLVdr5+B+YTgB0QOv5nzu7CelWg+Df8gkDtb14o7yF7sbbQT4G+P0tuBIFDuX
         qJwN11Jp8y5MyTV9INkUXXejBHNC00qkNyKp0uPXAgBSqHJA8pHig/7AhX9CUkFSSRB4
         QHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mja/7Hv2yue+rVJAx6K5Hvn3mkY+RhBRGz47vlxkKUQ=;
        b=n1xgMhmlhm+JWLaPx94xt3ad9VJoi8phhQLYVllENvsyI5UpxWGVbmnRPBtIlmmncB
         /j63qvSQmuIDLUdN2WesA373YqXVRxiEk5YqSnAV3SS95T6KwxlbE0wxrb5NP5Lz2HIl
         f3UbOMrV4VIzxL6w7rutWSGdaDbxrG59u+E8PITeIQh4e/Xjwe3jbet9B4mbcH/1G8lf
         a0PR8CEv4xqSXHA9xYAkTrmU06bETz+RJ9SIpCSlW2Z+Eh7lddUlwOUyblWb/7d8zdvH
         00/py8tpa0N21klsmRddsWCBfaNrz0FA+M1OtJMQLYWEGxENfRQFuU8ZQYOHMUjzSmj2
         pstQ==
X-Gm-Message-State: AOAM530F7q9FGiQ//VHbKu5jynZlbpePcELZqh0mnZZJY0WKZJ/B7o17
        tiruynXg5PrNSRq2RBqKHQKCuA==
X-Google-Smtp-Source: ABdhPJybMyhTNJNxDqSE/8X856+gFMewDiBCEEDwkiMSEl/dfJJtft8+rQ37c7S10gJJi3tz4MURXQ==
X-Received: by 2002:a05:6a00:3316:b0:4fa:80fd:f3f6 with SMTP id cq22-20020a056a00331600b004fa80fdf3f6mr5642757pfb.65.1649198404907;
        Tue, 05 Apr 2022 15:40:04 -0700 (PDT)
Received: from google.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id k3-20020a056a00168300b004f7e60da26csm17089109pfc.182.2022.04.05.15.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 15:40:04 -0700 (PDT)
Date:   Tue, 5 Apr 2022 22:40:00 +0000
From:   David Matlack <dmatlack@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>
Subject: Re: [PATCH v3 07/11] KVM: x86/MMU: Factor out updating NX hugepages
 state for a VM
Message-ID: <YkzFQBjbt081HhbG@google.com>
References: <20220330174621.1567317-1-bgardon@google.com>
 <20220330174621.1567317-8-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330174621.1567317-8-bgardon@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 10:46:17AM -0700, Ben Gardon wrote:
> Factor out the code to update the NX hugepages state for an individual
> VM. This will be expanded in future commits to allow per-VM control of
> Nx hugepages.
> 
> No functional change intended.
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>

Reviewed-by: David Matlack <dmatlack@google.com>

> ---
>  arch/x86/kvm/mmu/mmu.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index dbf46dd98618..af428cb65b3f 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -6202,6 +6202,15 @@ static void __set_nx_huge_pages(bool val)
>  	nx_huge_pages = itlb_multihit_kvm_mitigation = val;
>  }
>  
> +static void kvm_update_nx_huge_pages(struct kvm *kvm)
> +{
> +	mutex_lock(&kvm->slots_lock);
> +	kvm_mmu_zap_all_fast(kvm);
> +	mutex_unlock(&kvm->slots_lock);
> +
> +	wake_up_process(kvm->arch.nx_lpage_recovery_thread);
> +}
> +
>  static int set_nx_huge_pages(const char *val, const struct kernel_param *kp)
>  {
>  	bool old_val = nx_huge_pages;
> @@ -6224,13 +6233,9 @@ static int set_nx_huge_pages(const char *val, const struct kernel_param *kp)
>  
>  		mutex_lock(&kvm_lock);
>  
> -		list_for_each_entry(kvm, &vm_list, vm_list) {
> -			mutex_lock(&kvm->slots_lock);
> -			kvm_mmu_zap_all_fast(kvm);
> -			mutex_unlock(&kvm->slots_lock);
> +		list_for_each_entry(kvm, &vm_list, vm_list)
> +			kvm_update_nx_huge_pages(kvm);
>  
> -			wake_up_process(kvm->arch.nx_lpage_recovery_thread);
> -		}
>  		mutex_unlock(&kvm_lock);
>  	}
>  
> -- 
> 2.35.1.1021.g381101b075-goog
> 
