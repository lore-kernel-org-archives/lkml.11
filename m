Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3241C00140
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 21:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346254AbiHOVyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 17:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350565AbiHOVvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 17:51:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8408510774F;
        Mon, 15 Aug 2022 12:33:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21AFAB80EAD;
        Mon, 15 Aug 2022 19:33:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587B0C433D6;
        Mon, 15 Aug 2022 19:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660591985;
        bh=B9x94GFAJ58C5q5QEsDUkX1JGRSes5Nt9uSoHJvL1ec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u/9wcbI1PnQsM98rZn9xqlYW6SXANnPUFUD3W2RhKr3iEyMRy8CCLO9mwcUPJdrF5
         XMM0Vq7N9h+n3GRHRK3aCtz144zeHtQESr4dlnPxPrTZSlU9+xOG9GtSwgI1zfWdGj
         30jiKgwSmMy0p6zAY2eKOxL//mBNUyPXyI7PCaBg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kai Huang <kai.huang@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.19 0040/1157] KVM: x86: Tag kvm_mmu_x86_module_init() with __init
Date:   Mon, 15 Aug 2022 19:49:56 +0200
Message-Id: <20220815180441.036484267@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815180439.416659447@linuxfoundation.org>
References: <20220815180439.416659447@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <seanjc@google.com>

commit 982bae43f11c37b51d2f1961bb25ef7cac3746fa upstream.

Mark kvm_mmu_x86_module_init() with __init, the entire reason it exists
is to initialize variables when kvm.ko is loaded, i.e. it must never be
called after module initialization.

Fixes: 1d0e84806047 ("KVM: x86/mmu: Resolve nx_huge_pages when kvm.ko is loaded")
Cc: stable@vger.kernel.org
Reviewed-by: Kai Huang <kai.huang@intel.com>
Tested-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20220803224957.1285926-2-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/kvm_host.h |    2 +-
 arch/x86/kvm/mmu/mmu.c          |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1654,7 +1654,7 @@ static inline int kvm_arch_flush_remote_
 #define kvm_arch_pmi_in_guest(vcpu) \
 	((vcpu) && (vcpu)->arch.handling_intr_from_guest)
 
-void kvm_mmu_x86_module_init(void);
+void __init kvm_mmu_x86_module_init(void);
 int kvm_mmu_vendor_module_init(void);
 void kvm_mmu_vendor_module_exit(void);
 
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6275,7 +6275,7 @@ static int set_nx_huge_pages(const char
  * nx_huge_pages needs to be resolved to true/false when kvm.ko is loaded, as
  * its default value of -1 is technically undefined behavior for a boolean.
  */
-void kvm_mmu_x86_module_init(void)
+void __init kvm_mmu_x86_module_init(void)
 {
 	if (nx_huge_pages == -1)
 		__set_nx_huge_pages(get_nx_auto_mode());


