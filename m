Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A3ECCA481
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jul 2022 14:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239189AbiGNOnO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jul 2022 10:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239171AbiGNOnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:43:10 -0400
X-Greylist: delayed 1798 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Jul 2022 07:43:07 PDT
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1492458870;
        Thu, 14 Jul 2022 07:43:07 -0700 (PDT)
Received: from MUA
        by vps-vb.mhejs.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1oBzEp-0000eY-FW; Thu, 14 Jul 2022 15:50:43 +0200
Message-ID: <52d44630-21ad-1291-4185-40d5728eaea6@maciej.szmigiero.name>
Date:   Thu, 14 Jul 2022 15:50:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] KVM: SVM: fix task switch emulation on INTn instruction.
Content-Language: en-US
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <seanjc@google.com>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        kvm@vger.kernel.org
References: <20220714124453.188655-1-mlevitsk@redhat.com>
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
In-Reply-To: <20220714124453.188655-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.07.2022 14:44, Maxim Levitsky wrote:
> Recently KVM's SVM code switched to re-injecting software interrupt events,
> if something prevented their delivery.
> 
> Task switch due to task gate in the IDT, however is an exception
> to this rule, because in this case, INTn instruction causes
> a task switch intercept and its emulation completes the INTn
> emulation as well.
> 
> Add a missing case to task_switch_interception for that.
> 
> This fixes 32 bit kvm unit test taskswitch2.
> 
> Fixes: 7e5b5ef8dca322 ("KVM: SVM: Re-inject INTn instead of retrying the insn on "failure"")
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---

That's a good catch, your patch looks totally sensible to me.
People running Win 3.x or OS/2 on top of KVM will surely be grateful for it :)

Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

Thanks,
Maciej
