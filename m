Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF62C433FE
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 07:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240004AbiDNHni (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 03:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240469AbiDNHmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 03:42:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AADB153B5E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 00:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649922006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TQg7Ua0bJk+YwKnS1MCtplfhaMC9mBP41uxMhcpldzI=;
        b=WBVHdaz6zwDOLn8oT8POOyMwNsGI7RTzMenizS2dfriUXjX6VOttExQLjJFScp6CYYbliS
        l2EGONLUHkhkmbZemsp5bvJHpuixCYi8+FPWcPhh2W4qe9b6jaFJ8OwLUsAIwtCbYfRD1G
        WcV6/aArMn/nY3qjFhnZP9E5MWJVoV8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-571-TQAA5U6hM0KMVUYQyA2iJA-1; Thu, 14 Apr 2022 03:40:02 -0400
X-MC-Unique: TQAA5U6hM0KMVUYQyA2iJA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8284538149B7;
        Thu, 14 Apr 2022 07:40:02 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 654AD40D1DB;
        Thu, 14 Apr 2022 07:40:02 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     seanjc@google.com
Subject: [PATCH 08/22] KVM: x86/mmu: do not recompute root level from kvm_mmu_role_regs
Date:   Thu, 14 Apr 2022 03:39:46 -0400
Message-Id: <20220414074000.31438-9-pbonzini@redhat.com>
In-Reply-To: <20220414074000.31438-1-pbonzini@redhat.com>
References: <20220414074000.31438-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The root_level can be found in the cpu_role (in fact the field
is superfluous and could be removed, but one thing at a time).
Since there is only one usage left of role_regs_to_root_level,
inline it into kvm_calc_cpu_role.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 0f8c4d8f2081..1ba452df8e67 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -245,19 +245,6 @@ static struct kvm_mmu_role_regs vcpu_to_role_regs(struct kvm_vcpu *vcpu)
 	return regs;
 }
 
-static int role_regs_to_root_level(const struct kvm_mmu_role_regs *regs)
-{
-	if (!____is_cr0_pg(regs))
-		return 0;
-	else if (____is_efer_lma(regs))
-		return ____is_cr4_la57(regs) ? PT64_ROOT_5LEVEL :
-					       PT64_ROOT_4LEVEL;
-	else if (____is_cr4_pae(regs))
-		return PT32E_ROOT_LEVEL;
-	else
-		return PT32_ROOT_LEVEL;
-}
-
 static inline bool kvm_available_flush_tlb_with_range(void)
 {
 	return kvm_x86_ops.tlb_remote_flush_with_range;
@@ -4725,7 +4712,14 @@ kvm_calc_cpu_role(struct kvm_vcpu *vcpu, const struct kvm_mmu_role_regs *regs)
 	role.base.smep_andnot_wp = ____is_cr4_smep(regs) && !____is_cr0_wp(regs);
 	role.base.smap_andnot_wp = ____is_cr4_smap(regs) && !____is_cr0_wp(regs);
 	role.base.has_4_byte_gpte = !____is_cr4_pae(regs);
-	role.base.level = role_regs_to_root_level(regs);
+
+	if (____is_efer_lma(regs))
+		role.base.level = ____is_cr4_la57(regs) ? PT64_ROOT_5LEVEL
+							: PT64_ROOT_4LEVEL;
+	else if (____is_cr4_pae(regs))
+		role.base.level = PT32E_ROOT_LEVEL;
+	else
+		role.base.level = PT32_ROOT_LEVEL;
 
 	role.ext.cr0_pg = 1;
 	role.ext.cr4_pae = ____is_cr4_pae(regs);
@@ -4817,7 +4811,7 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu,
 	context->get_guest_pgd = get_cr3;
 	context->get_pdptr = kvm_pdptr_read;
 	context->inject_page_fault = kvm_inject_page_fault;
-	context->root_level = role_regs_to_root_level(regs);
+	context->root_level = cpu_role.base.level;
 
 	if (!is_cr0_pg(context))
 		context->gva_to_gpa = nonpaging_gva_to_gpa;
-- 
2.31.1


