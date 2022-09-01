Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA57ECAAD1
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Sep 2022 12:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbiIAMXq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Sep 2022 08:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbiIAMXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:23:34 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9C412206B;
        Thu,  1 Sep 2022 05:23:33 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MJKqV2rp5zkWkW;
        Thu,  1 Sep 2022 20:19:50 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 1 Sep
 2022 20:23:30 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC:     <x86@kernel.org>, <hpa@zytor.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] KVM: x86: fix memoryleak in kvm_arch_vcpu_create()
Date:   Thu, 1 Sep 2022 20:23:00 +0800
Message-ID: <20220901122300.22298-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When allocating memory for mci_ctl2_banks fails, KVM doesn't release
mce_banks leading to memoryleak. Fix this issue by calling kfree()
for it when kcalloc() fails.

Fixes: 281b52780b57 ("KVM: x86: Add emulation for MSR_IA32_MCx_CTL2 MSRs.")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 arch/x86/kvm/x86.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d7374d768296..396f4c9e9880 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11563,7 +11563,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	vcpu->arch.mci_ctl2_banks = kcalloc(KVM_MAX_MCE_BANKS, sizeof(u64),
 					    GFP_KERNEL_ACCOUNT);
 	if (!vcpu->arch.mce_banks || !vcpu->arch.mci_ctl2_banks)
-		goto fail_free_pio_data;
+		goto fail_free_mce_banks;
 	vcpu->arch.mcg_cap = KVM_MAX_MCE_BANKS;
 
 	if (!zalloc_cpumask_var(&vcpu->arch.wbinvd_dirty_mask,
@@ -11617,7 +11617,6 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 fail_free_mce_banks:
 	kfree(vcpu->arch.mce_banks);
 	kfree(vcpu->arch.mci_ctl2_banks);
-fail_free_pio_data:
 	free_page((unsigned long)vcpu->arch.pio_data);
 fail_free_lapic:
 	kvm_free_lapic(vcpu);
-- 
2.23.0

