Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE1CCCA47A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jun 2022 20:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358260AbiFNUs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jun 2022 16:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358237AbiFNUsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:48:12 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590812A25E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:48:00 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id r10-20020a632b0a000000b003fcb4af0273so5503414pgr.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=i8wtSp2E4JqfRNL3djq8C56gzeFUR38oagezAkgJLcI=;
        b=ceDpVZyz3vK9tKa0AWVHBl1+LlX+2QOu34wn/pzGX/BOeyxnAvNtMgmTv0Lvl9tetG
         Mi5GxTjmlGNXhKn7WjXZZ/rnKr4pSSVIONlOVgKprRH/qxuwFIeNWs5oD+JOYshAVPgs
         091UOWFrzaMdlQIcmxk34Krd3xIRCP94qJBrJtl34R/dcCvcOivoYE7AdHe8GXDnf+wL
         pehSVswvWToP/h9XKbY+RxiX6hIh19+wRd/TPdgPSKKEmxCHPQ5D7ik6OjpMnR/+f0cq
         Nq7GLDnrPfLs1CG+Hg+R4fTidXQoh/G8MitcEr8GlByADSFZZkebvhIKiIrRqMFzr/SQ
         gmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=i8wtSp2E4JqfRNL3djq8C56gzeFUR38oagezAkgJLcI=;
        b=y87nPijKRAdtZNx6shlg/ZFD+fa9uHlP6JPgF6pq4UETQH+nwPkIJ4R7Kv9D+bbq1G
         NHBCDUCPbEQJV9UqEf7TwWIDhmctzshKzFneBNqpAA1BYNtIeQznIqAKhJQI8RTgNgtA
         NhPhj4hhkosp3IZLj71Ku+c2eUaNwqAo6EHYjeIRKMt4E4cIEgB5pwsf6EcCxa2AQNBO
         5+tAfdhJlKRppl5rBblps7g3H3ewfHxtzr2HvtVK46N9rqrPDAOwyT37dEAkEdeWIzom
         q6gKXSy1YZKCapNVOwOx5sxFCo7xZQ00Drm0HP/YbTpftuTwcZdgaZ+Kq+ChRolXU0bT
         sMGg==
X-Gm-Message-State: AJIora+8mzJ+KY0lKGblrXVTRdN+yyTDF60RgcoxEEEVBJh/NLahmMCT
        qsc3mm5/wg6n3q6niIWdx0MHw5UAcBU=
X-Google-Smtp-Source: AGRyM1snM//1jLbBcUpjQyAZcuRD1MIH9x3pvmmisOWAkqcGBXM0s6yrvhIW5MtrZdWAFYIv9M8rWubSeRk=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1d90:b0:1e8:5a98:d591 with SMTP id
 pf16-20020a17090b1d9000b001e85a98d591mr6416882pjb.126.1655239679868; Tue, 14
 Jun 2022 13:47:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 14 Jun 2022 20:47:22 +0000
In-Reply-To: <20220614204730.3359543-1-seanjc@google.com>
Message-Id: <20220614204730.3359543-14-seanjc@google.com>
Mime-Version: 1.0
References: <20220614204730.3359543-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v2 13/21] KVM: x86: Formalize blocking of nested pending exceptions
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Capture nested_run_pending as block_pending_exceptions so that the logic
of why exceptions are blocked only needs to be documented once instead of
at every place that employs the logic.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/nested.c | 20 ++++++++++----------
 arch/x86/kvm/vmx/nested.c | 23 ++++++++++++-----------
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 471d40e97890..460161e67ce5 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1347,10 +1347,16 @@ static inline bool nested_exit_on_init(struct vcpu_svm *svm)
 
 static int svm_check_nested_events(struct kvm_vcpu *vcpu)
 {
-	struct vcpu_svm *svm = to_svm(vcpu);
-	bool block_nested_events =
-		kvm_event_needs_reinjection(vcpu) || svm->nested.nested_run_pending;
 	struct kvm_lapic *apic = vcpu->arch.apic;
+	struct vcpu_svm *svm = to_svm(vcpu);
+	/*
+	 * Only a pending nested run blocks a pending exception.  If there is a
+	 * previously injected event, the pending exception occurred while said
+	 * event was being delivered and thus needs to be handled.
+	 */
+	bool block_nested_exceptions = svm->nested.nested_run_pending;
+	bool block_nested_events = block_nested_exceptions ||
+				   kvm_event_needs_reinjection(vcpu);
 
 	if (lapic_in_kernel(vcpu) &&
 	    test_bit(KVM_APIC_INIT, &apic->pending_events)) {
@@ -1363,13 +1369,7 @@ static int svm_check_nested_events(struct kvm_vcpu *vcpu)
 	}
 
 	if (vcpu->arch.exception.pending) {
-		/*
-		 * Only a pending nested run can block a pending exception.
-		 * Otherwise an injected NMI/interrupt should either be
-		 * lost or delivered to the nested hypervisor in the EXITINTINFO
-		 * vmcb field, while delivering the pending exception.
-		 */
-		if (svm->nested.nested_run_pending)
+		if (block_nested_exceptions)
                         return -EBUSY;
 		if (!nested_exit_on_exception(svm))
 			return 0;
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index fafdcbfeca1f..50fe66f0cc1b 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3903,11 +3903,17 @@ static bool nested_vmx_preemption_timer_pending(struct kvm_vcpu *vcpu)
 
 static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
 {
-	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	unsigned long exit_qual;
-	bool block_nested_events =
-	    vmx->nested.nested_run_pending || kvm_event_needs_reinjection(vcpu);
 	struct kvm_lapic *apic = vcpu->arch.apic;
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	unsigned long exit_qual;
+	/*
+	 * Only a pending nested run blocks a pending exception.  If there is a
+	 * previously injected event, the pending exception occurred while said
+	 * event was being delivered and thus needs to be handled.
+	 */
+	bool block_nested_exceptions = vmx->nested.nested_run_pending;
+	bool block_nested_events = block_nested_exceptions ||
+				   kvm_event_needs_reinjection(vcpu);
 
 	if (lapic_in_kernel(vcpu) &&
 		test_bit(KVM_APIC_INIT, &apic->pending_events)) {
@@ -3941,15 +3947,10 @@ static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
 	 * Process exceptions that are higher priority than Monitor Trap Flag:
 	 * fault-like exceptions, TSS T flag #DB (not emulated by KVM, but
 	 * could theoretically come in from userspace), and ICEBP (INT1).
-	 *
-	 * Note that only a pending nested run can block a pending exception.
-	 * Otherwise an injected NMI/interrupt should either be
-	 * lost or delivered to the nested hypervisor in the IDT_VECTORING_INFO,
-	 * while delivering the pending exception.
 	 */
 	if (vcpu->arch.exception.pending &&
 	    !(vmx_get_pending_dbg_trap(vcpu) & ~DR6_BT)) {
-		if (vmx->nested.nested_run_pending)
+		if (block_nested_exceptions)
 			return -EBUSY;
 		if (!nested_vmx_check_exception(vcpu, &exit_qual))
 			goto no_vmexit;
@@ -3966,7 +3967,7 @@ static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
 	}
 
 	if (vcpu->arch.exception.pending) {
-		if (vmx->nested.nested_run_pending)
+		if (block_nested_exceptions)
 			return -EBUSY;
 		if (!nested_vmx_check_exception(vcpu, &exit_qual))
 			goto no_vmexit;
-- 
2.36.1.476.g0c4daa206d-goog

