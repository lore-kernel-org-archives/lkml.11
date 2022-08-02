Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18104C19F2A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Aug 2022 03:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbiHBDZv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Aug 2022 23:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbiHBDZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 23:25:47 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081441D314
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 20:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659410746; x=1690946746;
  h=from:to:cc:subject:date:message-id;
  bh=NdbJ7zf1SfiGOH/1M9cvWTIL/jGK+HzFM0iVm87h3Uc=;
  b=S7lVi073cbDxw1doZumDFijGNhLEbtPBfE1aUIPX4381gVlrHJ8cgTls
   90/DmEJQocld+t1seFW1WSaZj7B5L3lLtD6hGyqda19JQLBZEwo+RCJe9
   FYIE3fxKAemZev1NYOmMkzKfT0/CsWttw6oEz+qKHzF5LGfwKQ/+1kb7I
   VY2cCyLL/NYJtg7pn5c3amdJ78wMJ9aJ+lc7II7MzxhNDi6tQgOchezGt
   9/CoKYQ8BuXHtEwCBqtc7q0IkZqZOVEJ4sakOuiieQUsiiU+I+GcbDvdH
   frBSpuR8VX0V98b89iAiSwOKcKGeVQ2oILVPI8kkyDIEd1bS6il22V/QR
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="288067237"
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="288067237"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 20:25:38 -0700
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="661443687"
Received: from chenyi-pc.sh.intel.com ([10.239.159.73])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 20:25:36 -0700
From:   Chenyi Qiang <chenyi.qiang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     Chenyi Qiang <chenyi.qiang@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [RESEND] x86/bus_lock: Don't assume the init value of DEBUGCTLMSR.BUS_LOCK_DETECT to be zero
Date:   Tue,  2 Aug 2022 11:32:06 +0800
Message-Id: <20220802033206.21333-1-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible that BIOS/firmware has set DEBUGCTLMSR_BUS_LOCK_DETECT, or
this kernel has been kexec'd from a kernel that enabled bus lock
detection.

Disable bus lock detection explicitly if not wanted.

Fixes: ebb1064e7c2e ("x86/traps: Handle #DB for bus lock")
Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/intel.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index fd5dead8371c..cb796ca6eff5 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1216,22 +1216,23 @@ static void bus_lock_init(void)
 {
 	u64 val;
 
-	/*
-	 * Warn and fatal are handled by #AC for split lock if #AC for
-	 * split lock is supported.
-	 */
-	if (!boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT) ||
-	    (boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT) &&
-	    (sld_state == sld_warn || sld_state == sld_fatal)) ||
-	    sld_state == sld_off)
+	if (!boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))
 		return;
 
-	/*
-	 * Enable #DB for bus lock. All bus locks are handled in #DB except
-	 * split locks are handled in #AC in the fatal case.
-	 */
 	rdmsrl(MSR_IA32_DEBUGCTLMSR, val);
-	val |= DEBUGCTLMSR_BUS_LOCK_DETECT;
+
+	if ((boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT) &&
+	    (sld_state == sld_warn || sld_state == sld_fatal)) ||
+	    sld_state == sld_off) {
+		/*
+		 * Warn and fatal are handled by #AC for split lock if #AC for
+		 * split lock is supported.
+		 */
+		val &= ~DEBUGCTLMSR_BUS_LOCK_DETECT;
+	} else {
+		val |= DEBUGCTLMSR_BUS_LOCK_DETECT;
+	}
+
 	wrmsrl(MSR_IA32_DEBUGCTLMSR, val);
 }
 
-- 
2.17.1

