Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866FDC433FE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Mar 2022 20:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiCDUKH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Mar 2022 15:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiCDUHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:07:37 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA8F63529;
        Fri,  4 Mar 2022 12:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646424119; x=1677960119;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VyVTYl2QIObZYA2SUsV6vz6ThrOPujJRwmRWCaxnBJA=;
  b=N3LUaS6KaR80+4zwHnbxvTXXXTroq7l6te5m1WHQteKGx3JM8/nnuo9r
   FMpenQc9hfsyOiYSGxLj2dx+kXpwNupw3NRxYgvSGmap32+q+wew50tgg
   FM7kp98soNAfOlHnbJr7rxNsNfq79sif1lfZxb3LwWH/0LA7RwxLNLM0j
   L/iK0vPh1bklVhuebFifrM4u+cSACCWmv5/U7VwTO5VFoCSCD/qu+gTBH
   jtirhKtCD3rp9rI6NqVnAdSVvxsJ7j210Kw7nMz8/xpD9IgExlBvl0WQR
   vCTBVlLQt9e2BGrMT4ojL75op6cDuHFxULpRk1rnvORk+OCef8fVo/h2P
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="253983441"
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="253983441"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 11:50:17 -0800
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="552344288"
Received: from ls.sc.intel.com (HELO localhost) ([143.183.96.54])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 11:50:17 -0800
From:   isaku.yamahata@intel.com
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@intel.com, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>, erdemaktas@google.com,
        Connor Kuehl <ckuehl@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [RFC PATCH v5 032/104] KVM: x86/mmu: introduce config for PRIVATE KVM MMU
Date:   Fri,  4 Mar 2022 11:48:48 -0800
Message-Id: <770235e7fed04229b81c334e2477374374cea901.1646422845.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1646422845.git.isaku.yamahata@intel.com>
References: <cover.1646422845.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Isaku Yamahata <isaku.yamahata@intel.com>

To Keep the case of non TDX intact, introduce a new config option for
private KVM MMU support.  At the moment, this is synonym for
CONFIG_INTEL_TDX_HOST && CONFIG_KVM_INTEL.  The new flag make it clear
that the config is only for x86 KVM MMU.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 arch/x86/kvm/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 2b1548da00eb..2db590845927 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -136,4 +136,8 @@ config KVM_MMU_AUDIT
 config KVM_EXTERNAL_WRITE_TRACKING
 	bool
 
+config KVM_MMU_PRIVATE
+	def_bool y
+	depends on INTEL_TDX_HOST && KVM_INTEL
+
 endif # VIRTUALIZATION
-- 
2.25.1

