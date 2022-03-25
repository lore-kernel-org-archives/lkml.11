Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493C2C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 16:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376988AbiCYQsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 12:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376881AbiCYQsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 12:48:22 -0400
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr [80.12.242.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A8DE339F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 09:46:47 -0700 (PDT)
Received: from [192.168.1.18] ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id Xn5Bn3MiVZQwWXn5Bnlbxv; Fri, 25 Mar 2022 17:46:45 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 25 Mar 2022 17:46:45 +0100
X-ME-IP: 90.126.236.122
Message-ID: <7f25e53a-6d18-6ffd-7e0e-2cce5e632ffc@wanadoo.fr>
Date:   Fri, 25 Mar 2022 17:46:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH] KVM: x86/mmu: fix general protection fault in
 kvm_mmu_uninit_tdp_mmu
Content-Language: fr
To:     Pavel Skripkin <paskripkin@gmail.com>, pbonzini@redhat.com,
        seanjc@google.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+717ed82268812a643b28@syzkaller.appspotmail.com
References: <20220325163815.3514-1-paskripkin@gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220325163815.3514-1-paskripkin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 25/03/2022 à 17:38, Pavel Skripkin a écrit :
> Syzbot reported GPF in kvm_mmu_uninit_tdp_mmu(), which is caused by
> passing NULL pointer to flush_workqueue().
> 
> tdp_mmu_zap_wq is allocated via alloc_workqueue() which may fail. There
> is no error hanling and kvm_mmu_uninit_tdp_mmu() return value is simply
> ignored. Even all kvm_*_init_vm() functions are void, so the easiest
> solution is to check that tdp_mmu_zap_wq is valid pointer before passing
> it somewhere.
> 
> Fixes: 22b94c4b63eb ("KVM: x86/mmu: Zap invalidated roots via asynchronous worker")
> Reported-and-tested-by: syzbot+717ed82268812a643b28@syzkaller.appspotmail.com
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
>   arch/x86/kvm/mmu/tdp_mmu.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index e7e7876251b3..b3e8ff7ac5b0 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -48,8 +48,10 @@ void kvm_mmu_uninit_tdp_mmu(struct kvm *kvm)
>   	if (!kvm->arch.tdp_mmu_enabled)
>   		return;
>   
> -	flush_workqueue(kvm->arch.tdp_mmu_zap_wq);
> -	destroy_workqueue(kvm->arch.tdp_mmu_zap_wq);
> +	if (kvm->arch.tdp_mmu_zap_wq) {
> +		flush_workqueue(kvm->arch.tdp_mmu_zap_wq);
> +		destroy_workqueue(kvm->arch.tdp_mmu_zap_wq);

Hi,
unrelated to the patch, but flush_workqueue() is redundant and could be 
removed.
destroy_workqueue() already drains the queue.

Just my 2c,
CJ

> +	}
>   
>   	WARN_ON(!list_empty(&kvm->arch.tdp_mmu_pages));
>   	WARN_ON(!list_empty(&kvm->arch.tdp_mmu_roots));
> @@ -119,9 +121,11 @@ static void tdp_mmu_zap_root_work(struct work_struct *work)
>   
>   static void tdp_mmu_schedule_zap_root(struct kvm *kvm, struct kvm_mmu_page *root)
>   {
> -	root->tdp_mmu_async_data = kvm;
> -	INIT_WORK(&root->tdp_mmu_async_work, tdp_mmu_zap_root_work);
> -	queue_work(kvm->arch.tdp_mmu_zap_wq, &root->tdp_mmu_async_work);
> +	if (kvm->arch.tdp_mmu_zap_wq) {
> +		root->tdp_mmu_async_data = kvm;
> +		INIT_WORK(&root->tdp_mmu_async_work, tdp_mmu_zap_root_work);
> +		queue_work(kvm->arch.tdp_mmu_zap_wq, &root->tdp_mmu_async_work);
> +	}
>   }
>   
>   static inline bool kvm_tdp_root_mark_invalid(struct kvm_mmu_page *page)

