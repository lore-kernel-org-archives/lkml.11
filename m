Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA98C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 May 2022 07:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237442AbiEJH6A (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 May 2022 03:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237646AbiEJH5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 03:57:50 -0400
Received: from out199-12.us.a.mail.aliyun.com (out199-12.us.a.mail.aliyun.com [47.90.199.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EEE2469D2;
        Tue, 10 May 2022 00:53:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=shannon.zhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VCq2PTx_1652169227;
Received: from localhost(mailfrom:shannon.zhao@linux.alibaba.com fp:SMTPD_---0VCq2PTx_1652169227)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 10 May 2022 15:53:47 +0800
From:   Shannon Zhao <shannon.zhao@linux.alibaba.com>
To:     kvm@vger.kernel.org, pbonzini@redhat.com, seanjc@google.com
Cc:     linux-kernel@vger.kernel.org, yijunzhu@linux.alibaba.com
Subject: [PATCH] KVM: SVM: Set HWCR[TscFreqSel] to host's value
Date:   Tue, 10 May 2022 15:53:47 +0800
Message-Id: <1652169227-38383-1-git-send-email-shannon.zhao@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM sets CPUID.80000007H:EDX[8] to 1, but not set HWCR[TscFreqSel].
This will cause guest kernel printing below log on AMD platform even
though the hardware TSC exactly counts with P0 frequency.
"[Firmware Bug]: TSC doesn't count with P0 frequency!"

Fix it by setting HWCR[TscFreqSel] to host's value to indicate whether
the TSC increments at the P0 frequency.

Signed-off-by: Shannon Zhao <shannon.zhao@linux.alibaba.com>
---
 arch/x86/kvm/svm/svm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 7e45d03..fb4bb51 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1139,6 +1139,11 @@ static void __svm_vcpu_reset(struct kvm_vcpu *vcpu)
 	svm_init_osvw(vcpu);
 	vcpu->arch.microcode_version = 0x01000065;
 	svm->tsc_ratio_msr = kvm_default_tsc_scaling_ratio;
+	/* 
+	 * TSC frequency select is HWCR[24], set it to host's value to indicate
+	 * whether the TSC increments at the P0 frequency. 
+	 */
+	vcpu->arch.msr_hwcr = native_read_msr(MSR_K7_HWCR) & BIT_ULL(24); 
 
 	if (sev_es_guest(vcpu->kvm))
 		sev_es_vcpu_reset(svm);
-- 
1.8.3.1

