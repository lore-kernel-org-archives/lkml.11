Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAFBC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 17:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350755AbiCORy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 13:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243256AbiCORy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 13:54:26 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599BE36B5E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 10:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647366794; x=1678902794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=wgw89/KbE8/fDa0O3WtJo0hp+pWvd+G9xM2eOgyS4ws=;
  b=m7VDlBOuwX3xM9duNymLjRWNMApcV/9R0XDwaTW922cpOXQdidtzE1R/
   5nyJxMtPrYu+y2d7DMd1N2BR5pb4DA1eUgTgtfFXhDh0y0bwkKvqBdtn4
   mBy+Vblp90kvcnPQG6TNtdSyNNtZL/rOb9VFLmS+hgkQTKLNPVkJNNDdS
   M47Gm/2Yc24B3Fl4EyoVaHx7LWyL7lbWVJHiIQhVGcw2gkEs6RcFl03sV
   l1a5gqwaD02ogGBUz3obzzMzrmtl2+Vd4pflQCOMlsfkwi+tV0v4R4DCc
   PrCBBOlBt+Hyu9rEhpM9w7jufKzIlkL+uzBIEZm2gLtZJmtWCng4UWUr5
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="281158681"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="281158681"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 10:46:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="613358409"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by fmsmga004.fm.intel.com with ESMTP; 15 Mar 2022 10:46:37 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kan Liang <kan.liang@intel.com>
Subject: [PATCH V2 4/4] perf/x86/uncore: Add Raptor Lake uncore support
Date:   Tue, 15 Mar 2022 10:46:00 -0700
Message-Id: <1647366360-82824-4-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1647366360-82824-1-git-send-email-kan.liang@linux.intel.com>
References: <1647366360-82824-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@intel.com>

The uncore PMU of the Raptor Lake is the same as Alder Lake.
Add new PCIIDs of IMC for Raptor Lake.

Signed-off-by: Kan Liang <kan.liang@intel.com>
---

Changes since V1:
- Add one more PCIID 

 arch/x86/events/intel/uncore.c     |  1 +
 arch/x86/events/intel/uncore_snb.c | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index e497da9..7695dca 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1828,6 +1828,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&rkl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&adl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&adl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&adl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&snr_uncore_init),
 	{},
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index f698a55..4262351 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -79,6 +79,10 @@
 #define PCI_DEVICE_ID_INTEL_ADL_14_IMC		0x4650
 #define PCI_DEVICE_ID_INTEL_ADL_15_IMC		0x4668
 #define PCI_DEVICE_ID_INTEL_ADL_16_IMC		0x4670
+#define PCI_DEVICE_ID_INTEL_RPL_1_IMC		0xA700
+#define PCI_DEVICE_ID_INTEL_RPL_2_IMC		0xA702
+#define PCI_DEVICE_ID_INTEL_RPL_3_IMC		0xA706
+#define PCI_DEVICE_ID_INTEL_RPL_4_IMC		0xA709
 
 /* SNB event control */
 #define SNB_UNC_CTL_EV_SEL_MASK			0x000000ff
@@ -1406,6 +1410,22 @@ static const struct pci_device_id tgl_uncore_pci_ids[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ADL_16_IMC),
 		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
 	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_RPL_1_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_RPL_2_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_RPL_3_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_RPL_4_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
 	{ /* end: all zeroes */ }
 };
 
-- 
2.7.4

