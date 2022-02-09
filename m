Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AB5C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 20:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbiBIUt0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Feb 2022 15:49:26 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbiBIUtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:49:23 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86809C05CBA0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 12:49:26 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id y17so3337061plg.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 12:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=usai5WVQErwk4Ew2fX/fOjUw6I8vvZIt0nVcprr1jB8=;
        b=VqQ4AQV9kyt+0LUwBHfYIcCdy6HaR52lzHPXQid7Q9Se19pBiE9Mi/rh3L+BTrlcsA
         3zhWV/p7cu/zpDWzo7seoNfyvraJeUxi6CYB6mkMUCbqqhUhq6m/rjbyx/IUrHKoVXof
         lSkYyXL/SVmmvlJQ902YhuNCzptvPCHTOSwCPPsN8v87m068+MhEZHA/NU8a1bXJaf9P
         uKu6stWAubyB61SmQAKl0PriItNTzKJNWLayosXH27IGEVSnYux3NhyrI5glY56g2pAl
         uGtJ7pB8scL4hzREiHv7FcQjA7rxLGqS4qtNTCbZKzEmQmICwvLEIphJRmERaAHp85uu
         QD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=usai5WVQErwk4Ew2fX/fOjUw6I8vvZIt0nVcprr1jB8=;
        b=vB2XsxerdzsmFrU0xmoEhq00aMPLTl8OQ6+kv9BuQX+afgzyF5uMUDfJjZjDiQDsoa
         M5mwS4h80ILhZEBJ76KePtDToacBQu+zOftbf1e2tgLaQT2Ov1gaNiFLfP0476+e4mf0
         A4zDqM/XrFSbCIitJ61ET+Eej8a9auQgz6/I8mZj9SeixvhvdFV3SRy+I/ZZMf579CH3
         aHV/OAcPPaEE2LVCtEN+JDES5i7cy7dmi+0Pb3ssNTqR1BC4EpTgDc5dg9lZvpbOyywW
         sKTH9fUiudzmaGPNnYcfLXJxI5aO2Rt1A6AiVRpxUEQ5TZJ2uWP1PJ+AT5Aegmm4U8AC
         CRaA==
X-Gm-Message-State: AOAM533ZiTjWTkW27CC9f4roFQywPZTP9lZMpX7XX20wgIAShEg3geHN
        cYqWfqLpzb+NcVWnwvjO0HqcpA==
X-Google-Smtp-Source: ABdhPJw/3lEaJcN7mZhLmzhDeUcjhx87dXVoMvRWh5thi6wmzVXTU+ApsU/9c7brBYgoM6y2N1AWpQ==
X-Received: by 2002:a17:90a:ab90:: with SMTP id n16mr5432152pjq.229.1644439765909;
        Wed, 09 Feb 2022 12:49:25 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id j15sm22379244pfj.102.2022.02.09.12.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 12:49:25 -0800 (PST)
Date:   Wed, 9 Feb 2022 20:49:21 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Gao <chao.gao@intel.com>
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, kevin.tian@intel.com,
        tglx@linutronix.de, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] KVM: Do compatibility checks on hotplugged CPUs
Message-ID: <YgQo0SB59SCRUPQ3@google.com>
References: <20220209074109.453116-1-chao.gao@intel.com>
 <20220209074109.453116-6-chao.gao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209074109.453116-6-chao.gao@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022, Chao Gao wrote:
> At init time, KVM does compatibility checks to ensure that all online
> CPUs support hardware virtualization and a common set of features. But
> KVM uses hotplugged CPUs without such compatibility checks. On Intel
> CPUs, this leads to #GP if the hotplugged CPU doesn't support VMX or
> vmentry failure if the hotplugged CPU doesn't meet minimal feature
> requirements.
> 
> Do compatibility checks when onlining a CPU and abort the online process
> if the hotplugged CPU is incompatible with online CPUs.
> 
> CPU hotplug is disabled during hardware_enable_all() to prevent the corner
> case as shown below. A hotplugged CPU marks itself online in
> cpu_online_mask (1) and enables interrupt (2) before invoking callbacks
> registered in ONLINE section (3). So, if hardware_enable_all() is invoked
> on another CPU right after (2), then on_each_cpu() in hardware_enable_all()
> invokes hardware_enable_nolock() on the hotplugged CPU before
> kvm_online_cpu() is called. This makes the CPU escape from compatibility
> checks, which is risky.
> 
> 	start_secondary { ...
> 		set_cpu_online(smp_processor_id(), true); <- 1
> 		...
> 		local_irq_enable();  <- 2
> 		...
> 		cpu_startup_entry(CPUHP_AP_ONLINE_IDLE); <- 3
> 	}
> 
> Keep compatibility checks at KVM init time. It can help to find
> incompatibility issues earlier and refuse to load arch KVM module
> (e.g., kvm-intel).
> 
> Loosen the WARN_ON in kvm_arch_check_processor_compat so that it
> can be invoked from KVM's CPU hotplug callback (i.e., kvm_online_cpu).
> 
> Opportunistically, add a pr_err() for setup_vmcs_config() path in
> vmx_check_processor_compatibility() so that each possible error path has
> its own error message. Convert printk(KERN_ERR ... to pr_err to please
> checkpatch.pl
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
