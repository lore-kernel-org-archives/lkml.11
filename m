Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70505C41535
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Apr 2022 09:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347297AbiDZJTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Apr 2022 05:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345869AbiDZI4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:56:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5747814A5;
        Tue, 26 Apr 2022 01:41:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67650B81D0A;
        Tue, 26 Apr 2022 08:41:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95E3C385A0;
        Tue, 26 Apr 2022 08:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650962481;
        bh=BwezHAYAX5zda3TQxBa8HvpHICs3ULxiWMTyV4MwdJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DS2V2cQPQRjzcXQ8T+lcTchFgBAW/GIQkerAkyGSpixud2SwzKBMu1FX5mek3d94w
         FRcNBIR5a/yOodOFt6bPWlOZ9KYSJyiw4AvI1fiupYamKP6Hd1qoEaQmkpLLm+TrEp
         Ii8CcPixL0N1o5aoYvJuL+Jnq+/3SYr4iaYw4Rt0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable@vger.kerel.org,
        Sean Christopherson <seanjc@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.15 110/124] KVM: SVM: Flush when freeing encrypted pages even on SME_COHERENT CPUs
Date:   Tue, 26 Apr 2022 10:21:51 +0200
Message-Id: <20220426081750.421291090@linuxfoundation.org>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220426081747.286685339@linuxfoundation.org>
References: <20220426081747.286685339@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mingwei Zhang <mizhang@google.com>

commit d45829b351ee6ec5f54dd55e6aca1f44fe239fe6 upstream.

Use clflush_cache_range() to flush the confidential memory when
SME_COHERENT is supported in AMD CPU. Cache flush is still needed since
SME_COHERENT only support cache invalidation at CPU side. All confidential
cache lines are still incoherent with DMA devices.

Cc: stable@vger.kerel.org

Fixes: add5e2f04541 ("KVM: SVM: Add support for the SEV-ES VMSA")
Reviewed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
Message-Id: <20220421031407.2516575-3-mizhang@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/sev.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1990,11 +1990,14 @@ static void sev_flush_guest_memory(struc
 				   unsigned long len)
 {
 	/*
-	 * If hardware enforced cache coherency for encrypted mappings of the
-	 * same physical page is supported, nothing to do.
+	 * If CPU enforced cache coherency for encrypted mappings of the
+	 * same physical page is supported, use CLFLUSHOPT instead. NOTE: cache
+	 * flush is still needed in order to work properly with DMA devices.
 	 */
-	if (boot_cpu_has(X86_FEATURE_SME_COHERENT))
+	if (boot_cpu_has(X86_FEATURE_SME_COHERENT)) {
+		clflush_cache_range(va, PAGE_SIZE);
 		return;
+	}
 
 	/*
 	 * If the VM Page Flush MSR is supported, use it to flush the page


