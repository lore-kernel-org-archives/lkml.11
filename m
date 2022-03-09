Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2F9C433FE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 18:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbiCISPW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 13:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbiCISPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:15:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32552BF97C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 10:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646849654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BiL4ATUz1KNDAzAGSlQ9x7yx5LofUJYOal186YuSgkA=;
        b=AeHqrKBfvQz7jpm5z30vXkwo67X3EIH9znaeRkQuIRm0fXAbUrpp7FSaL8r9mJPJMUAqtx
        n+3Minzq0+FeoDPGLY7LtQIupjKuL9GduErbEeHeJ6YPh//pikiHDV3wbZqj1FYqBJ95d1
        ODLepm2Xyp7ggIUrA0dDo1jso7N9+nI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-RyZsAxO9PRiLijzr435wWA-1; Wed, 09 Mar 2022 13:14:09 -0500
X-MC-Unique: RyZsAxO9PRiLijzr435wWA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EED8880205C;
        Wed,  9 Mar 2022 18:14:06 +0000 (UTC)
Received: from starship (unknown [10.40.192.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B98FF7F0DB;
        Wed,  9 Mar 2022 18:14:01 +0000 (UTC)
Message-ID: <ff76ebe610fd46c1e6d7f3eee436426056961747.camel@redhat.com>
Subject: Re: [PATCH v3 7/7] KVM: x86: SVM: allow AVIC to co-exist with a
 nested guest running
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jim Mattson <jmattson@google.com>, x86@kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>
Date:   Wed, 09 Mar 2022 20:14:00 +0200
In-Reply-To: <bdb527f3-9281-1f25-c6c7-a8538455bfa3@redhat.com>
References: <20220301143650.143749-1-mlevitsk@redhat.com>
         <20220301143650.143749-8-mlevitsk@redhat.com>
         <bdb527f3-9281-1f25-c6c7-a8538455bfa3@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-03-09 at 14:50 +0100, Paolo Bonzini wrote:
> On 3/1/22 15:36, Maxim Levitsky wrote:
> >   	bool activate;
> > @@ -9690,7 +9695,9 @@ void kvm_vcpu_update_apicv(struct kvm_vcpu *vcpu)
> >   
> >   	down_read(&vcpu->kvm->arch.apicv_update_lock);
> >   
> > -	activate = kvm_apicv_activated(vcpu->kvm);
> > +	activate = kvm_apicv_activated(vcpu->kvm) &&
> > +		   !vcpu_has_apicv_inhibit_condition(vcpu);
> > +
> >   	if (vcpu->arch.apicv_active == activate)
> >   		goto out;
> >   
> 
> Perhaps the callback could be named vcpu_apicv_inhibit_reasons, and it would
> return APICV_INHIBIT_REASON_NESTED?  Then instead of the new function
> vcpu_has_apicv_inhibit_condition(), you would have
> 
> bool kvm_vcpu_apicv_activated(struct vcpu_kvm *kvm)
> {
> 	ulong vm_reasons = READ_ONCE(vcpu->kvm->arch.apicv_inhibit_reasons);
> 	ulong vcpu_reasons = static_call(kvm_x86_vcpu_apicv_inhibit_reasons)(vcpu);
>          return (vm_reasons | vcpu_reasons) == 0;
> }
> EXPORT_SYMBOL_GPL(kvm_cpu_apicv_activated);
> 
> It's mostly aesthetics, but it would also be a bit more self explanatory I think.
> 
> Paolo
> 

This is a great idea, I will do it in next version.
Thanks!

Best regards,
	Maxim Levitsky

