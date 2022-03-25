Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902E8C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 16:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377017AbiCYQwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 12:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377002AbiCYQwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 12:52:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF51DC12D9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 09:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648227025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tEjq/KiPSXWL3MlMEJXSJIy04cv7r0dUWkKt5cvZ2AM=;
        b=Q0WcPgGtVyIb26freMtM8HpSfPBhxea9YZiWrOSUUtEMaLAIx5k+UAjsw4uZG/PIXNkDGe
        trC8kj/4+J0TO85wjiFj2DzC6TdnuAdmcLOF6c8uhbgLJ0Snx+1o5zM+HV7dgZFSlaincC
        nQphILrC1ULFsf8z88fYO2vF5R25vuw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-Fcw94tinPSiUbTqCFHsBTw-1; Fri, 25 Mar 2022 12:50:18 -0400
X-MC-Unique: Fcw94tinPSiUbTqCFHsBTw-1
Received: by mail-ed1-f69.google.com with SMTP id u13-20020a50a40d000000b00419028f7f96so5244392edb.21
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 09:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tEjq/KiPSXWL3MlMEJXSJIy04cv7r0dUWkKt5cvZ2AM=;
        b=RImQ5tA3hHNgL/u2m/XbUDbpYaA+54wrq5GFcqYGYqfMzSXyA0+uFnumAflEd04+Xr
         EI/Q9KLeIc/CFrWg9INYVj618GCXSv6b/1TxaR+FDyMgq1JGWMWSYYjuJbR+sG+hS+VX
         Yr2Q5cwBifDH2kxIvtWq9+57nTB61a4cdg+VH40cMlVDkcLr05dgiJcxcOVO3nHnY+q4
         DH2Xd4ia4XGtZYGYHq3J+tBpzviCJ7pq7H/J/d427dDiV08DAUB8WVrrzQelS7qi/ILR
         b3ZNF8lMOnwAgVD5KsUPRgmB5gOzWtO0YZUjkQ1RQnQGlX0OwWLF+8AM5s7KUCT1ojNK
         MNLQ==
X-Gm-Message-State: AOAM531C3cLhaoJQkBatt8h13xS6hLG6xvTMszWUeInqCOpvdrC5Canf
        b9PY3lVJ1i5BVO5DOW78goxBf5TAWUzG/eRobyzxJ8AKmYXIcMkuwusER3rqEJwwa5YC0guGt9v
        RFgr8GZ0io16eGYIQZ+uh4cdS
X-Received: by 2002:aa7:cc96:0:b0:410:b9ac:241 with SMTP id p22-20020aa7cc96000000b00410b9ac0241mr14368991edt.246.1648227017509;
        Fri, 25 Mar 2022 09:50:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtI7/PWnIA3ZNXxg4nfFvrZQa1n7rQsKtbxPki/ewcdN3qvWtTFHO7bqVxVhCh9We4XHqzJw==
X-Received: by 2002:aa7:cc96:0:b0:410:b9ac:241 with SMTP id p22-20020aa7cc96000000b00410b9ac0241mr14368975edt.246.1648227017312;
        Fri, 25 Mar 2022 09:50:17 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id hs12-20020a1709073e8c00b006dfd8074d27sm2501958ejc.79.2022.03.25.09.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 09:50:16 -0700 (PDT)
Message-ID: <53cc074f-350f-5fa8-1ee4-c33921f17cb1@redhat.com>
Date:   Fri, 25 Mar 2022 17:50:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH] KVM: x86/mmu: fix general protection fault in
 kvm_mmu_uninit_tdp_mmu
Content-Language: en-US
To:     Pavel Skripkin <paskripkin@gmail.com>, seanjc@google.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+717ed82268812a643b28@syzkaller.appspotmail.com
References: <20220325163815.3514-1-paskripkin@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220325163815.3514-1-paskripkin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/22 17:38, Pavel Skripkin wrote:
> Syzbot reported GPF in kvm_mmu_uninit_tdp_mmu(), which is caused by
> passing NULL pointer to flush_workqueue().
> 
> tdp_mmu_zap_wq is allocated via alloc_workqueue() which may fail. There
> is no error hanling and kvm_mmu_uninit_tdp_mmu() return value is simply
> ignored. Even all kvm_*_init_vm() functions are void, so the easiest
> solution is to check that tdp_mmu_zap_wq is valid pointer before passing
> it somewhere.

Thanks for the analysis, but not scheduling the work item in 
tdp_mmu_schedule_zap_root is broken; you can't just let the roots 
survive (KVM uses its own workqueue because it needs to work item to 
complete has to flush it before kvm_mmu_zap_all_fast returns).

I'll fix it properly by propagating the error up to kvm_mmu_init_vm and 
kvm_arch_init_vm,

Thanks,

Paolo

