Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FB9C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 14:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbiCIOtZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 09:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbiCIOtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 09:49:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDA1B4ECDF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 06:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646837304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kNOo8tfVdsLHz4CQT9H/dwfufzZQMSYbZ0RQG+jvDRA=;
        b=LmxtdvHjuXz259xN0Lwi7/Oc/lqx2hKDSwtT5vomyd+Gx9eyj0hTyUW23BRwWI/4r1W7cN
        eLjvHyl+qOPtqWj5L6VJczh4QPMZWvlec9m+N5xxSNMqVKcC+mpKS/Xr19QT/Ac8XurnEb
        zBIxJ53MnFv1XGvZdG+PDpEQl8TYpa8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-Twi0WZCcN3eEsb6D9b_wiA-1; Wed, 09 Mar 2022 09:48:20 -0500
X-MC-Unique: Twi0WZCcN3eEsb6D9b_wiA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D27221006AA6;
        Wed,  9 Mar 2022 14:48:19 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 485F2106D5D3;
        Wed,  9 Mar 2022 14:48:05 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 718D7416D5DC; Wed,  9 Mar 2022 08:24:21 -0300 (-03)
Date:   Wed, 9 Mar 2022 08:24:21 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v7 1/2] KVM: LAPIC: Make lapic timer unpinned
Message-ID: <YiiOZaQCf1K653MS@fuller.cnet>
References: <1562376411-3533-1-git-send-email-wanpengli@tencent.com>
 <1562376411-3533-2-git-send-email-wanpengli@tencent.com>
 <ab523b0e930129a100d306d0959445665eb69457.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab523b0e930129a100d306d0959445665eb69457.camel@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 10:26:51AM +0100, David Woodhouse wrote:
> On Sat, 2019-07-06 at 09:26 +0800, Wanpeng Li wrote:
> > From: Wanpeng Li <wanpengli@tencent.com>
> > 
> > Commit 61abdbe0bcc2 ("kvm: x86: make lapic hrtimer pinned") pinned the
> > lapic timer to avoid to wait until the next kvm exit for the guest to
> > see KVM_REQ_PENDING_TIMER set. There is another solution to give a kick
> > after setting the KVM_REQ_PENDING_TIMER bit, make lapic timer unpinned
> > will be used in follow up patches.
> > 
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Radim Krčmář <rkrcmar@redhat.com>
> > Cc: Marcelo Tosatti <mtosatti@redhat.com>
> > Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> > ---
> >  arch/x86/kvm/lapic.c | 8 ++++----
> >  arch/x86/kvm/x86.c   | 6 +-----
> >  2 files changed, 5 insertions(+), 9 deletions(-)
> 
> ...
> 
> 
> > @@ -2510,7 +2510,7 @@ void __kvm_migrate_apic_timer(struct kvm_vcpu *vcpu)
> >  
> >  	timer = &vcpu->arch.apic->lapic_timer.timer;
> >  	if (hrtimer_cancel(timer))
> > -		hrtimer_start_expires(timer, HRTIMER_MODE_ABS_PINNED);
> > +		hrtimer_start_expires(timer, HRTIMER_MODE_ABS);
> >  }
> >  
> >  /*
> 
> Wait, in that case why are we even bothering to cancel and restart the
> timer? I thought the whole point of that was to pin it to the *new* CPU
> that this vCPU is running on.
> 
> If not, can't we just kill __kvm_migrate_apic_timer() off completely
> not?

Current code looks like this:

void __kvm_migrate_apic_timer(struct kvm_vcpu *vcpu)
{
        struct hrtimer *timer;

        if (!lapic_in_kernel(vcpu) ||
                kvm_can_post_timer_interrupt(vcpu)) <----------
                return;

        timer = &vcpu->arch.apic->lapic_timer.timer;
        if (hrtimer_cancel(timer))
                hrtimer_start_expires(timer, HRTIMER_MODE_ABS_HARD);
}

Yeah, should be HRTIMER_MODE_ABS_PINNED AFAICS.

