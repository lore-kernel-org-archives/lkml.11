Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EE2C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 18 May 2022 15:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239597AbiERPuw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 May 2022 11:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239592AbiERPuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 11:50:50 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A94DDE8D
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 08:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MAUXfcUkVFDIvFNCsb81T0316Hl0b9jykVcFYkHqtP4=; b=ZLZ4oNEPDpt5urvbAVTnE94zSx
        dDIerDQOOl7Run6Tx46yCBRYkZ1KpwfVcAA8uXCxZY+uwhiu4pyWLzu08uwa6ZCWSxyXRzrpWuKk4
        B9rfwYQS0i65gVIL02lUtH1OnctCd1QcRQgxnoaBVK8OiO9RbW9STaQhjrQHI0HN/S+8Ws+lvTW9u
        7elJUXgz9i+3C6K08jZ2h3uI7YOuHGXana4aqFuzvtWUOjSwC/jRfw0bBGOS3T54XpaJAYWDHfNv8
        YZNGpD0ssd+sqNMOtVzLEUFXZV5IuG9WJ1Tjxqi84tZ3rwxSVpwvH2e1AVKnsmZittq89FDJvZ5Fc
        SFvr/6kA==;
Received: from 200-161-159-120.dsl.telesp.net.br ([200.161.159.120] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nrLwQ-00A7FJ-IK; Wed, 18 May 2022 17:50:26 +0200
Message-ID: <f0a8918a-f4f9-d852-27be-52a095a9e59f@igalia.com>
Date:   Wed, 18 May 2022 12:50:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 1/3] x86/crash: Disable virt in core NMI crash handler
 to avoid double shootdown
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20220518001647.1291448-1-seanjc@google.com>
 <20220518001647.1291448-2-seanjc@google.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220518001647.1291448-2-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2022 21:16, Sean Christopherson wrote:
> [...]
> Fixes: ed72736183c4 ("x86/reboot: Force all cpus to exit VMX root if VMX is supported)
> Cc: stable@vger.kernel.org
> Reported-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Link: https://lore.kernel.org/all/20220427224924.592546-2-gpiccoli@igalia.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/include/asm/reboot.h |  1 +
>  arch/x86/kernel/crash.c       | 16 +--------
>  arch/x86/kernel/reboot.c      | 66 ++++++++++++++++++++++++++++-------
>  3 files changed, 56 insertions(+), 27 deletions(-)

Thanks Sean, great patch! It's working fine according to my tests, and
the comments made the code very clear.
Feel free to add:

Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

