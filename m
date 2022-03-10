Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00854C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 11:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236562AbiCJLUH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 06:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241561AbiCJLUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 06:20:01 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50388CDB0;
        Thu, 10 Mar 2022 03:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646911140; x=1678447140;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UYIKoaA6kmpekLkyIKkHDzFL2cnsVds98qcFgEdzL5w=;
  b=SDesxgD/z7diAP5NwITf/tdGklOEW7jjIiignj25e48poBzKv4ngf1MR
   fP1R95if4jvP2cfO+N7gzGL/eekDWsRHtpjXmcb3UDBJdf0wX00CMCzsj
   V5a2eIbkeCkwLLrfMYMACh3cuVy3TukjlQTElcHb4ZxnKi4dQP6lSImSu
   AUcWjBjKl8dr6OY57sYLOdIXz/zk80DQ6FkIUT6Mz+bZAhT31LtGfLvav
   i+p+66Lffl5gMEq+uc+8v3RufJggyl6pwBrWaARhfw7EtSxJIo4dxxYzW
   SMH1Jv/z5UzvldNKqlraBvsP4EI16tP6KLdL0QnXhoO4oHgZfdCeXxp2i
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="254962715"
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="254962715"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 03:19:00 -0800
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="712325502"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.123])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 03:18:58 -0800
From:   Zhenzhong Duan <zhenzhong.duan@intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, seanjc@google.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org
Subject: [PATCH] KVM: x86: Remove redundant vm_entry_controls_clearbit() call
Date:   Thu, 10 Mar 2022 19:13:54 +0800
Message-Id: <20220310111354.504565-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When emulating exit from long mode, EFER_LMA is cleared which lead to
efer writing emulation, which will unset VM_ENTRY_IA32E_MODE control
bit as requested by SDM. So no need to unset VM_ENTRY_IA32E_MODE again
in exit_lmode() explicitly.

In fact benefited from shadow controls mechanism, this change doesn't
eliminate vmread or vmwrite.

Opportunistically remove unnecessory assignment to uret MSR data field
as vmx_setup_uret_msrs() will do the same thing.

In case EFER isn't supported by hardware, long mode isn't supported,
so this will no break.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b730d799c26e..b04588dc7faa 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2878,14 +2878,11 @@ int vmx_set_efer(struct kvm_vcpu *vcpu, u64 efer)
 		return 0;
 
 	vcpu->arch.efer = efer;
-	if (efer & EFER_LMA) {
+	if (efer & EFER_LMA)
 		vm_entry_controls_setbit(to_vmx(vcpu), VM_ENTRY_IA32E_MODE);
-		msr->data = efer;
-	} else {
+	else
 		vm_entry_controls_clearbit(to_vmx(vcpu), VM_ENTRY_IA32E_MODE);
 
-		msr->data = efer & ~EFER_LME;
-	}
 	vmx_setup_uret_msrs(vmx);
 	return 0;
 }
@@ -2911,7 +2908,6 @@ static void enter_lmode(struct kvm_vcpu *vcpu)
 
 static void exit_lmode(struct kvm_vcpu *vcpu)
 {
-	vm_entry_controls_clearbit(to_vmx(vcpu), VM_ENTRY_IA32E_MODE);
 	vmx_set_efer(vcpu, vcpu->arch.efer & ~EFER_LMA);
 }
 
-- 
2.25.1

