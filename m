Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D628AC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Mar 2022 19:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349785AbiCHTD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Mar 2022 14:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241965AbiCHTD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:03:56 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E460E205FD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 11:02:58 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id t5so190549pfg.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 11:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AjsdF6LONvopWFuq2yc02VRVtbwTb9Hnb79pbwbkLf8=;
        b=PO47163k6zUDdC9xGZTAR9huWsfmjXuzVtuLwjSqk5JeZETFDAX2YsxnBAh6vPkTin
         iyc+YLw8NPoYNuQqnEs+gCG1ri09qr8pGQ56zQA/P1+/qcIYsBHOEQscHoNlYYfxlYLm
         ZbZ3y3MXs9R3ZhUElI6AEpAgq/yrNNKbl8uQGp5xH+5PsDYHIgwcbtkcoJ5FO2bjziar
         gxFQ3EAwr00/oKe85ePiTg2670CM2lcvN06snbraKQGTy0FmoubRONhY7qjoybtqAkdo
         FaLQ7tasHnaXmPNLKuPhBYmVfg9dSYvjv6yZeWXP/AErVuZ8j1uMsq4WO7ltTgoCaCdk
         oEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AjsdF6LONvopWFuq2yc02VRVtbwTb9Hnb79pbwbkLf8=;
        b=J6N5F3ilPisI5ri814VPuBQ0Riza/OgAhQ8DkQ12RVQNERAVv91ImG4YvWhwnG231S
         4Oruq6U9z8FIhr3WnoUeadODhi/AIZht5r/nbmO9knt/2T86dHPGzJLh0xIUAhdpMyqf
         /2v4dUpap3qaKfqgXPkYgFt+CToD77aIgbhOP6RXFcsu9YISOLhHbVz7mzIpM67Yxucq
         3GeMlgAdwEVYt+qcE6w6gGzM/t5X3oxEGT68P8uuYEuXkJelB843y9nU6NuzgRP1U72F
         6r4ZAlRT0pp5HlDJx5Slk6jOAWsujopFSbGcRTGJaJ+5KQ7Ww16YzbYtYCV35TXpj54e
         qBPw==
X-Gm-Message-State: AOAM530cf0fx089dyWoUyTuKiSi0P4gOz6pwK/EKgT+akXo7nNpKnKuV
        hovcSeN/UkNJirehJtcHuCtvLg==
X-Google-Smtp-Source: ABdhPJx3aKJj4teJ5xmwq2Uae1y+fsyuqJX/RwoHiov38zkBIRzAxxRKRpCLNelc4VvQs3AEKUAlRg==
X-Received: by 2002:aa7:918f:0:b0:4cc:3c00:b2dd with SMTP id x15-20020aa7918f000000b004cc3c00b2ddmr19875384pfa.77.1646766178219;
        Tue, 08 Mar 2022 11:02:58 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id s25-20020a056a00179900b004f737ce5c1asm2415403pfg.73.2022.03.08.11.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 11:02:57 -0800 (PST)
Date:   Tue, 8 Mar 2022 19:02:53 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        dmatlack@google.com
Subject: Re: [PATCH v2 15/25] KVM: x86/mmu: remove extended bits from
 mmu_role, rename field
Message-ID: <YieoXYBFyo9pZhhX@google.com>
References: <20220221162243.683208-1-pbonzini@redhat.com>
 <20220221162243.683208-16-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221162243.683208-16-pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022, Paolo Bonzini wrote:
> mmu_role represents the role of the root of the page tables.
> It does not need any extended bits, as those govern only KVM's
> page table walking; the is_* functions used for page table
> walking always use the CPU mode.
> 
> ext.valid is not present anymore in the MMU role, but an
> all-zero MMU role is impossible because the level field is
> never zero in the MMU role.

Probably worth adding a blurb to clarify that the level is zero in the extended
(guest) role if paging is disabled in the guest?

> So just zap the whole mmu_role
> in order to force invalidation after CPUID is updated.
> 
> While making this change, which requires touching almost every
> occurrence of "mmu_role", rename it to "root_role".

Heh, can you please wrap closer to 75 chars?  Your d20 rolls came up low again.

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> @@ -4764,7 +4763,7 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu,
>  	reset_tdp_shadow_zero_bits_mask(context);
>  }
>  
> -static union kvm_mmu_role
> +static union kvm_mmu_page_role
>  kvm_calc_shadow_mmu_root_page_role(struct kvm_vcpu *vcpu,
>  				   union kvm_mmu_role role)
>  {
> @@ -4785,19 +4784,19 @@ kvm_calc_shadow_mmu_root_page_role(struct kvm_vcpu *vcpu,
>  	 * MMU contexts.
>  	 */
>  	role.base.efer_nx = true;
> -	return role;
> +	return role.base;

For both cases where the root role is derived from the cpu_role, can we make
an explicit copy of the "base" as root_role, and then do mods on that?  Doing
modification on the incoming role is unnecessarily hard to read IMO, I doubt the
compiler even generates different code.

For me, this makes it more obvious that the root_role is derived from the cpu_role.

static union kvm_mmu_page_role
kvm_calc_shadow_mmu_root_page_role(struct kvm_vcpu *vcpu,
				   const union kvm_mmu_role cpu_role)
{
	union kvm_mmu_page_role root_role = cpu_role.base;

	if (!cpu_role.ext.efer_lma)
		root_role.level = PT32E_ROOT_LEVEL;
	else if (cpu_role.ext.cr4_la57)
		root_role.level = PT64_ROOT_5LEVEL;
	else
		root_role.level = PT64_ROOT_4LEVEL;

	/*
	 * KVM forces EFER.NX=1 when TDP is disabled, reflect it in the MMU role.
	 * KVM uses NX when TDP is disabled to handle a variety of scenarios,
	 * notably for huge SPTEs if iTLB multi-hit mitigation is enabled and
	 * to generate correct permissions for CR0.WP=0/CR4.SMEP=1/EFER.NX=0.
	 * The iTLB multi-hit workaround can be toggled at any time, so assume
	 * NX can be used by any non-nested shadow MMU to avoid having to reset
	 * MMU contexts.
	 */
	root_role.efer_nx = true;
	return root_role;
}

static union kvm_mmu_page_role
kvm_calc_shadow_npt_root_page_role(struct kvm_vcpu *vcpu,
				   const union kvm_mmu_role cpu_role)
{
	union kvm_mmu_page_role root_role = cpu_role.base;

	WARN_ON_ONCE(root_role.direct);
	root_role.level = kvm_mmu_get_tdp_level(vcpu);
	return root_role;
}

