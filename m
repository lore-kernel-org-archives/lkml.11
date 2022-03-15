Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C514C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 15:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349632AbiCOPbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 11:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349630AbiCOPbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 11:31:23 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9619853736;
        Tue, 15 Mar 2022 08:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647358211; x=1678894211;
  h=from:to:cc:subject:date:message-id;
  bh=MSsunkUnlmNWEh3N5eSOabu0L52iP8P30Mp1QA9CPbQ=;
  b=LSaLVfTgx8G/tYj14kZPVhNQp8x9B1wdBtKTI/7hRu1irRXBfSEE8wlS
   7rm3FQn3wIp0NZmNxdnLxIBE6T1mqKzoaO9iPz1Q8emkR9kMbWRMGhAw+
   DWCkcjQAXuahTE2xLMT3acRzBFos7dGL7q05lM5Ai1cJhKkarFGIpkXlq
   /KPiRSXvnVlxQp62IsFZuyFcyszrmkZxntWTnx0ceRLjT9jUZUQSTvz+/
   gT94QioLjkicAmbpWej/4i4CAfC7iKLhHnU4M5za3Ko9cT4DKGtPeF0Bs
   XyLyk5vhfBpM4OjiKUvCinZPWGwlkHPZKDEiQhwllXQjECWwDnc3NKPxZ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256061573"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="256061573"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 08:30:11 -0700
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="556977185"
Received: from arthur-vostro-3668.sh.intel.com ([10.239.13.120])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 08:30:08 -0700
From:   Zeng Guang <guang.zeng@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Gao Chao <chao.gao@intel.com>,
        Zeng Guang <guang.zeng@intel.com>
Subject: [PATCH] KVM: VMX: Prepare VMCS setting for posted interrupt enabling when APICv is available
Date:   Tue, 15 Mar 2022 22:58:36 +0800
Message-Id: <20220315145836.9910-1-guang.zeng@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently KVM setup posted interrupt VMCS only depending on
per-vcpu APICv activation status at the vCPU creation time.
However, this status can be toggled dynamically under some
circumstance. So potentially, later posted interrupt enabling
may be problematic without VMCS readiness.

To fix this, always settle the VMCS setting for posted interrupt
as long as APICv is available and lapic locates in kernel.

Signed-off-by: Zeng Guang <guang.zeng@intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b730d799c26e..d6e42d37bb61 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4388,7 +4388,7 @@ static void init_vmcs(struct vcpu_vmx *vmx)
 	if (cpu_has_secondary_exec_ctrls())
 		secondary_exec_controls_set(vmx, vmx_secondary_exec_control(vmx));
 
-	if (kvm_vcpu_apicv_active(&vmx->vcpu)) {
+	if (enable_apicv && lapic_in_kernel(&vmx->vcpu)) {
 		vmcs_write64(EOI_EXIT_BITMAP0, 0);
 		vmcs_write64(EOI_EXIT_BITMAP1, 0);
 		vmcs_write64(EOI_EXIT_BITMAP2, 0);
-- 
2.27.0

