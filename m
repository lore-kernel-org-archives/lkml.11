Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D74ECAAD4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Aug 2022 00:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiHaAx0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Aug 2022 20:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiHaAxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 20:53:22 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705C337F82
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:53:21 -0700 (PDT)
X-QQ-mid: bizesmtp76t1661907179tg3l23sq
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 31 Aug 2022 08:52:58 +0800 (CST)
X-QQ-SSF: 01000000000000D0E000000A0000000
X-QQ-FEAT: xqT8U4SkSpgzoaMTZ/E4s2zF0bg8XhCWtigOgoAz5Gm4Sy/x5vzrFa8GnrgmG
        Pw8m4EqlHz4NA/RDsu+nxMgzRjyTJd2mfSaVWqu7sgjSK5BYKpKbXW/2tZQMKQYWoYyCyXt
        8RcTDyR3uBQPZQn2495sleIAY5f1oTUNPfxZvca6p8HXdxMqFsNRT5y247H6GCK1fSBHL1c
        Tmp8nGl4Il/Dhf2hvK/NjdtCNlnbnWSJqhcBnkVO9gLeJsF2nVwi9yKB4n+0v4+BPumEiKR
        QAXNnfxSRCZfsJI4e7+LZ7GQ+eikynCFmw7A6xBYs/sEUq6MsxuuL9jcTozhhyDtRB+T/HK
        Sz8z56n20rMVg2Abx0Kd3a/DDy+RhnJ4MQhPqc1j/WkUKvJz6M=
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, oliver.upton@linux.dev,
        catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] KVM: arm64: fix repeated words in comments
Date:   Wed, 31 Aug 2022 08:52:51 +0800
Message-Id: <20220831005251.39427-1-yuanjilin@cdjrlc.com>
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
 arch/arm64/kvm/inject_fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
index f32f4a2a347f..92de0f817be4 100644
--- a/arch/arm64/kvm/inject_fault.c
+++ b/arch/arm64/kvm/inject_fault.c
@@ -155,7 +155,7 @@ void kvm_inject_size_fault(struct kvm_vcpu *vcpu)
 	 * Size Fault at level 0, as if exceeding PARange.
 	 *
 	 * Non-LPAE guests will only get the external abort, as there
-	 * is no way to to describe the ASF.
+	 * is no way to describe the ASF.
 	 */
 	if (vcpu_el1_is_32bit(vcpu) &&
 	    !(vcpu_read_sys_reg(vcpu, TCR_EL1) & TTBCR_EAE))
-- 
2.36.1

