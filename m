Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB45C25B08
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Aug 2022 06:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245636AbiHTGBm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Aug 2022 02:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244404AbiHTGAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 02:00:52 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E2FA262F;
        Fri, 19 Aug 2022 23:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660975251; x=1692511251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aW3CSh7QaSGHtsfiFbSKKW1Df9z424fLpULpazmR+PQ=;
  b=c7XkvdSEG8flaPB5IPxWY8MFdnTTv0ediaffw4S9VWqzOHCaI/Y65QAi
   C9RPvCbTl7JGrqygcFJNCGP8eHYQDKxWwnhJM0FRCNshQ1+hINzAzFuc0
   Ln4RJcp01ycYd83TzaaebCDq4eUTgNoXqdQwA4Oxf4vsMwA8NZ29CIO0i
   K3nTNh28pwBGuAI4e9ttbQt4D7MUAoDcW8yejqTS3vcRaqG9/g6t8RQr/
   nKOmGhqejufdLFLHXXw47ekYBwKii47nXGzRJPb7ND80bBcnkaSfJ4vW5
   PavFzQp2RJBDo0RTZT0XSrH75cb2UabmV0FUuFpftgt6iyq8RmQs/LQyI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10444"; a="379448975"
X-IronPort-AV: E=Sophos;i="5.93,250,1654585200"; 
   d="scan'208";a="379448975"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 23:00:49 -0700
X-IronPort-AV: E=Sophos;i="5.93,250,1654585200"; 
   d="scan'208";a="668857538"
Received: from ls.sc.intel.com (HELO localhost) ([143.183.96.54])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 23:00:49 -0700
From:   isaku.yamahata@intel.com
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@intel.com, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Kai Huang <kai.huang@intel.com>, Chao Gao <chao.gao@intel.com>,
        Will Deacon <will@kernel.org>
Subject: [RFC PATCH 09/18] KVM: kvm_arch.c: Remove a global variable, hardware_enable_failed
Date:   Fri, 19 Aug 2022 23:00:15 -0700
Message-Id: <a05b171a7b40beed00a0c7ec9dbb26b71a2d35c5.1660974106.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660974106.git.isaku.yamahata@intel.com>
References: <cover.1660974106.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Isaku Yamahata <isaku.yamahata@intel.com>

A global variable hardware_enable_failed in kvm_arch.c is used only by
kvm_arch_add_vm() and hardware_enable().  It doesn't have to be a global
variable.  Make it function local.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 virt/kvm/kvm_arch.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/virt/kvm/kvm_arch.c b/virt/kvm/kvm_arch.c
index 8a5d88b02aab..2ed8de0591c9 100644
--- a/virt/kvm/kvm_arch.c
+++ b/virt/kvm/kvm_arch.c
@@ -13,14 +13,13 @@
 #include <linux/kvm_host.h>
 
 static cpumask_t cpus_hardware_enabled = CPU_MASK_NONE;
-static atomic_t hardware_enable_failed;
 
 __weak int kvm_arch_post_init_vm(struct kvm *kvm)
 {
 	return 0;
 }
 
-static void hardware_enable(void *junk)
+static int __hardware_enable(void)
 {
 	int cpu = raw_smp_processor_id();
 	int r;
@@ -28,17 +27,21 @@ static void hardware_enable(void *junk)
 	WARN_ON_ONCE(preemptible());
 
 	if (cpumask_test_cpu(cpu, &cpus_hardware_enabled))
-		return;
-
-	cpumask_set_cpu(cpu, &cpus_hardware_enabled);
-
+		return 0;
 	r = kvm_arch_hardware_enable();
-
-	if (r) {
-		cpumask_clear_cpu(cpu, &cpus_hardware_enabled);
-		atomic_inc(&hardware_enable_failed);
+	if (r)
 		pr_info("kvm: enabling virtualization on CPU%d failed\n", cpu);
-	}
+	else
+		cpumask_set_cpu(cpu, &cpus_hardware_enabled);
+	return r;
+}
+
+static void hardware_enable(void *arg)
+{
+	atomic_t *failed = arg;
+
+	if (__hardware_enable())
+		atomic_inc(failed);
 }
 
 static void hardware_disable(void *junk)
@@ -64,15 +67,16 @@ __weak void kvm_arch_pre_hardware_unsetup(void)
  */
 __weak int kvm_arch_add_vm(struct kvm *kvm, int usage_count)
 {
+	atomic_t failed;
 	int r = 0;
 
 	if (usage_count != 1)
 		return 0;
 
-	atomic_set(&hardware_enable_failed, 0);
-	on_each_cpu(hardware_enable, NULL, 1);
+	atomic_set(&failed, 0);
+	on_each_cpu(hardware_enable, &failed, 1);
 
-	if (atomic_read(&hardware_enable_failed)) {
+	if (atomic_read(&failed)) {
 		r = -EBUSY;
 		goto err;
 	}
@@ -96,7 +100,7 @@ __weak int kvm_arch_del_vm(int usage_count)
 __weak int kvm_arch_online_cpu(unsigned int cpu, int usage_count)
 {
 	if (usage_count)
-		hardware_enable(NULL);
+		return __hardware_enable();
 	return 0;
 }
 
@@ -123,5 +127,5 @@ __weak int kvm_arch_suspend(int usage_count)
 __weak void kvm_arch_resume(int usage_count)
 {
 	if (usage_count)
-		hardware_enable(NULL);
+		(void)__hardware_enable();
 }
-- 
2.25.1

