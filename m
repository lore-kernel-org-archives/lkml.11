Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0737C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Jul 2022 13:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiGANTz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Jul 2022 09:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiGANTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 09:19:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FA65C9FF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 06:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656681592; x=1688217592;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZqMGSZjFjyARnxG8NRGlZuwYjYY/VNl/v/wu27Gtvtw=;
  b=UygUvGo5lk2Ax0rfVE9Eyyb3OVaTSVGpwp5mSOrz0rHdNNjBT6qkhfi1
   PZ2x6093FT0XHnCkcq1er65U10KAhkczR5WEOyo/sH5/d6BFe8nISeTN7
   1TTgmAn7yPAO8B9M2XOjD5jyY7/I41D4domoQ6WfcPBgl9wjw9UI70vWB
   rSBW23C70VF5Igo1XXVcDkTjz6bCLkmdM+zFVsJybRZYMPGCfd1cpPnoa
   oMN4eteovzNP0l5TLbAWywKxMeQQAlPxG0upZRFSuf1J8LrxeKEhooo6i
   FAz81VaYTWGST8/YSf0C1YCZvHK22fdFrh4IYya12OjBFnD5P3idoHyo5
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="283382772"
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="283382772"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 06:19:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="681400926"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Jul 2022 06:19:43 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Ingo Molnar" <mingo@redhat.com>, "Tony Luck" <tony.luck@intel.com>
Cc:     "x86" <x86@kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH] x86/split_lock: Enable the split lock detect feature on Raptor Lake P and Alder Lake N CPUs
Date:   Fri,  1 Jul 2022 06:19:58 -0700
Message-Id: <20220701131958.687066-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These CPU models support the split lock detect feature. Add them to
the x86_cpu_ids match table.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
This patch supersedes the earlier:
https://lore.kernel.org/lkml/20220609193549.2725612-1-fenghua.yu@intel.com/
that just added Raptor Lake P.

 arch/x86/kernel/cpu/intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index fd5dead8371c..5afb7d3d248d 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1290,6 +1290,8 @@ static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		1),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		1),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		1),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,	1),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		1),
 	{}
 };
 
-- 
2.32.0

