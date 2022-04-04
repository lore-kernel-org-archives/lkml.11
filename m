Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716AAC4707E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Apr 2022 21:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382587AbiDDVba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379295AbiDDQzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:55:31 -0400
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2459214;
        Mon,  4 Apr 2022 09:53:33 -0700 (PDT)
Received: from MUA
        by vps-vb.mhejs.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1nbPxB-0002ta-TY; Mon, 04 Apr 2022 18:53:21 +0200
Message-ID: <a3cf781b-0b1a-0bba-6b37-12666c7fc154@maciej.szmigiero.name>
Date:   Mon, 4 Apr 2022 18:53:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 5/8] KVM: SVM: Re-inject INT3/INTO instead of retrying the
 instruction
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220402010903.727604-1-seanjc@google.com>
 <20220402010903.727604-6-seanjc@google.com>
 <a47217da0b6db4f1b6b6c69a9dc38350b13ac17c.camel@redhat.com>
 <YkshgrUaF4+MrrXf@google.com>
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
In-Reply-To: <YkshgrUaF4+MrrXf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> index 47e7427d0395..a770a1c7ddd2 100644
>>> --- a/arch/x86/kvm/svm/svm.h
>>> +++ b/arch/x86/kvm/svm/svm.h
>>> @@ -230,8 +230,8 @@ struct vcpu_svm {
>>>   	bool nmi_singlestep;
>>>   	u64 nmi_singlestep_guest_rflags;
>>>   
>>> -	unsigned int3_injected;
>>> -	unsigned long int3_rip;
>>> +	unsigned soft_int_injected;
>>> +	unsigned long soft_int_linear_rip;
>>>   
>>>   	/* optional nested SVM features that are enabled for this guest  */
>>>   	bool nrips_enabled                : 1;
>>
>>
>> I mostly agree with this patch, but think that it doesn't address the
>> original issue that Maciej wanted to address:
>>
>> Suppose that there is *no* instruction in L2 code which caused the software
>> exception, but rather L1 set arbitrary next_rip, and set EVENTINJ to software
>> exception with some vector, and that injection got interrupted.
>>
>> I don't think that this code will support this.
> 
> Argh, you're right.  Maciej's selftest injects without an instruction, but it doesn't
> configure the scenario where that injection fails due to an exception+VM-Exit that
> isn't intercepted by L1 and is handled by L0.  The event_inj test gets the coverage
> for the latter, but always has a backing instruction.

Still reviewing the whole patch set, but want to clear this point quickly:
The selftest does have an implicit intervening NPF (handled by L0) while
injecting the first L1 -> L2 event.

Thanks,
Maciej
