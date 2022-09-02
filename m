Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24306ECAAD5
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Sep 2022 15:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237500AbiIBPyi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Sep 2022 11:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237290AbiIBPyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:54:03 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECE0C00FE;
        Fri,  2 Sep 2022 08:48:28 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662133706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z1HCozkzwfIh/WZyb+NtoFOxgqJRCNjqWxITkulBgAA=;
        b=Nx6UGSdktchEET1RnJWXOP+1+Pjv7UWJ5/VVcLwlqvGVbmo/t5wu87tgpIw5LueDaV9daB
        po0ZycNkeVWfnKo2tbc4VjQNKFctHE64dygOXOswJV/4c/CGqRX9ONi/0rdLr21vxRmJd3
        hmaLRseh2qpln0+uf7J3ThDIe28+M4o=
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, Reiji Watanabe <reijiw@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] KVM: arm64: Spin off helper for calling visibility hook
Date:   Fri,  2 Sep 2022 15:48:00 +0000
Message-Id: <20220902154804.1939819-5-oliver.upton@linux.dev>
In-Reply-To: <20220902154804.1939819-1-oliver.upton@linux.dev>
References: <20220902154804.1939819-1-oliver.upton@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change intended.

Reviewed-by: Reiji Watanabe <reijiw@google.com>
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kvm/sys_regs.h | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
index a8c4cc32eb9a..e78b51059622 100644
--- a/arch/arm64/kvm/sys_regs.h
+++ b/arch/arm64/kvm/sys_regs.h
@@ -136,22 +136,25 @@ static inline void reset_val(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r
 	__vcpu_sys_reg(vcpu, r->reg) = r->val;
 }
 
-static inline bool sysreg_hidden(const struct kvm_vcpu *vcpu,
-				 const struct sys_reg_desc *r)
+static inline unsigned int sysreg_visibility(const struct kvm_vcpu *vcpu,
+					     const struct sys_reg_desc *r)
 {
 	if (likely(!r->visibility))
-		return false;
+		return 0;
 
-	return r->visibility(vcpu, r) & REG_HIDDEN;
+	return r->visibility(vcpu, r);
+}
+
+static inline bool sysreg_hidden(const struct kvm_vcpu *vcpu,
+				 const struct sys_reg_desc *r)
+{
+	return sysreg_visibility(vcpu, r) & REG_HIDDEN;
 }
 
 static inline bool sysreg_visible_as_raz(const struct kvm_vcpu *vcpu,
 					 const struct sys_reg_desc *r)
 {
-	if (likely(!r->visibility))
-		return false;
-
-	return r->visibility(vcpu, r) & REG_RAZ;
+	return sysreg_visibility(vcpu, r) & REG_RAZ;
 }
 
 static inline int cmp_sys_reg(const struct sys_reg_desc *i1,
-- 
2.37.2.789.g6183377224-goog

