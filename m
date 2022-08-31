Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736C5ECAAD1
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Aug 2022 12:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiHaMxK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Aug 2022 08:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbiHaMxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:53:06 -0400
Received: from smtpbg.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2545BADB6;
        Wed, 31 Aug 2022 05:53:01 -0700 (PDT)
X-QQ-mid: bizesmtp83t1661950345tkzp3z64
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 31 Aug 2022 20:52:23 +0800 (CST)
X-QQ-SSF: 01000000002000D0E000B00A0000000
X-QQ-FEAT: LG+NUo/f6sFJ1naBvVM3Jw2zlzxf8bHDBwjhkZXh1Mg91itde6dtpey/Einvu
        jIRgmuZmy5QdeVYjJYOB0nBSNjZKbgNGFWELQvbHVitnMduFTzK49VWs/u53mqK2a3Smx1C
        HbFk0AKxW+vcMuK8FdxFjMWlZFSctN3ZYy6SqvcEBkN7odxbZl89oi+2nzJDwl2EppBO9oM
        w7Y+rHYF4Dq6gWPJ8acrkBt1LgaHD+yD9vNB2wmcbSs8WlDPa8XvVuPVEdzlDW8HIMQ4kSD
        9vYGyKjy08w4JyiX0LAsR0LcEu8/QfDU8rm9p/V5S5EjtVo/nURFAy581HcUNTzADyHuu0o
        wJ9J9bW1EaltL3UzxiGIolttnkJsRa2CobqBPknbndujSqm39HgO3FEHaeGWsvf6amCtcGp
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] KVM: x86/mmu: fix repeated words in comments
Date:   Wed, 31 Aug 2022 20:52:17 +0800
Message-Id: <20220831125217.12313-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'to'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 arch/x86/kvm/mmu/paging_tmpl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 39e0205e7300..5ab5f94dcb6f 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -472,7 +472,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 
 #if PTTYPE == PTTYPE_EPT
 	/*
-	 * Use PFERR_RSVD_MASK in error_code to to tell if EPT
+	 * Use PFERR_RSVD_MASK in error_code to tell if EPT
 	 * misconfiguration requires to be injected. The detection is
 	 * done by is_rsvd_bits_set() above.
 	 *
-- 
2.36.1

