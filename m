Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5DAC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Mar 2022 13:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbiCAN4t (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Mar 2022 08:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235198AbiCAN4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 08:56:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54918A0BDC
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 05:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646142960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tI3lcF3SMMWiuDSlZvS+v6w9gqEgscSUK6B6ANT7DHI=;
        b=AN48ADfmUwmD38rlLYVsOIsypW05H746SYMCoSeI7hxwvYphWyL4UIPbStN4B3UAzsJ8Av
        BIhDu42FzJR5ESjCsiYdfhhO7cH4cM1GYzT0ZMZfN2F1VEdLFW3J+U5W/G2OjOtG0KB9Bx
        dnNXfS0lNU+xc78OyJSZmZL2N8wHJqo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-176-OW6ztaohN_q3XJ6UXAc1BQ-1; Tue, 01 Mar 2022 08:55:57 -0500
X-MC-Unique: OW6ztaohN_q3XJ6UXAc1BQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55B9C180A08B;
        Tue,  1 Mar 2022 13:55:54 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.195.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF7461057FD1;
        Tue,  1 Mar 2022 13:55:50 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Jim Mattson <jmattson@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH 4/4] KVM: x86: lapic: don't allow to set non default apic id when not using x2apic api
Date:   Tue,  1 Mar 2022 15:55:26 +0200
Message-Id: <20220301135526.136554-5-mlevitsk@redhat.com>
In-Reply-To: <20220301135526.136554-1-mlevitsk@redhat.com>
References: <20220301135526.136554-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a loop hole in setting the apic state that didn't check if
apic id == vcpu_id when x2apic is enabled but userspace is using
a older variant of the ioctl which didn't had 32 bit apic ids.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/lapic.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 80a2020c4db40..8d35f56c64020 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2618,15 +2618,14 @@ static int kvm_apic_state_fixup(struct kvm_vcpu *vcpu,
 		u32 *ldr = (u32 *)(s->regs + APIC_LDR);
 		u64 icr;
 
-		if (vcpu->kvm->arch.x2apic_format) {
-			if (*id != vcpu->vcpu_id)
-				return -EINVAL;
-		} else {
-			if (set)
-				*id >>= 24;
-			else
-				*id <<= 24;
-		}
+		if (!vcpu->kvm->arch.x2apic_format && set)
+			*id >>= 24;
+
+		if (*id != vcpu->vcpu_id)
+			return -EINVAL;
+
+		if (!vcpu->kvm->arch.x2apic_format && !set)
+			*id <<= 24;
 
 		/*
 		 * In x2APIC mode, the LDR is fixed and based on the id.  And
-- 
2.26.3

