Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD5EC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Mar 2022 06:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241769AbiCKGCG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Mar 2022 01:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346800AbiCKFzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:55:13 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851F71066EA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:54:01 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d11b6259adso60482517b3.19
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Kn/HnA5rR+b1ag9HSM3XGXZfT8rvt/Eg3GcAJHw/mwc=;
        b=To+kc8mPWMuTU0J3rBkWWZBpyfgOSAgRZOVDkBwlYBknya5lBPmbV5FMVCZje9xAVJ
         SVEgTthX6hSVrSCoCZ0R+xx2HOY3QYY4/OtR/utdM4gpBGD+sKoZX91lEePDUVFvhcsV
         h2rfnLo+Hf74WSVn00o/OAcUOQncgHxH5RzI2/kVV30RDOBj8kRLJ6Hdp2SGoYoZ7i7k
         H8OngS10d1mIye2c3BV89ILh5nMYpYTAHcJjEy7S5RGwgfENuyg5oMiulWXuba8Xj0Ly
         ncWiQLgiQt0WXUug5XJhaaB0QcmvkOSQoILOhIRJONx7252t7/lDzUaeH1U/m5d2qqls
         0Cdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Kn/HnA5rR+b1ag9HSM3XGXZfT8rvt/Eg3GcAJHw/mwc=;
        b=8HzyvMIl+1BORmForz3+miF1lfk8t73mdPptZtD9FlwXx8qKcQsADrjOliDuj0KV+y
         mbEVILJT0s5hfu2reBQN7o5KCWK3BZq9YhKrNUk1QDCzcnskqbvbNsiD8p5oOXpswhBL
         MeIAVPGmRcDnrkT+wam8i3jQcvCEHe2Elh8alkQv3jnyrHfEOZdN2jJV543XwuBlDHL+
         RDx7NLZJTSYED6CbML0UKp7Cq8i9fYa5hqujVYA9mppy/SyrA6/SUPNlF8kyLX7kY/fB
         9a4XFB+dONVud4mnXzpoOAjuGGf41J9eoVW2jy+UiY/yzEPLv3ERY+PgbVJScTvYVFnZ
         nvVA==
X-Gm-Message-State: AOAM532fz5eLq4s8WaN+Qedyu6Es703pS3yTXiw6ReKDxO17l4biCXhW
        GT2/Uufc9+p2b1q/rohjiqY4GtqxHJoPXhRr3ioDBwn1BlDSco6yGQASEn6/EkvU66huc7z9OJB
        REORXM8sx8wEH1xQ2PnftL62SLbKIP4cgNTAdklvhwOqEHYcuySEBnubDcGhUtJojpWZkyQ==
X-Google-Smtp-Source: ABdhPJzb3JaM3NIYmSjttXrygqxsxgmsx+EuLMO3oY7c2t/ukX+yIJy+FFYKILEBWMwMkDkhGjyYFtEOV3k=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a0d:dbca:0:b0:2dc:f1ff:2676 with SMTP id
 d193-20020a0ddbca000000b002dcf1ff2676mr6971988ywe.165.1646978040602; Thu, 10
 Mar 2022 21:54:00 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:55 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-105-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 104/105] KVM: selftests: Remove vcpu_state() helper
From:   Sean Christopherson <seanjc@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     |  1 -
 tools/testing/selftests/kvm/lib/kvm_util.c    | 21 ++-----------------
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 6d46261432cb..f6926ab277d3 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -286,7 +286,6 @@ void *addr_gva2hva(struct kvm_vm *vm, vm_vaddr_t gva);
 vm_paddr_t addr_hva2gpa(struct kvm_vm *vm, void *hva);
 void *addr_gpa2alias(struct kvm_vm *vm, vm_paddr_t gpa);
 
-struct kvm_run *vcpu_state(struct kvm_vcpu *vcpu);
 void vcpu_run(struct kvm_vcpu *vcpu);
 int _vcpu_run(struct kvm_vcpu *vcpu);
 
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index b86c8b0883ad..7f82c6ba2a37 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -995,19 +995,7 @@ void vm_mem_region_delete(struct kvm_vm *vm, uint32_t slot)
 	__vm_mem_region_delete(vm, memslot2region(vm, slot), true);
 }
 
-/*
- * VCPU mmap Size
- *
- * Input Args: None
- *
- * Output Args: None
- *
- * Return:
- *   Size of VCPU state
- *
- * Returns the size of the structure pointed to by the return value
- * of vcpu_state().
- */
+/* Returns the size of a vCPU's kvm_run structure. */
 static int vcpu_mmap_sz(void)
 {
 	int dev_fd, ret;
@@ -1061,7 +1049,7 @@ struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
 		vcpu_mmap_sz(), sizeof(*vcpu->run));
 	vcpu->run = (struct kvm_run *) mmap(NULL, vcpu_mmap_sz(),
 		PROT_READ | PROT_WRITE, MAP_SHARED, vcpu->fd, 0);
-	TEST_ASSERT(vcpu->run != MAP_FAILED, "mmap vcpu_state failed, "
+	TEST_ASSERT(vcpu->run != MAP_FAILED, "mmap kvm_run page failed, "
 		"vcpu id: %u errno: %i", vcpu_id, errno);
 
 	/* Add to linked-list of VCPUs. */
@@ -1390,11 +1378,6 @@ void vm_create_irqchip(struct kvm_vm *vm)
 
 	vm->has_irqchip = true;
 }
-struct kvm_run *vcpu_state(struct kvm_vcpu *vcpu)
-{
-	return vcpu->run;
-}
-
 
 int _vcpu_run(struct kvm_vcpu *vcpu)
 {
-- 
2.35.1.723.g4982287a31-goog

