Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E82C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 16:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244418AbiCJQrx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 11:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244187AbiCJQrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:47:31 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A808B198D2C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 08:46:20 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id z13-20020a1709027e8d00b001518de7a06cso2971153pla.14
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 08:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OmK9ig5jJPqHc1lT2kwZLVXWHtYR0m8aDz/I++ZnaZg=;
        b=HdFmzmvSIq4czsk8EyXnKZqkaBCWAJbd0VwxsSv4+1Yw7/3bw6MYRa7aMqdk0mV1e1
         VHNRH9xx/5Te44HQJHZxuyptGPbnXf/j+pXB8dusDq5udVzrfFDbXHWHGiOxW42yBKen
         taetvPR9Zt8E8HQhExhww8N+Q6aj4bq83pNPzWJvmGhzYl+GVOBOWmdrug0kgrir4KZz
         L6/euPHhjKO+W6ssAnsgPJ21R2zI0j4v2cB3usLUUpZK8YA/1cRRoCXlU3X5FAklbDdX
         P1J5k3k7z+EPGWsSylCef3Wx0ns0t++tyYbzx6fhn5LJuHFXaBPNV8cRK6oFrWrcojdz
         pcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OmK9ig5jJPqHc1lT2kwZLVXWHtYR0m8aDz/I++ZnaZg=;
        b=Caq70BoX5IWdUW9C/rvPcfO4intxqlLcIRyAUa1uQBtxGLaufeZwH3OoeDCn1G8DgD
         nAFEtk8rLQN6cydiuFSBFbMwx3LxNdhyA4CXAAzg5zt6RMEIlOy5Kx/Kqg326VQaCi5d
         oWXb0qwW6E304nCA7B8Sqva1z0WMQAXP9g35cusOZMY0miSurHpTY16XC2xi7tiB1TqR
         ExE7E2s0JwgwxtESwLyC6m3k1mwHfnaDLLLhifh+DIjMsF4sVt/1OhOOciOehBgYUGQi
         hWeMOkgYvmIRZftGBezpnbsZtHFgDaQwCffN4Yosw5aZox+e0rF4QJKu3TXVRoD5P2lY
         +QHQ==
X-Gm-Message-State: AOAM533GPAl0yI5EVJe5NSjr4uLPdODDIvy5piCkSGtU/dvawiKgSyKm
        DaiHMR0MacibSkojSCzCn64VnCB+RTj8G3CMV/GoImsqTh+LMI3HWkNCf+/a9D7nF6pwOde9CXL
        TBYslbL9Ya+tjyyYcMFzGHklnP7DS8IyCQ0G0jJQ+5YQjiPT+kTBNEsjxSupUhLZM2ZKHJ4Vf
X-Google-Smtp-Source: ABdhPJwrSHkEApdTW6RNQ1Yq3YoC+LnnBLVKJr3xZgwX2aqe4qJL7KcpDIGjBo9jF5gVpEqZyPMtdxBy110l
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:2d58:733f:1853:8e86])
 (user=bgardon job=sendgmr) by 2002:a17:90b:1e10:b0:1bf:6c78:54a9 with SMTP id
 pg16-20020a17090b1e1000b001bf6c7854a9mr94496pjb.1.1646930779582; Thu, 10 Mar
 2022 08:46:19 -0800 (PST)
Date:   Thu, 10 Mar 2022 08:45:31 -0800
In-Reply-To: <20220310164532.1821490-1-bgardon@google.com>
Message-Id: <20220310164532.1821490-13-bgardon@google.com>
Mime-Version: 1.0
References: <20220310164532.1821490-1-bgardon@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH 12/13] KVM: x86/MMU: Require reboot permission to disable NX hugepages
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that the userspace actor attempting to disable NX hugepages has
permission to reboot the system. Since disabling NX hugepages would
allow a guest to crash the system, it is similar to reboot permissions.

This approach is the simplest permission gating, but passing a file
descriptor opened for write for the module parameter would also work
well and be more precise.
The latter approach was suggested by Sean Christopherson.

Suggested-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/x86.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 74351cbb9b5b..995f30667619 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4256,7 +4256,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_SYS_ATTRIBUTES:
 	case KVM_CAP_VAPIC:
 	case KVM_CAP_ENABLE_CAP:
-	case KVM_CAP_VM_DISABLE_NX_HUGE_PAGES:
 		r = 1;
 		break;
 	case KVM_CAP_EXIT_HYPERCALL:
@@ -4359,6 +4358,14 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_DISABLE_QUIRKS2:
 		r = KVM_X86_VALID_QUIRKS;
 		break;
+	case KVM_CAP_VM_DISABLE_NX_HUGE_PAGES:
+		/*
+		 * Since the risk of disabling NX hugepages is a guest crashing
+		 * the system, ensure the userspace process has permission to
+		 * reboot the system.
+		 */
+		r = capable(CAP_SYS_BOOT);
+		break;
 	default:
 		break;
 	}
@@ -6050,6 +6057,15 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		mutex_unlock(&kvm->lock);
 		break;
 	case KVM_CAP_VM_DISABLE_NX_HUGE_PAGES:
+		/*
+		 * Since the risk of disabling NX hugepages is a guest crashing
+		 * the system, ensure the userspace process has permission to
+		 * reboot the system.
+		 */
+		if (!capable(CAP_SYS_BOOT)) {
+			r = -EPERM;
+			break;
+		}
 		kvm->arch.disable_nx_huge_pages = true;
 		kvm_update_nx_huge_pages(kvm);
 		r = 0;
-- 
2.35.1.616.g0bdcbb4464-goog

