Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFC5CCA483
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jun 2022 01:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241813AbiFCBBI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jun 2022 21:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240973AbiFCAuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 20:50:19 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672EB29CBE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 17:47:26 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id z186-20020a6233c3000000b00510a6bc2864so3490559pfz.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 17:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=l/OZjUL38jsfY4/DpTlZPtW8u7Bpzi8r+BXI9KSVCQ8=;
        b=nIEvPCDXk+dhtPWG/5txV/z74Hw6CBk6fS9BiJZ6DSvcXtK8IX/B77ecEXalkF1ok8
         euOlklsQ4pUc/BZDMwSBgm+ao4x6geiLUzOPRiec7ym15s7l5bBZQ0WATTB6IsXTPRCS
         kXbjfkBuTKGH3yNFvVZtatT9EXdvZX5kI6fhC5xyUz4Xlcj26iFvgdOUKoWNnuCBgYBu
         /X7IgPTI4ub5kDCcmx3658ZkrDMOuegZ8mUnklM2ywOJRF+KoFhhOn1NWIute1vBTKxF
         nGywyqh9zbyUBiuCm1gXqlVOZTOLD4N2k0RoizUz0RSCpZUS0Df6TyggGXHMc93JqDfL
         bXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=l/OZjUL38jsfY4/DpTlZPtW8u7Bpzi8r+BXI9KSVCQ8=;
        b=Sl+1eyAotcS39DdXuFMyeQkL5EOx9G3PfeTjqx9Y76aSsUUkQxhwWGKLWegmiXnROP
         m3+yvH48x6R16m3edrN1lxdl9ZUVTrQl/Ml7gIS6EDHCVA1ZiKy7Cz6cl3vYBTf80MBz
         mv+T/j1if77SIOD00LegE3trqvSyPBb/nbPSWOXeWtBOXoj3CAUgTvdz6+7nAE0fS74r
         3WPjjQipRyJsZLye8FE0IigS8glyot7QelcNJrkMLll3U0IsWXpsmi7E+bVK/1aMAxKh
         LTvNeT/69vyKyJrqC6E0gPMcriQ/KOwxXj6N6jPXQNWey5039yVJGqdRPRBgykaopG66
         dF5Q==
X-Gm-Message-State: AOAM531FIv5RJVynCuFCwCCrtgilo7GcDFsI5SxfdysLSLe90eHz4Mae
        UbGzb2y9532QqtpEnQ3nisvPjbhiPaE=
X-Google-Smtp-Source: ABdhPJwOrd21xozUkPSPipBTDUPDfGjWpV3moLecJ+b9YdF1JJEpxNgEGqyPUCWLXp4CF0pd9v+SdzWWRxE=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:aa7:888a:0:b0:518:a0b8:f5c1 with SMTP id
 z10-20020aa7888a000000b00518a0b8f5c1mr56039909pfe.46.1654217243828; Thu, 02
 Jun 2022 17:47:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Jun 2022 00:43:13 +0000
In-Reply-To: <20220603004331.1523888-1-seanjc@google.com>
Message-Id: <20220603004331.1523888-127-seanjc@google.com>
Mime-Version: 1.0
References: <20220603004331.1523888-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 126/144] KVM: selftests: Convert kvm_binary_stats_test away
 from vCPU IDs
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Track vCPUs by their 'struct kvm_vcpu' object in kvm_binary_stats_test,
not by their ID.  The per-vCPU helpers will soon take a vCPU instead of a
VM+vcpu_id pair.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/kvm_binary_stats_test.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/kvm_binary_stats_test.c b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
index 407e9ea8e6f3..dfc3cf531ced 100644
--- a/tools/testing/selftests/kvm/kvm_binary_stats_test.c
+++ b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
@@ -172,9 +172,9 @@ static void vm_stats_test(struct kvm_vm *vm)
 	TEST_ASSERT(fcntl(stats_fd, F_GETFD) == -1, "Stats fd not freed");
 }
 
-static void vcpu_stats_test(struct kvm_vm *vm, int vcpu_id)
+static void vcpu_stats_test(struct kvm_vcpu *vcpu)
 {
-	int stats_fd = vcpu_get_stats_fd(vm, vcpu_id);
+	int stats_fd = vcpu_get_stats_fd(vcpu->vm, vcpu->id);
 
 	stats_test(stats_fd);
 	close(stats_fd);
@@ -195,6 +195,7 @@ static void vcpu_stats_test(struct kvm_vm *vm, int vcpu_id)
 int main(int argc, char *argv[])
 {
 	int i, j;
+	struct kvm_vcpu **vcpus;
 	struct kvm_vm **vms;
 	int max_vm = DEFAULT_NUM_VM;
 	int max_vcpu = DEFAULT_NUM_VCPU;
@@ -220,17 +221,21 @@ int main(int argc, char *argv[])
 	/* Create VMs and VCPUs */
 	vms = malloc(sizeof(vms[0]) * max_vm);
 	TEST_ASSERT(vms, "Allocate memory for storing VM pointers");
+
+	vcpus = malloc(sizeof(struct kvm_vcpu *) * max_vm * max_vcpu);
+	TEST_ASSERT(vcpus, "Allocate memory for storing vCPU pointers");
+
 	for (i = 0; i < max_vm; ++i) {
 		vms[i] = vm_create_barebones();
 		for (j = 0; j < max_vcpu; ++j)
-			__vm_vcpu_add(vms[i], j);
+			vcpus[j * max_vcpu + i] = __vm_vcpu_add(vms[i], j);
 	}
 
 	/* Check stats read for every VM and VCPU */
 	for (i = 0; i < max_vm; ++i) {
 		vm_stats_test(vms[i]);
 		for (j = 0; j < max_vcpu; ++j)
-			vcpu_stats_test(vms[i], j);
+			vcpu_stats_test(vcpus[j * max_vcpu + i]);
 	}
 
 	for (i = 0; i < max_vm; ++i)
-- 
2.36.1.255.ge46751e96f-goog

