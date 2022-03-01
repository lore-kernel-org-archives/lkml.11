Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA3EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Mar 2022 13:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbiCAN4p (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Mar 2022 08:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbiCAN4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 08:56:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 365B2A0BCD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 05:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646142957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hAnHrd9CZ7T+EE9+uK5MAxGO2eqTA/lCT0zOhWpk6rE=;
        b=hoYi0TqEvF7Eg4ik9rlVYY8V4DjDMtKat2Aan/ahC/YlaIwaOdZthG1Zo2HNe+WbOU9Kkh
        E34heWi9vIoxaswIdIjOmQCnpeOjvcoQvbJx1dO+dRpuiyLIhrOknOVOMwphFAjcXvCWaH
        VeZvsDIQeN51L0JY3HaPsXtYBfsr0Sg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-mKxe7MxTO_6LRICKCVt10A-1; Tue, 01 Mar 2022 08:55:52 -0500
X-MC-Unique: mKxe7MxTO_6LRICKCVt10A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45D351091DA1;
        Tue,  1 Mar 2022 13:55:50 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.195.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A42CB1057FDB;
        Tue,  1 Mar 2022 13:55:46 +0000 (UTC)
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
Subject: [PATCH 3/4] KVM: x86: SVM: use vmcb01 in avic_init_vmcb
Date:   Tue,  1 Mar 2022 15:55:25 +0200
Message-Id: <20220301135526.136554-4-mlevitsk@redhat.com>
In-Reply-To: <20220301135526.136554-1-mlevitsk@redhat.com>
References: <20220301135526.136554-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Out of precation use vmcb01 when enabling host AVIC.
No functional change intended.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/svm/avic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index e23159f3a62ba..9656e192c646b 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -167,7 +167,7 @@ int avic_vm_init(struct kvm *kvm)
 
 void avic_init_vmcb(struct vcpu_svm *svm)
 {
-	struct vmcb *vmcb = svm->vmcb;
+	struct vmcb *vmcb = svm->vmcb01.ptr;
 	struct kvm_svm *kvm_svm = to_kvm_svm(svm->vcpu.kvm);
 	phys_addr_t bpa = __sme_set(page_to_phys(svm->avic_backing_page));
 	phys_addr_t lpa = __sme_set(page_to_phys(kvm_svm->avic_logical_id_table_page));
-- 
2.26.3

