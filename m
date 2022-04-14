Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27819C47088
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 13:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245349AbiDNNi1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 09:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244653AbiDNN1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:27:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 205C9A2047
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 06:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649942432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=guPhHfLWQaBPsCmuIyaAa+212gzE/QcUkyjWekHqQX4=;
        b=ZOYTelyqu6SvhNPPu6ixvY7z3GYtF/UO/xvCdFIBF6Zs22+FxhP3aKCDvKbnKCWoqzlk1Q
        fuf+9dY2R7Fe0nLc7C29f69DgDonDt359NBqKU72P+p2z+Mf61tLt8REsOG4/M60eKKo+s
        ukUun06LclitZUKL0BdG5SSWNVluaB4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-424-3jbKgnbbPeSaioWPbhlXGA-1; Thu, 14 Apr 2022 09:20:29 -0400
X-MC-Unique: 3jbKgnbbPeSaioWPbhlXGA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 62071100BABE;
        Thu, 14 Apr 2022 13:20:28 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.195.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD4A07C28;
        Thu, 14 Apr 2022 13:20:26 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/34] KVM: x86: Prepare kvm_hv_flush_tlb() to handle L2's GPAs
Date:   Thu, 14 Apr 2022 15:19:45 +0200
Message-Id: <20220414132013.1588929-7-vkuznets@redhat.com>
In-Reply-To: <20220414132013.1588929-1-vkuznets@redhat.com>
References: <20220414132013.1588929-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To handle L2 TLB flush requests, KVM needs to translate the specified
L2 GPA to L1 GPA to read hypercall arguments from there.

No fucntional change as KVM doesn't handle VMCALL/VMMCALL from L2 yet.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 1a6f9628cee9..fc4bb0ead9fa 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -23,6 +23,7 @@
 #include "ioapic.h"
 #include "cpuid.h"
 #include "hyperv.h"
+#include "mmu.h"
 #include "xen.h"
 
 #include <linux/cpu.h>
@@ -1975,6 +1976,12 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	 */
 	BUILD_BUG_ON(KVM_HV_MAX_SPARSE_VCPU_SET_BITS > 64);
 
+	if (!hc->fast && is_guest_mode(vcpu)) {
+		hc->ingpa = translate_nested_gpa(vcpu, hc->ingpa, 0, NULL);
+		if (unlikely(hc->ingpa == UNMAPPED_GVA))
+			return HV_STATUS_INVALID_HYPERCALL_INPUT;
+	}
+
 	if (hc->code == HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST ||
 	    hc->code == HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE) {
 		if (hc->fast) {
-- 
2.35.1

