Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0247C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Apr 2022 02:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238460AbiDGCUY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 22:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236780AbiDGCUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 22:20:17 -0400
X-Greylist: delayed 2169 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Apr 2022 19:18:13 PDT
Received: from spam.unicloud.com (smgmail.unic2.com.cn [220.194.70.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9932E329B8;
        Wed,  6 Apr 2022 19:18:11 -0700 (PDT)
Received: from spam.unicloud.com (localhost [127.0.0.2] (may be forged))
        by spam.unicloud.com with ESMTP id 2371g3vt034159;
        Thu, 7 Apr 2022 09:42:03 +0800 (GMT-8)
        (envelope-from luofei@unicloud.com)
Received: from eage.unicloud.com ([220.194.70.35])
        by spam.unicloud.com with ESMTP id 2371eVLN032798;
        Thu, 7 Apr 2022 09:40:31 +0800 (GMT-8)
        (envelope-from luofei@unicloud.com)
Received: from localhost.localdomain (10.10.1.7) by zgys-ex-mb09.Unicloud.com
 (10.10.0.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2375.17; Thu, 7
 Apr 2022 09:40:30 +0800
From:   luofei <luofei@unicloud.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>
CC:     <pbonzini@redhat.com>, <seanjc@google.com>, <vkuznets@redhat.com>,
        <wanpengli@tencent.com>, <jmattson@google.com>, <joro@8bytes.org>,
        <hpa@zytor.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, luofei <luofei@unicloud.com>
Subject: [PATCH] KVM: x86/mmu: remove unnecessary kvm_shadow_root_allocated() check
Date:   Wed, 6 Apr 2022 21:40:16 -0400
Message-ID: <20220407014016.1266469-1-luofei@unicloud.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.10.1.7]
X-ClientProxiedBy: zgys-ex-mb06.Unicloud.com (10.10.0.52) To
 zgys-ex-mb09.Unicloud.com (10.10.0.24)
X-DNSRBL: 
X-MAIL: spam.unicloud.com 2371g3vt034159
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we reach here, the return value of kvm_shadow_root_allocated()
has already been checked to false under kvm->slots_arch_lock.
So remove the unnecessary recheck.

Signed-off-by: luofei <luofei@unicloud.com>
---
 arch/x86/kvm/mmu/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 8f19ea752704..1978ee527298 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3394,7 +3394,7 @@ static int mmu_first_shadow_root_alloc(struct kvm *kvm)
 	 * Check if anything actually needs to be allocated, e.g. all metadata
 	 * will be allocated upfront if TDP is disabled.
 	 */
-	if (kvm_memslots_have_rmaps(kvm) &&
+	if (!is_tdp_mmu_enabled(kvm) &&
 	    kvm_page_track_write_tracking_enabled(kvm))
 		goto out_success;
 
-- 
2.27.0

