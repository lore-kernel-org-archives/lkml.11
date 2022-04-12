Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8A6C4707A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 07:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355665AbiDLH2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 03:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351769AbiDLHMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:12:55 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7189CBD3;
        Mon, 11 Apr 2022 23:52:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CA4B9CE1C0E;
        Tue, 12 Apr 2022 06:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA13CC385A1;
        Tue, 12 Apr 2022 06:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649746342;
        bh=sdnn5fQjqVbaEFiK/DlrlMulGua9dBH2cjFJP+cUzLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P1/51qwEevrT+wihaXSXBxEQ7a3yQR9TfaKTRn6TZTAbnZtGQfgfRmovixEBiTd9B
         3+C9I0bUsYHzUuKHOW7/BMKFJP3gZ1UU7mODDYPz7k9y/pK/2fy0oIA+sLvNF4Elaq
         It38aWDzI1+D5J9Pl5AD19punGzB8acHxFBN9DfQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.15 248/277] KVM: SVM: Allow AVIC support on system w/ physical APIC ID > 255
Date:   Tue, 12 Apr 2022 08:30:51 +0200
Message-Id: <20220412062949.220816252@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412062942.022903016@linuxfoundation.org>
References: <20220412062942.022903016@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

commit 4a204f7895878363ca8211f50ec610408c8c70aa upstream.

Expand KVM's mask for the AVIC host physical ID to the full 12 bits defined
by the architecture.  The number of bits consumed by hardware is model
specific, e.g. early CPUs ignored bits 11:8, but there is no way for KVM
to enumerate the "true" size.  So, KVM must allow using all bits, else it
risks rejecting completely legal x2APIC IDs on newer CPUs.

This means KVM relies on hardware to not assign x2APIC IDs that exceed the
"true" width of the field, but presumably hardware is smart enough to tie
the width to the max x2APIC ID.  KVM also relies on hardware to support at
least 8 bits, as the legacy xAPIC ID is writable by software.  But, those
assumptions are unavoidable due to the lack of any way to enumerate the
"true" width.

Cc: stable@vger.kernel.org
Cc: Maxim Levitsky <mlevitsk@redhat.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Sean Christopherson <seanjc@google.com>
Fixes: 44a95dae1d22 ("KVM: x86: Detect and Initialize AVIC support")
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-Id: <20220211000851.185799-1-suravee.suthikulpanit@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[modified due to the conflict caused by the commit 391503528257 ("KVM:
x86: SVM: move avic definitions from AMD's spec to svm.h")]
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/avic.c |    7 +------
 arch/x86/kvm/svm/svm.h  |    2 +-
 2 files changed, 2 insertions(+), 7 deletions(-)

--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -947,15 +947,10 @@ out:
 void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	u64 entry;
-	/* ID = 0xff (broadcast), ID > 0xff (reserved) */
 	int h_physical_id = kvm_cpu_get_apicid(cpu);
 	struct vcpu_svm *svm = to_svm(vcpu);
 
-	/*
-	 * Since the host physical APIC id is 8 bits,
-	 * we can support host APIC ID upto 255.
-	 */
-	if (WARN_ON(h_physical_id > AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK))
+	if (WARN_ON(h_physical_id & ~AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK))
 		return;
 
 	entry = READ_ONCE(*(svm->avic_physical_id_cache));
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -499,7 +499,7 @@ extern struct kvm_x86_nested_ops svm_nes
 #define AVIC_LOGICAL_ID_ENTRY_VALID_BIT			31
 #define AVIC_LOGICAL_ID_ENTRY_VALID_MASK		(1 << 31)
 
-#define AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK	(0xFFULL)
+#define AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK	GENMASK_ULL(11, 0)
 #define AVIC_PHYSICAL_ID_ENTRY_BACKING_PAGE_MASK	(0xFFFFFFFFFFULL << 12)
 #define AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK		(1ULL << 62)
 #define AVIC_PHYSICAL_ID_ENTRY_VALID_MASK		(1ULL << 63)


