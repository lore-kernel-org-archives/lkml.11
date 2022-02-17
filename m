Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CD4C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Feb 2022 21:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244587AbiBQVEV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Feb 2022 16:04:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbiBQVEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 16:04:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7533615F62F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 13:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645131827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vLJOjKLZ39eFv5+IT8kSwjIWjbjOHHgriRQmWUrdZO4=;
        b=gpdMXMhHeCEYQGvACxXYeF259FJyNjJ0LRvBqbymHOhsbFwlNBttJ1ZVhiMUSXlOWrDbHo
        Pweo/46pL5KpbY7y11QJ0ibFBc6d957vaG+Z7C9a9HbLIrWY//qfC8lVSapsyLL/285n6O
        4jz+zhhJYhro7NF88eIJDo2Su0h7XLY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-NlK-EqKMMwa3o5ycz1cgAw-1; Thu, 17 Feb 2022 16:03:44 -0500
X-MC-Unique: NlK-EqKMMwa3o5ycz1cgAw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9CDF1006AA0;
        Thu, 17 Feb 2022 21:03:42 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8BEB146982;
        Thu, 17 Feb 2022 21:03:42 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     seanjc@google.com
Subject: [PATCH v2 03/18] KVM: x86/mmu: WARN if PAE roots linger after kvm_mmu_unload
Date:   Thu, 17 Feb 2022 16:03:25 -0500
Message-Id: <20220217210340.312449-4-pbonzini@redhat.com>
In-Reply-To: <20220217210340.312449-1-pbonzini@redhat.com>
References: <20220217210340.312449-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 296f8723f9ae..a67071ac80f3 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5086,12 +5086,21 @@ int kvm_mmu_load(struct kvm_vcpu *vcpu)
 	return r;
 }
 
+static void __kvm_mmu_unload(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu)
+{
+	int i;
+	kvm_mmu_free_roots(vcpu, mmu, KVM_MMU_ROOTS_ALL);
+	WARN_ON(VALID_PAGE(mmu->root_hpa));
+	if (mmu->pae_root) {
+		for (i = 0; i < 4; ++i)
+			WARN_ON(IS_VALID_PAE_ROOT(mmu->pae_root[i]));
+	}
+}
+
 void kvm_mmu_unload(struct kvm_vcpu *vcpu)
 {
-	kvm_mmu_free_roots(vcpu, &vcpu->arch.root_mmu, KVM_MMU_ROOTS_ALL);
-	WARN_ON(VALID_PAGE(vcpu->arch.root_mmu.root_hpa));
-	kvm_mmu_free_roots(vcpu, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);
-	WARN_ON(VALID_PAGE(vcpu->arch.guest_mmu.root_hpa));
+	__kvm_mmu_unload(vcpu, &vcpu->arch.root_mmu);
+	__kvm_mmu_unload(vcpu, &vcpu->arch.guest_mmu);
 }
 
 static bool need_remote_flush(u64 old, u64 new)
-- 
2.31.1


