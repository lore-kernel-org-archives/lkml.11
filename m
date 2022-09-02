Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAFEC38145
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Sep 2022 15:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237516AbiIBPyp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Sep 2022 11:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237358AbiIBPyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:54:13 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBE7C59E6;
        Fri,  2 Sep 2022 08:48:31 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662133709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/op3CBEinkvTvgamMVY4adnisAOglI/j+DprQ1jnwLs=;
        b=vSJYzQjTn5JiKKoXkIZFS6sZAL8nglhzH3m1Cc/56eVqKV0nSy+FT02abLWZ1L6hrzWu90
        z6eh3xL6WzqfhvTScyYCtYflkQOkDIV6H5YWago7Roz7+NyW2+R+fbnntKdIR6URj8iMNY
        jDvRIPaeT6UQFQOPBdmyO5uF3ll3Fvo=
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
Subject: [PATCH v2 5/7] KVM: arm64: Add a visibility bit to ignore user writes
Date:   Fri,  2 Sep 2022 15:48:01 +0000
Message-Id: <20220902154804.1939819-6-oliver.upton@linux.dev>
In-Reply-To: <20220902154804.1939819-1-oliver.upton@linux.dev>
References: <20220902154804.1939819-1-oliver.upton@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're about to ignore writes to AArch32 ID registers on AArch64-only
systems. Add a bit to indicate a register is handled as write ignore
when accessed from userspace.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kvm/sys_regs.c | 3 +++
 arch/arm64/kvm/sys_regs.h | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 0e20a311ea20..6d0511247df4 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2775,6 +2775,9 @@ int kvm_sys_reg_set_user(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg,
 	if (!r)
 		return -ENOENT;
 
+	if (sysreg_user_write_ignore(vcpu, r))
+		return 0;
+
 	if (r->set_user) {
 		ret = (r->set_user)(vcpu, r, val);
 	} else {
diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
index e78b51059622..e4ebb3a379fd 100644
--- a/arch/arm64/kvm/sys_regs.h
+++ b/arch/arm64/kvm/sys_regs.h
@@ -86,6 +86,7 @@ struct sys_reg_desc {
 
 #define REG_HIDDEN		(1 << 0) /* hidden from userspace and guest */
 #define REG_RAZ			(1 << 1) /* RAZ from userspace and guest */
+#define REG_USER_WI		(1 << 2) /* WI from userspace only */
 
 static __printf(2, 3)
 inline void print_sys_reg_msg(const struct sys_reg_params *p,
@@ -157,6 +158,12 @@ static inline bool sysreg_visible_as_raz(const struct kvm_vcpu *vcpu,
 	return sysreg_visibility(vcpu, r) & REG_RAZ;
 }
 
+static inline bool sysreg_user_write_ignore(const struct kvm_vcpu *vcpu,
+					    const struct sys_reg_desc *r)
+{
+	return sysreg_visibility(vcpu, r) & REG_USER_WI;
+}
+
 static inline int cmp_sys_reg(const struct sys_reg_desc *i1,
 			      const struct sys_reg_desc *i2)
 {
-- 
2.37.2.789.g6183377224-goog

