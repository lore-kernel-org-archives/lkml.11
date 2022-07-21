Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C1EC43334
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jul 2022 22:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbiGUWaX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jul 2022 18:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbiGUWaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 18:30:18 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF9226AD8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 15:30:17 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id h132so2903694pgc.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 15:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DXbmVLSQ/kF6PAAfuZldRiLPfHWkw3KMuA2Cj4p5KCc=;
        b=gq7l1cK+W8oZFwCWYHkKKHapRWrJZsiH/EliM+zZ13wNhqSehiBcUBZw5XgleoWibP
         VYKByIf9+6UyxiAKHKNiSzpoUsM+a4l911b6k+Pfz/VK0TVCfOYAu/x3fuKKnV5Klyv2
         EgekyMc7wcSwbRzn6f7Uu5tNRDq2BvH/J3YXJ4Y0SbqHSlGJMBwqc6NB5b2tOalWGpn+
         UrfZaAznGUDo7UPqQS+xabwQXm1JiR/aEhytyvYde76khXg6u5kEX5aWnKMk6jvBeHNb
         1M5VdxFgdU6f5D/EkytEmavNsZi3Rnrm133ecB29iRoX2GOzE6VQh013NjV3Bqdw/jOS
         Su9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DXbmVLSQ/kF6PAAfuZldRiLPfHWkw3KMuA2Cj4p5KCc=;
        b=m/2RHdG2DQ8XptciaMGxxsLWtEwY0dk+VlU+a6goeygjFVUtyBU18qM87Ye6HvJeRQ
         wJpaL5sCu8be5GuXJ6VnBNKNL02aoHUKmz+wiU4UGXmGyG4fmCPjSxEF6WKr9Bd1fpf9
         puREwp6RbPXtxIzAcP4Dk4j1+oYN4j245Y7v78yM4va5wR/28tC9QSdfq9XwUrMsOttZ
         x9Xovj9W6JxYrMzW50dADLFL7raySaeA6qsOjuSUui0CyZ2cKEjv/7BGYfDHXjh4HN4h
         XNFSAH8zbVHOxpNmv2oNF5I8xA5Pxh8vLQ65MAQ7sIqqLpC/q8hHOJrfyi3wh+b1S4HA
         zcyw==
X-Gm-Message-State: AJIora9bE1lrQ5RUegZcv/U6CkiVMcgdxool7iLPTAI7zoHOBhHVR5Kw
        jACBx5HKCDDXc2Hcp4qDCqgIEg==
X-Google-Smtp-Source: AGRyM1uwTVH1mO8sOka50FJ8zNCt0zM/avdSqJaZ8jKo9PDLwXTxlupeYMDuwIh2AxGHwGUJ2PJDWQ==
X-Received: by 2002:a05:6a00:1a44:b0:52a:ecd5:bbef with SMTP id h4-20020a056a001a4400b0052aecd5bbefmr382535pfv.28.1658442616341;
        Thu, 21 Jul 2022 15:30:16 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id x75-20020a62864e000000b0052b9747e0d1sm2248424pfd.189.2022.07.21.15.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 15:30:15 -0700 (PDT)
Date:   Thu, 21 Jul 2022 22:30:11 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 16/25] KVM: VMX: Move
 CPU_BASED_CR8_{LOAD,STORE}_EXITING filtering out of setup_vmcs_config()
Message-ID: <YtnTc/L5u5AuUhYN@google.com>
References: <20220714091327.1085353-1-vkuznets@redhat.com>
 <20220714091327.1085353-17-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714091327.1085353-17-vkuznets@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022, Vitaly Kuznetsov wrote:
> As a preparation to reusing the result of setup_vmcs_config() in
> nested VMX MSR setup, move CPU_BASED_CR8_{LOAD,STORE}_EXITING filtering
> to vmx_exec_control().
> 
> No functional change intended.
> 
> Reviewed-by: Jim Mattson <jmattson@google.com>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
